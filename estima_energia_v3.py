# VERSAO USANDO TRIP_COUNT
import subprocess, re, sys
from collections import defaultdict

ENERGIA = {
    'load': 6.0, 'store': 6.0, 'call': 8.0, 'br': 1.5,
    'fadd': 3.0, 'fmul': 3.5, 'fsub': 3.0, 'fdiv': 5.0,
    'add': 1.0, 'sub': 1.0, 'mul': 2.0, 'icmp': 1.0,
    'getelementptr': 1.5, 'ret': 1.0, 'alloca': 2.0,
    'phi': 0.0, 'sext': 0.0, 'zext': 0.0, 'trunc': 0.0, 'bitcast': 0.0,
}
DEFAULT = 1.0
TRIP_COUNT = 1024   # assume trip count uniforme; ajuste conforme o benchmark

def get_block_depths(ll_file):
    """Usa print<loops> para descobrir a profundidade de cada bloco."""
    out = subprocess.run(
        ["opt", "-passes=print<loops>", "-disable-output", ll_file],
        capture_output=True, text=True
    ).stderr
    
    depths = {}  # nome_bloco -> profundidade
    for line in out.splitlines():
        m = re.search(r'Loop at depth (\d+) containing: (.+)', line)
        if m:
            depth = int(m.group(1))
            blocos = m.group(2)
            # extrai os nomes de bloco tipo %5, %8, etc.
            for bloco in re.findall(r'%(\w+)', blocos):
                # mantém a maior profundidade encontrada para cada bloco
                if bloco not in depths or depth > depths[bloco]:
                    depths[bloco] = depth
    return depths

def parse_blocks(ll_file):
    blocks = defaultdict(list)
    block_order = []
    current = "0"  # entry block costuma ser implícito
    with open(ll_file) as f:
        in_func = False
        for line in f:
            s = line.strip()
            if s.startswith("define"):
                in_func = True
                current = "entry"
                block_order.append(current)
                continue
            if not in_func: continue
            if s == "}":
                in_func = False
                continue
            label = re.match(r'^(\w+):', s)
            if label:
                current = label.group(1)
                block_order.append(current)
                continue
            m = re.match(r'(?:%\S+\s*=\s*)?(\w+)\s', s)
            if m:
                blocks[current].append(m.group(1))
    return blocks

def estimate(ll_file):
    blocks = parse_blocks(ll_file)
    depths = get_block_depths(ll_file)
    total = 0.0
    for block, instrs in blocks.items():
        depth = depths.get(block, 0)
        freq = TRIP_COUNT ** depth
        custo_bloco = sum(ENERGIA.get(i, DEFAULT) for i in instrs)
        total += freq * custo_bloco
    return total

if __name__ == "__main__":
    print(f"{estimate(sys.argv[1]):.2f}")