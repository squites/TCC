#!/bin/bash

mkdir -p ir_opt

rodar_sequencia() {
    local prog=$1
    local seq_nome=$2
    local sequencia=$3
    local base=$4
    
    echo "--- Sequência $seq_nome: $sequencia ---"
    
    cp ir/${prog}_ssa.ll ir_opt/${prog}_${seq_nome}_step0.ll
    entrada="ir_opt/${prog}_${seq_nome}_step0.ll"
    
    step=1
    IFS='|' read -ra PASSES <<< "$sequencia"
    for passe in "${PASSES[@]}"; do
        passe=$(echo $passe | xargs)
        saida="ir_opt/${prog}_${seq_nome}_step${step}.ll"
        
        opt -passes="${passe}" -S $entrada -o $saida 2>/dev/null
        
        if [ -f "$saida" ]; then
            #custo=$(python3 estima_energia.py $saida)     # v1: block-freq
            #custo=$(python3 estima_energia_v3.py $saida)  # v3: profundidade x 1024
            custo=$(python3 estima_energia_v4.py $saida)   # v4: SCEV + loop nests
            variacao=$(python3 -c "print(f'{(($custo - $base) / $base) * 100:+.2f}%')")
            echo "  step $step (+${passe}): $custo nJ ($variacao)"
            entrada=$saida
        else
            echo "  step $step (+${passe}): FALHOU"
            break
        fi
        
        step=$((step + 1))
    done
    echo ""
}

#for prog in crc32 qsort matmul matmul_hard_2 nqueens_iter primos kmeans 1D_conv 2D_conv; do
for prog in matmul_hard_2_pure matmul_stress 1D_conv 2D_conv; do
	echo "=========================================="
    echo "=== PROGRAMA: $prog ==="
    echo "=========================================="
    
    #base=$(python3 estima_energia.py ir/${prog}_ssa.ll)     # v1: block-freq
    #base=$(python3 estima_energia_v3.py ir/${prog}_ssa.ll)   # v3: profundidade x 1024
    base=$(python3 estima_energia_v4.py ir/${prog}_ssa.ll)    # v4: SCEV + loop nests
    caracterizacao=$(python3 caracteriza.py ir/${prog}_ssa.ll)
    echo "baseline: $base nJ"
    echo "caracterização: $caracterizacao"
    echo ""
    
    rodar_sequencia $prog "seq1" "loop-mssa(licm) | loop(loop-unroll-full) | loop-vectorize" $base
    rodar_sequencia $prog "seq1" "loop-mssa(licm) | loop-unroll" $base
    rodar_sequencia $prog "seq2" "loop-mssa(licm) | loop-vectorize | loop(loop-unroll-full)" $base
    rodar_sequencia $prog "seq3" "loop(loop-unroll-full) | loop-vectorize" $base
    rodar_sequencia $prog "seq4" "loop-vectorize | loop(loop-unroll-full)" $base
    rodar_sequencia $prog "seq5" "loop-mssa(loop-rotate,licm) | loop-vectorize" $base
done
