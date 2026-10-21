# AGENTS.md

Projeto de TCC: análise estática e dinâmica de transformações de loops, buscando
sinergia entre otimizações (ordem/sequência de passes). Shell + Python 3 (stdlib,
`python3`), sem build system, sem testes; a raiz não é um repo git. Comentários e
saídas dos programas em português.

## Estado do projeto

- Análise estática: implementada — pipeline abaixo estima custo de energia (nJ) da IR
  antes/depois de cada passe.
- Análise dinâmica: implementada — `./experimento_dinamico.sh` mede cada step das
  sequências com mperf (PMCs) + powermetrics (energia); `python3 mede_dinamico.py`
  consolida estático × dinâmico. `driver.c` é o laço externo que repete o kernel N
  vezes (benchmarks rodam em ms, curto demais para a amostragem). Ferramenta:
  `tools/mperf/mperf-stat` (clone de github.com/tmcgilchrist/mperf, build via `make`),
  estilo `perf stat` para macOS (**requer sudo**, como o powermetrics).

## Workflow (parte estática)

1. Gerar IR: `./gerar_ir.sh <source.c|dir-com-.c> <nome>`
   - Arquivo único → `ir/<nome>.ll`; diretório → compila todos os `*.c` e liga com `llvm-link`.
   - Também emite `ir/<nome>_ssa.ll` (`opt -passes="mem2reg,loop-simplify"`) — o `_ssa.ll`
     é a entrada de todos os estimadores e scripts de experimento.
2. Rodar experimento: `./experimento_cumulativo.sh` (principal; sequências cumulativas
   de passes — é onde a sinergia entre otimizações é medida). `./experimento.sh` é a
   variante antiga, de passe único.
   - IRs de cada step caem em `ir_opt/`; stdout é a tabela de resultados (`log` tem uma
     rodada salva).
3. Smoke test rápido após mexer num estimador:
   `python3 estima_energia_v4.py ir/matmul_ssa.ll` → imprime um número.

## Workflow (parte dinâmica)

1. `./experimento_dinamico.sh` (pede sudo uma vez; ~4 min/benchmark): gera IR com
   `-Dmain=kernel_main`, aplica as mesmas sequências da estática, compila cada step +
   `driver.c` em binário (`clang -O0` na IR — não reotimizar) e mede com mperf +
   powermetrics na mesma execução, **REPETICOES=5 por IR única** (pausa de 3s entre
   reps por causa térmica). Steps cuja IR é idêntica à de outro já medido (passes
   que não dispararam) **reutilizam a medição** — dedup por hash da IR; medir de novo
   seria pseudo-replicação e carga térmica à toa (sem dedup, 18 min contínuos levaram
   o M1 a 101°C/throttle).
   - Artefatos: `ir_opt_dyn/` (IRs, binários, `hashes.txt`), `resultados_dinamico/`
     (`.repN.mperf.json`, `.repN.power.txt`, `.seq`).
2. `python3 mede_dinamico.py` → descarta a rep 1 (warmup), agrega por **mediana** e
   mostra a dispersão de Δcycles em `[min..max]`. Tabela nas duas perguntas causais:
   (a) modelo × instruções (ΔnJ estático × Δinstr/Δldst) e (b) instruções × máquina
   (Δinstr × Δcycles/ΔmJ). cycles é a métrica confiável; mJ é estimativa de pacote
   (powermetrics = CPU inteira).

## Gotchas

- `tutorial.txt` e o comentário no topo de `gerar_ir.sh` dizem `./run.sh` — nome
  obsoleto; o script é `gerar_ir.sh`. Não existe `run.sh`.
- Requer `clang`, `opt`, `llvm-link` no PATH. Específico de macOS: `gerar_ir.sh` usa
  `xcrun --show-sdk-path` para `-isysroot`.
- As listas de benchmarks estão hardcoded nos loops `for prog in ...` dos scripts de
  experimento — para adicionar um benchmark, gere a IR primeiro e depois edite a lista.
- IRs em `ir/` podem estar velhas em relação aos fontes — os scripts de experimento
  NÃO regeram IR, consomem o que existe. Atributos como `noalias` mudam drasticamente
  o efeito dos passes (caso real: rotate+licm no matmul_stress dava -64,98% numa IR
  velha com `noalias`; na IR atual, -13,79%). Antes de comparar resultados, regere
  com `./gerar_ir.sh` e confirme que os baselines batem.
- Versões de estimador coexistem e divergem — escolher conscientemente:
  - `estima_energia.py` — frequência de bloco via `print<block-freq>` (só o
    `experimento.sh` antigo usa)
  - `estima_energia_v3.py` — profundidade de loop × `TRIP_COUNT=1024` uniforme
    (versão anterior; comentada no `experimento_cumulativo.sh`)
  - `estima_energia_v4.py` — trip counts via SCEV × loop nests, fallback 1024
    (**é a versão usada hoje por `experimento_cumulativo.sh` e `mede_dinamico.py`**;
    detalhe: usa o backedge-taken count do SCEV, i.e. iterações-1 — uniforme,
    não afeta comparações relativas)
  - `energia_modelo.py` — tabela de custos standalone, não importada por ninguém;
    cada estimador tem sua própria cópia inline.
- Estimadores fazem parse do stderr de `opt -passes=print<...>` com regex — trocar a
  versão do LLVM pode quebrar o parse silenciosamente; os scripts escondem erros do
  `opt` com `2>/dev/null` (step falho só imprime "FALHOU").
- Sequências em `experimento_cumulativo.sh` são strings separadas por `|` em sintaxe
  do new PM (`loop-mssa(licm)`, `loop(loop-unroll-full)`).
- `caracteriza.py` (CPU-bound vs Memory-bound) é chamado pelo `experimento_cumulativo.sh`.
- mperf: máx. 10 eventos por medição (sem multiplexação) e conflito de `counters_mask`
  no a14 (`/usr/share/kpep/a14.plist`): eventos mask 128 (`INST_LDST`, `INST_INT_ALU`,
  `INST_INT_ST`, `INST_SIMD_ALU`, `RETIRE_UOP`...) só cabem no contador 7 — no máx. 1
  por medição; mask 224 (`INST_BRANCH`, `BRANCH_MISPRED_NONSPEC`, `INST_INT_LD`...) nos
  contadores 5–7. Restritos vêm primeiro na lista `-e` (alocador guloso). Conflito =
  mperf aborta com código 1 ("Failed to add event"); `experimento_dinamico.sh` valida
  o conjunto num pré-voo antes de medir.
- Programas mais curtos que ~2× o período de amostragem do mperf (1ms default) podem
  sair sem amostras — por isso o `driver.c` repete o kernel N vezes (~3s alvo).
  Host: M1 (database `a14`).
- Rodada única NÃO é medição: a mesma IR variou -7,0% a +5,3% em cycles entre rodadas
  (suspeita: escalonamento core P/E + térmico + sistema). Piso de ruído ~±8% — por
  isso REPETICOES=5 + descarte da rep 1 + mediana. Energia (mJ) é ainda mais ruidosa
  que cycles (powermetrics mede a CPU inteira).

## Diretórios

- `benchmarks/` — benchmarks C de arquivo único. `cbench/` — suíte cBench V1.1, usada
  como fontes multi-arquivo (ex.: `cbench/telecom_CRC32/src`).
- `tools/mperf/` — ferramenta externa já compilada (git clone próprio); não editar
  o código-fonte dela, usar só o binário `mperf-stat`.
- `ir/`, `ir_opt/`, `ir_opt_dyn/`, `resultados_dinamico/`, `log` — artefatos gerados,
  seguros para apagar/regerar.
- Somente referência, NÃO é código do projeto — excluir de buscas amplas e edições:
  `extra/project/llvm-project/` (checkout completo do monorepo LLVM, com .git próprio),
  `extra/tutorialLLVM/` (tutorial CMake do MyPass), `examples/` (rascunhos CFG/dot/png).
