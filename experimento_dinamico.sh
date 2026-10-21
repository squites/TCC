##!/bin/bash
## experimento_dinamico.sh — análise dinâmica das sequências cumulativas de passes.
##
## Para cada step de cada sequência: compila a IR em binário nativo e mede, na
## MESMA execução:
##   - contadores de hardware (PMCs) via mperf  -> resultados_dinamico/<tag>.mperf.json
##   - potência da CPU via powermetrics         -> resultados_dinamico/<tag>.power.txt
## Requer sudo (mperf e powermetrics exigem root; a senha é pedida uma vez).
##
## Uso:    ./experimento_dinamico.sh
## Depois: python3 mede_dinamico.py
#
#set -u
#
#MPERF="tools/mperf/mperf-stat"
## 10 eventos = limite do M1 (2 fixos + 8 configuráveis).
## ATENÇÃO às counters_mask do a14 (/usr/share/kpep/a14.plist):
##   - mask 128 (só contador 7): no MÁXIMO 1 de INST_LDST/INST_INT_ALU/INST_INT_ST/
##     INST_SIMD_ALU/INST_ALL/RETIRE_UOP por medição
##   - mask 224 (contadores 5-7): INST_BRANCH, BRANCH_MISPRED_NONSPEC, INST_INT_LD, ...
##   - sem mask: demais eventos
## Restritos vêm PRIMEIRO na lista (o alocador é guloso, na ordem dada).
#EVENTOS="cycles,instructions,INST_LDST,INST_BRANCH,BRANCH_MISPRED_NONSPEC,MAP_SIMD_UOP,L1D_CACHE_MISS_LD,L1D_CACHE_MISS_ST,L1I_CACHE_MISS_DEMAND,L1D_TLB_MISS"
#DUR_ALVO=3.0        # segundos alvo por medição (janela boa p/ mperf e powermetrics)
#PM_INTERVALO=200    # ms entre amostras do powermetrics
## a janela do powermetrics é calculada por medição (sono + duração calibrada + margem)
#REPETICOES=5        # medições por IR única; a 1ª é warmup (descartada) e o resto vira mediana
#RESFRIAMENTO=3      # s ocioso entre reps — sem pausa a carga contínua leva o SoC a >100°C
#                    # (throttle), o que além de inviável corrompe as medições
#
#BENCHMARKS="matmul_stress" # fonte: benchmarks/<nome>.c (somente benchmarks de arquivo único)
#
#mkdir -p ir_opt_dyn resultados_dinamico
#
#if [ ! -x "$MPERF" ]; then
#    echo "✗ mperf não encontrado em $MPERF — rode 'make' em tools/mperf"
#    exit 1
#fi
#
#sudo -v || { echo "✗ sudo necessário (mperf e powermetrics exigem root)"; exit 1; }
#
#SDK=$(xcrun --show-sdk-path 2>/dev/null)
#
## driver: laço externo que repete o kernel N vezes (ver driver.c)
#clang -O2 -c driver.c -o ir_opt_dyn/driver.o || { echo "✗ falha ao compilar driver.c"; exit 1; }
#
## índice de deduplicação de IR (hash -> primeiro tag medido); zerado a cada rodada
#: > ir_opt_dyn/hashes.txt
#
## pré-voo: valida que o conjunto de eventos cabe nos contadores deste CPU
## (conflito de counters_mask aborta o mperf com código 1 antes de medir)
#preflight=$(sudo "$MPERF" -j -e "$EVENTOS" -o /dev/null -- true 2>&1)
#if [ $? -ne 0 ] || echo "$preflight" | grep -q "Failed to add event"; then
#    echo "✗ conjunto de eventos inválido neste CPU:"
#    echo "$preflight"
#    exit 1
#fi
#
#gerar_ir_dyn() {
#    local source=$1 nome=$2
#    # -Dmain=kernel_main: o main do benchmark vira função chamável pelo driver,
#    # sem alterar o código medido
#    clang -O0 -Xclang -disable-O0-optnone -Dmain=kernel_main -emit-llvm -S \
#        -isysroot "$SDK" "$source" -o ir_opt_dyn/${nome}_base.ll 2>/dev/null
#    opt -passes="mem2reg,loop-simplify" -S ir_opt_dyn/${nome}_base.ll \
#        -o ir_opt_dyn/${nome}_ssa.ll 2>/dev/null
#    [ -f ir_opt_dyn/${nome}_ssa.ll ] || { echo "✗ falha ao gerar IR de $nome"; exit 1; }
#}
#
##medir() {
##    local tag=$1 ll=$2
##    local bin=ir_opt_dyn/${tag}.bin
##    local out=resultados_dinamico/${tag}
##
##    # deduplicação por IR: steps cuja IR é idêntica à de outro já medido (passes
##    # que não dispararam) reutilizam a medição — medir a mesma IR de novo é
##    # pseudo-replicação e carga térmica à toa. Linhas ';' (ModuleID muda de path)
##    # são ignoradas no hash.
##    local hash doador
##    hash=$(grep -v '^;' "$ll" | shasum -a 256 | cut -d' ' -f1)
##    doador=$(grep "^$hash " ir_opt_dyn/hashes.txt | cut -d' ' -f2)
##    if [ -n "$doador" ]; then
##        echo "  $tag: IR idêntica a $doador — reutilizando medição"
##        local rep
##        for rep in $(seq 1 $REPETICOES); do
##            cp "resultados_dinamico/${doador}.rep${rep}.mperf.json" "${out}.rep${rep}.mperf.json" 2>/dev/null
##            cp "resultados_dinamico/${doador}.rep${rep}.power.txt" "${out}.rep${rep}.power.txt" 2>/dev/null
##        done
##        return
##    fi
##    echo "$hash $tag" >> ir_opt_dyn/hashes.txt
##
##    # -O0: apenas codegen — não reaplicar otimizações sobre a IR já transformada
##    #clang -O0 "$ll" ir_opt_dyn/driver.o -o "$bin" 2>/dev/null
##    llc -O2 "$ll" -o "${bin}.s" 2>/dev/null
##    clang "${bin}.s" ir_opt_dyn/driver.o -o "$bin" 2>/dev/null
##    if [ ! -f "$bin" ]; then echo "  $tag: FALHOU (compilação do binário)"; return; fi
##
##    # calibra N para ~DUR_ALVO segundos por medição
##    #local t n
##    local res t saida
##
##    t=$(python3 -c "
##import subprocess, time
##t0 = time.perf_counter()
##subprocess.run(['$bin', '1'], stdout=subprocess.DEVNULL)
##print(time.perf_counter() - t0)")
##    n=$(python3 -c "print(max(1, round($DUR_ALVO / max($t, 1e-6))))")
##
##    # janela do powermetrics cobre o sono + a execução calibrada + margem
##    local pm_amostras
##    pm_amostras=$(python3 -c "import math; print(math.ceil((0.5 + $t * $n + 1.0) * 1000 / $PM_INTERVALO))")
##
##    # REPETICOES medições por step: sem isso, ruído de escalonamento (core P/E),
##    # térmico e de sistema torna rodadas únicas indistinguíveis de efeito real
##    local rep
##    for rep in $(seq 1 $REPETICOES); do
##        # powermetrics amostra a CPU inteira — roda em paralelo com a MESMA execução do mperf
##        sudo powermetrics --samplers cpu_power -i $PM_INTERVALO -n $pm_amostras \
##            -o "${out}.rep${rep}.power.txt" 2>/dev/null &
##        local pmpid=$!
##        sleep 0.5
##        if sudo "$MPERF" -j -e "$EVENTOS" -o "${out}.rep${rep}.mperf.json" -- "$bin" "$n" > /dev/null \
##            && [ -s "${out}.rep${rep}.mperf.json" ]; then
##            echo "  $tag rep$rep/$REPETICOES: ok (N=$n)"
##        else
##            echo "  $tag rep$rep/$REPETICOES: FALHOU (mperf)"
##        fi
##        wait $pmpid 2>/dev/null
##        sleep $RESFRIAMENTO
##    done
##}
#medir() {
#    local tag=$1 ll=$2
#    local bin=ir_opt_dyn/${tag}.bin
#    local out=resultados_dinamico/${tag}
#
#    # deduplicação por IR: steps cuja IR é idêntica à de outro já medido (passes
#    # que não dispararam) reutilizam a medição — medir a mesma IR de novo é
#    # pseudo-replicação e carga térmica à toa. Linhas ';' (ModuleID muda de path)
#    # são ignoradas no hash.
#    local hash doador
#    hash=$(grep -v '^;' "$ll" | shasum -a 256 | cut -d' ' -f1)
#    doador=$(grep "^$hash " ir_opt_dyn/hashes.txt | cut -d' ' -f2)
#    if [ -n "$doador" ]; then
#        echo "  $tag: IR idêntica a $doador — reutilizando medição"
#        # se o doador foi invalidado, esta versão também é
#        if [ -f "resultados_dinamico/${doador}.invalido" ]; then
#            touch "${out}.invalido"
#            return
#        fi
#        local rep
#        for rep in $(seq 1 $REPETICOES); do
#            cp "resultados_dinamico/${doador}.rep${rep}.mperf.json" "${out}.rep${rep}.mperf.json" 2>/dev/null
#            cp "resultados_dinamico/${doador}.rep${rep}.power.txt" "${out}.rep${rep}.power.txt" 2>/dev/null
#        done
#        cp "resultados_dinamico/${doador}.n" "${out}.n" 2>/dev/null
#        return
#    fi
#    echo "$hash $tag" >> ir_opt_dyn/hashes.txt
#
#    # [MUDANÇA 2] backend -O2: o llc traduz a IR com alocação de registradores
#    # real; o clang só monta o assembly e liga com o driver. Não reaplica passes
#    # de IR. Com -O0, o alocador simples guardava valores na pilha e desfazia no
#    # binário parte do efeito das transformações.
#    llc -O2 -disable-machine-licm -disable-postra-machine-licm -disable-lsr "$ll" -o "${bin}.s" 2>/dev/null
#    clang "${bin}.s" ir_opt_dyn/driver.o -o "$bin" 2>/dev/null
#    if [ ! -f "$bin" ]; then echo "  $tag: FALHOU (compilação do binário)"; return; fi
#
#    # [MUDANÇA 1] execução de verificação: roda uma vez com N=1, captura o
#    # checksum e mede o tempo na mesma execução
#    local res t saida
#    res=$(python3 -c "
#import subprocess, time
#t0 = time.perf_counter()
#p = subprocess.run(['$bin', '1'], capture_output=True, text=True)
#dt = time.perf_counter() - t0
#ck = [l for l in p.stdout.splitlines() if 'checksum' in l]
#print(dt, ck[0] if ck else 'SEM_CHECKSUM')
#")
#    t=${res%% *}
#    saida=${res#* }
#
#    # [MUDANÇA 1 + 3] o baseline é sempre medido primeiro em cada programa:
#    # ele define o checksum de referência e o N usado por todas as versões
#    if [[ "$tag" == *_base ]]; then
#        CHECKSUM_REF="$saida"
#        N_FIXO=$(python3 -c "print(max(1, round($DUR_ALVO / max($t, 1e-6))))")
#        echo "  referência: $saida | N fixo = $N_FIXO"
#    elif [ "$saida" != "$CHECKSUM_REF" ]; then
#        echo "  $tag: INVÁLIDO — resultado diferente do baseline ($saida)"
#        touch "${out}.invalido"
#        return
#    fi
#
#    # [MUDANÇA 3] mesmo N para todas as versões do programa
#    local n=$N_FIXO
#    echo "$n" > "${out}.n"
#
#    # janela do powermetrics cobre o sono + a execução + margem
#    local pm_amostras
#    pm_amostras=$(python3 -c "import math; print(math.ceil((0.5 + $t * $n + 1.0) * 1000 / $PM_INTERVALO))")
#
#    # REPETICOES medições por step: sem isso, ruído de escalonamento (core P/E),
#    # térmico e de sistema torna rodadas únicas indistinguíveis de efeito real
#    local rep
#    for rep in $(seq 1 $REPETICOES); do
#        sudo powermetrics --samplers cpu_power -i $PM_INTERVALO -n $pm_amostras \
#            -o "${out}.rep${rep}.power.txt" 2>/dev/null &
#        local pmpid=$!
#        sleep 0.5
#        if sudo "$MPERF" -j -e "$EVENTOS" -o "${out}.rep${rep}.mperf.json" -- "$bin" "$n" > /dev/null \
#            && [ -s "${out}.rep${rep}.mperf.json" ]; then
#            echo "  $tag rep$rep/$REPETICOES: ok (N=$n)"
#        else
#            echo "  $tag rep$rep/$REPETICOES: FALHOU (mperf)"
#        fi
#        wait $pmpid 2>/dev/null
#        sleep $RESFRIAMENTO
#    done
#}
#
#rodar_sequencia() {
#    local prog=$1 seq_nome=$2 sequencia=$3
#    echo "--- $prog / $seq_nome: $sequencia ---"
#    echo "$sequencia" > resultados_dinamico/${prog}_${seq_nome}.seq
#
#    local entrada=ir_opt_dyn/${prog}_ssa.ll
#    local step=1
#    IFS='|' read -ra PASSES <<< "$sequencia"
#    for passe in "${PASSES[@]}"; do
#        passe=$(echo $passe | xargs)
#        local saida=ir_opt_dyn/${prog}_${seq_nome}_step${step}.ll
#        opt -passes="${passe}" -S "$entrada" -o "$saida" 2>/dev/null
#        if [ -f "$saida" ]; then
#            medir ${prog}_${seq_nome}_step${step} "$saida"
#            entrada=$saida
#        else
#            echo "  step $step (+${passe}): FALHOU"
#            break
#        fi
#        step=$((step + 1))
#    done
#}
#
#for prog in $BENCHMARKS; do
#    echo "=========================================="
#    echo "=== PROGRAMA: $prog ==="
#    echo "=========================================="
#    gerar_ir_dyn benchmarks/${prog}.c $prog
#
#    echo "--- baseline (sem passes) ---"
#    medir ${prog}_base ir_opt_dyn/${prog}_ssa.ll
#
#    # mesmas sequências do experimento_cumulativo.sh (a 2ª "seq1" de lá virou seq6 aqui)
#    rodar_sequencia $prog "seq1" "loop-mssa(licm) | loop(loop-unroll-full) | loop-vectorize"
#    rodar_sequencia $prog "seq2" "loop-mssa(licm) | loop-vectorize | loop(loop-unroll-full)"
#    rodar_sequencia $prog "seq3" "loop(loop-unroll-full) | loop-vectorize"
#    rodar_sequencia $prog "seq4" "loop-vectorize | loop(loop-unroll-full)"
#    rodar_sequencia $prog "seq5" "loop-mssa(loop-rotate,licm) | loop-vectorize"
#    rodar_sequencia $prog "seq6" "loop-mssa(licm) | loop-unroll"
#done
#
#echo ""
#echo "Medições em resultados_dinamico/ — rode: python3 mede_dinamico.py"

#!/bin/bash
# experimento_dinamico.sh — análise dinâmica das sequências cumulativas de passes.
#
# Para cada step de cada sequência: compila a IR em binário nativo e mede, na
# MESMA execução:
#   - contadores de hardware (PMCs) via mperf -> resultados_dinamico/<tag>.repN.mperf.json
#   - energia via IOReport, lida pelo driver  -> resultados_dinamico/<tag>.repN.energy.txt
# Requer sudo (o mperf exige root; a senha é pedida uma vez).
#
# Uso:    ./experimento_dinamico.sh
# Depois: python3 mede_dinamico.py

#!/bin/bash
# experimento_dinamico.sh — análise dinâmica das sequências cumulativas de passes.
#
# Fase 1 (preparação): gera as IRs de cada step, compila, verifica o checksum
#   contra o baseline e monta a lista de versões únicas (IR distinta).
# Fase 2 (medição intercalada): REPETICOES rodadas; em cada rodada, cada versão
#   única é medida UMA vez, em ordem embaralhada. Assim a deriva térmica do chip
#   ao longo da execução se distribui igualmente entre as versões, em vez de
#   favorecer as medidas primeiro.
# Fase 3 (compartilhamento): steps com IR idêntica a outro recebem cópia das
#   medições do original.
#
# Em cada medição, na MESMA execução:
#   - contadores de hardware (PMCs) via mperf -> resultados_dinamico/<tag>.repN.mperf.json
#   - energia via IOReport, lida pelo driver  -> resultados_dinamico/<tag>.repN.energy.txt
# Requer sudo (o mperf exige root; a senha é pedida uma vez).
#
# Uso:    ./experimento_dinamico.sh
# Depois: python3 mede_dinamico.py

set -u

MPERF="tools/mperf/mperf-stat"
# 10 eventos = limite do M1 (2 fixos + 8 configuráveis).
# ATENÇÃO às counters_mask do a14 (/usr/share/kpep/a14.plist):
#   - mask 128 (só contador 7): no MÁXIMO 1 de INST_LDST/INST_INT_ALU/INST_INT_ST/
#     INST_SIMD_ALU/INST_ALL/RETIRE_UOP por medição
#   - mask 224 (contadores 5-7): INST_BRANCH, BRANCH_MISPRED_NONSPEC, INST_INT_LD, ...
#   - sem mask: demais eventos
# Restritos vêm PRIMEIRO na lista (o alocador é guloso, na ordem dada).
EVENTOS="cycles,instructions,INST_LDST,INST_BRANCH,BRANCH_MISPRED_NONSPEC,MAP_SIMD_UOP,L1D_CACHE_MISS_LD,L1D_CACHE_MISS_ST,L1I_CACHE_MISS_DEMAND,L1D_TLB_MISS"
DUR_ALVO=3.0        # segundos alvo por medição (calibra o N no baseline)
REPETICOES=10        # rodadas; a 1ª é warmup (descartada pelo mede_dinamico.py)
RESFRIAMENTO=3      # s ocioso entre medições — sem pausa o SoC passa de 100°C
LIGACAO="-framework CoreFoundation -lIOReport"   # o driver lê a energia via IOReport

BENCHMARKS="1D_conv" # fonte: benchmarks/<nome>.c (somente benchmarks de arquivo único)

UNICOS=()           # versões com IR distinta, preenchida na fase 1

mkdir -p ir_opt_dyn resultados_dinamico

if [ ! -x "$MPERF" ]; then
    echo "✗ mperf não encontrado em $MPERF — rode 'make' em tools/mperf"
    exit 1
fi

sudo -v || { echo "✗ sudo necessário (o mperf exige root)"; exit 1; }

SDK=$(xcrun --show-sdk-path 2>/dev/null)

# driver: laço externo que repete o kernel N vezes e mede a energia (ver driver.c)
clang -O2 -c driver.c -o ir_opt_dyn/driver.o || { echo "✗ falha ao compilar driver.c"; exit 1; }

# índices da deduplicação, zerados a cada execução
: > ir_opt_dyn/hashes.txt      # hash da IR -> primeiro tag com essa IR
: > ir_opt_dyn/aliases.txt     # tag duplicado -> tag original

# pré-voo: valida que o conjunto de eventos cabe nos contadores deste CPU
preflight=$(sudo "$MPERF" -j -e "$EVENTOS" -o /dev/null -- true 2>&1)
if [ $? -ne 0 ] || echo "$preflight" | grep -q "Failed to add event"; then
    echo "✗ conjunto de eventos inválido neste CPU:"
    echo "$preflight"
    exit 1
fi

gerar_ir_dyn() {
    local source=$1 nome=$2
    # -Dmain=kernel_main: o main do benchmark vira função chamável pelo driver
    clang -O0 -Xclang -disable-O0-optnone -Dmain=kernel_main -emit-llvm -S \
        -isysroot "$SDK" "$source" -o ir_opt_dyn/${nome}_base.ll 2>/dev/null
    opt -passes="mem2reg,loop-simplify" -S ir_opt_dyn/${nome}_base.ll \
        -o ir_opt_dyn/${nome}_ssa.ll 2>/dev/null
    [ -f ir_opt_dyn/${nome}_ssa.ll ] || { echo "✗ falha ao gerar IR de $nome"; exit 1; }
}

# ---------------------------------------------------------------------------
# Fase 1: prepara uma versão (deduplica, compila, verifica). Não mede nada.
# ---------------------------------------------------------------------------
preparar() {
    local tag=$1 ll=$2
    local forcar=${3:-}
    local bin=ir_opt_dyn/${tag}.bin
    local out=resultados_dinamico/${tag}

    # IR idêntica a uma versão já preparada: será compartilhada na fase 3
    local hash doador
    hash=$(grep -v '^;' "$ll" | shasum -a 256 | cut -d' ' -f1)
    doador=$(grep "^$hash " ir_opt_dyn/hashes.txt | cut -d' ' -f2)
    if [ -n "$doador" ] && [ -z "$forcar" ]; then
        echo "  $tag: IR idêntica a $doador — medição compartilhada"
        echo "$tag $doador" >> ir_opt_dyn/aliases.txt
        return
    fi
    [ -z "$forcar" ] && echo "$hash $tag" >> ir_opt_dyn/hashes.txt

    # backend -O2 com as otimizações de laço do próprio backend desligadas,
    # para que o binário reflita apenas as transformações aplicadas na IR
    llc -O2 -disable-machine-licm -disable-postra-machine-licm -disable-lsr \
        "$ll" -o "${bin}.s" 2>/dev/null
    clang "${bin}.s" ir_opt_dyn/driver.o $LIGACAO -o "$bin"
    if [ ! -f "$bin" ]; then echo "  $tag: FALHOU (compilação do binário)"; return; fi

    # execução de verificação: N=1, sem medir energia; captura checksum e tempo
    local res t saida
    res=$(python3 -c "
import subprocess, time
t0 = time.perf_counter()
p = subprocess.run(['$bin', '1'], capture_output=True, text=True)
dt = time.perf_counter() - t0
ck = [l for l in p.stdout.splitlines() if 'checksum' in l]
print(dt, ck[0] if ck else 'SEM_CHECKSUM')
")
    t=${res%% *}
    saida=${res#* }

    # o baseline define o checksum de referência e o N usado por todas as versões
    if [[ "$tag" == *_base ]]; then
        CHECKSUM_REF="$saida"
        N_FIXO=$(python3 -c "print(max(1, round($DUR_ALVO / max($t, 1e-6))))")
        echo "  $tag: referência $saida | N fixo = $N_FIXO"
    elif [ "$saida" != "$CHECKSUM_REF" ]; then
        echo "  $tag: INVÁLIDO — resultado diferente do baseline ($saida)"
        touch "${out}.invalido"
        return
    else
        echo "  $tag: pronto (checksum confere)"
    fi

    echo "$N_FIXO" > "${out}.n"
    UNICOS+=("$tag")
}

rodar_sequencia() {
    local prog=$1 seq_nome=$2 sequencia=$3
    echo "--- $prog / $seq_nome: $sequencia ---"
    echo "$sequencia" > resultados_dinamico/${prog}_${seq_nome}.seq

    local entrada=ir_opt_dyn/${prog}_ssa.ll
    local step=1
    IFS='|' read -ra PASSES <<< "$sequencia"
    for passe in "${PASSES[@]}"; do
        passe=$(echo $passe | xargs)
        local saida=ir_opt_dyn/${prog}_${seq_nome}_step${step}.ll
        opt -passes="${passe}" -S "$entrada" -o "$saida" 2>/dev/null
        if [ -f "$saida" ]; then
            preparar ${prog}_${seq_nome}_step${step} "$saida"
            entrada=$saida
        else
            echo "  step $step (+${passe}): FALHOU"
            break
        fi
        step=$((step + 1))
    done
}

echo "=========================================="
echo "=== FASE 1: preparação ==="
echo "=========================================="
for prog in $BENCHMARKS; do
    echo "=== PROGRAMA: $prog ==="
    gerar_ir_dyn benchmarks/${prog}.c $prog

    echo "--- baseline (sem passes) ---"
    preparar ${prog}_base ir_opt_dyn/${prog}_ssa.ll
    preparar ${prog}_aa   ir_opt_dyn/${prog}_ssa.ll forcar

    rodar_sequencia $prog "seq1" "loop-mssa(licm) | loop(loop-unroll-full) | loop-vectorize"
    rodar_sequencia $prog "seq2" "loop-mssa(licm) | loop-vectorize | loop(loop-unroll-full)"
    rodar_sequencia $prog "seq3" "loop(loop-unroll-full) | loop-vectorize"
    rodar_sequencia $prog "seq4" "loop-vectorize | loop(loop-unroll-full)"
    rodar_sequencia $prog "seq5" "loop-mssa(loop-rotate,licm) | loop-vectorize"
    rodar_sequencia $prog "seq6" "loop-mssa(licm) | loop-unroll"
done

echo ""
echo "=========================================="
echo "=== FASE 2: medição intercalada (${#UNICOS[@]} versões únicas × $REPETICOES rodadas) ==="
echo "=========================================="
for rep in $(seq 1 $REPETICOES); do
    echo "--- rodada $rep/$REPETICOES ---"
    # ordem embaralhada a cada rodada
    ordem=$(printf "%s\n" "${UNICOS[@]}" | python3 -c "
import sys, random
versoes = sys.stdin.read().split()
random.shuffle(versoes)
print('\n'.join(versoes))")
    for tag in $ordem; do
        bin=ir_opt_dyn/${tag}.bin
        out=resultados_dinamico/${tag}
        n=$(cat "${out}.n")
        if sudo "$MPERF" -j -e "$EVENTOS" -o "${out}.rep${rep}.mperf.json" \
                -- "$bin" "$n" "${out}.rep${rep}.energy.txt" > /dev/null \
            && [ -s "${out}.rep${rep}.mperf.json" ] \
            && [ -s "${out}.rep${rep}.energy.txt" ]; then
            echo "  $tag: ok"
        else
            echo "  $tag: FALHOU (mperf ou energia)"
        fi
        sleep $RESFRIAMENTO
    done
done

echo ""
echo "=========================================="
echo "=== FASE 3: compartilhamento de medições ==="
echo "=========================================="
while read -r tag doador; do
    out=resultados_dinamico/${tag}
    if [ -f "resultados_dinamico/${doador}.invalido" ]; then
        touch "${out}.invalido"
        continue
    fi
    for rep in $(seq 1 $REPETICOES); do
        cp "resultados_dinamico/${doador}.rep${rep}.mperf.json" "${out}.rep${rep}.mperf.json" 2>/dev/null
        cp "resultados_dinamico/${doador}.rep${rep}.energy.txt" "${out}.rep${rep}.energy.txt" 2>/dev/null
    done
    cp "resultados_dinamico/${doador}.n" "${out}.n" 2>/dev/null
    echo "  $tag <- $doador"
done < ir_opt_dyn/aliases.txt

echo ""
echo "Medições em resultados_dinamico/ — rode: python3 mede_dinamico.py"