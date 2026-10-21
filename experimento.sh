#!/bin/bash

mkdir -p ir_opt

for prog in crc32 qsort bitcount; do
    echo "=== $prog ==="
    
    base=$(python3 estima_energia.py ir/${prog}_ssa.ll)
    echo "baseline: $base nJ"
    
    for passe in "loop-mssa(licm)" "loop(loop-unroll-full)" "loop-vectorize" "loop-mssa(loop-rotate,licm)"; do
        nome=${passe//,/_}
        opt -passes="${passe}" \
            -S ir/${prog}_ssa.ll -o ir_opt/${prog}_${nome}.ll 2>/dev/null
        
        custo=$(python3 estima_energia.py ir_opt/${prog}_${nome}.ll)
        variacao=$(python3 -c "print(f'{(($custo - $base) / $base) * 100:+.2f}%')")
        echo "  $passe: $custo nJ ($variacao)"
    done
    echo ""
done