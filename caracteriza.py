#import subprocess, re, sys
#from collections import defaultdict
#
#MEMORIA = {'load', 'store'}
#CPU = {'add', 'sub', 'mul', 'fadd', 'fmul', 'fdiv', 'fsub', 'icmp'}
#
#def get_block_frequencies(ll_file):
#    out = subprocess.run(
#        ["opt", "-passes=print<block-freq>", "-disable-output", ll_file],
#        capture_output=True, text=True
#    ).stderr
#    freqs = defaultdict(lambda: 1.0)
#    for line in out.splitlines():
#        m = re.search(r'-\s+(\S+):\s*float\s*=\s*([\d.eE+-]+)', line)
#        if m:
#            freqs[m.group(1)] = float(m.group(2))
#    return freqs
#
#def parse_blocks(ll_file):
#    blocks = defaultdict(list)
#    current = "entry"
#    with open(ll_file) as f:
#        in_func = False
#        for line in f:
#            s = line.strip()
#            if s.startswith("define"):
#                in_func = True
#                current = "entry"
#                continue
#            if not in_func: continue
#            if s == "}":
#                in_func = False
#                continue
#            label = re.match(r'^([\w.]+):', s)
#            if label:
#                current = label.group(1)
#                continue
#            m = re.match(r'(?:%\S+\s*=\s*)?(\w+)\s', s)
#            if m:
#                blocks[current].append(m.group(1))
#    return blocks
#
#def caracteriza(ll_file):
#    blocks = parse_blocks(ll_file)
#    freqs = get_block_frequencies(ll_file)
#    mem_ops = 0.0
#    cpu_ops = 0.0
#    for block, instrs in blocks.items():
#        freq = freqs.get(block, 1.0)
#        for i in instrs:
#            if i in MEMORIA:
#                mem_ops += freq
#            elif i in CPU:
#                cpu_ops += freq
#    if mem_ops == 0:
#        return "CPU-bound", float('inf'), cpu_ops, mem_ops
#    razao = cpu_ops / mem_ops
#    tipo = "CPU-bound" if razao > 2 else "Memory-bound"
#    return tipo, razao, cpu_ops, mem_ops
#
#if __name__ == "__main__":
#    tipo, razao, cpu, mem = caracteriza(sys.argv[1])
#    print(f"{sys.argv[1]}: {tipo} (razão CPU/MEM = {razao:.2f})")

# Classifica um programa como CPU-bound ou Memory-bound pela razao entre
# operacoes aritmeticas e operacoes de memoria, ponderadas pela frequencia
# de execucao de cada bloco. A frequencia e calculada pelo mesmo modelo do
# estima_energia_v4.py (SCEV + loop nests), garantindo consistencia.
import sys
from estima_energia_v4 import get_trip_counts, get_loop_nests, parse_blocks, frequencia

MEMORIA = {'load', 'store'}
CPU = {'add', 'sub', 'mul', 'fadd', 'fmul', 'fdiv', 'fsub', 'icmp'}
LIMIAR = 2.0   # razao CPU/MEM acima da qual o programa e considerado CPU-bound

def caracteriza(ll_file):
    blocks = parse_blocks(ll_file)
    trip_counts = get_trip_counts(ll_file)
    nests = get_loop_nests(ll_file)

    mem_ops = 0.0
    cpu_ops = 0.0
    for (func, bloco), instrs in blocks.items():
        freq = frequencia(func, bloco, nests, trip_counts)
        for i in instrs:
            if i in MEMORIA:
                mem_ops += freq
            elif i in CPU:
                cpu_ops += freq

    if mem_ops == 0:
        return "CPU-bound", float('inf'), cpu_ops, mem_ops
    razao = cpu_ops / mem_ops
    tipo = "CPU-bound" if razao > LIMIAR else "Memory-bound"
    return tipo, razao, cpu_ops, mem_ops

if __name__ == "__main__":
    tipo, razao, cpu, mem = caracteriza(sys.argv[1])
    print(f"{sys.argv[1]}: {tipo} (razão CPU/MEM = {razao:.2f})")