# VERSAO USANDO SCEV TRIP COUNT
# Frequencia de cada bloco = produto dos trip counts (SCEV) dos loops que o contem.
# Quando o SCEV nao resolve o trip count (<<Unknown>> / Unpredictable),
# usa FALLBACK_TRIP_COUNT para aquele loop.
#import subprocess, re, sys
#from collections import defaultdict

#ENERGIA = {
#    'load': 6.0, 'store': 6.0, 'call': 8.0, 'br': 1.5,
#    'fadd': 3.0, 'fmul': 3.5, 'fsub': 3.0, 'fdiv': 5.0,
#    'add': 1.0, 'sub': 1.0, 'mul': 2.0, 'icmp': 1.0,
#    'getelementptr': 1.5, 'ret': 1.0, 'alloca': 2.0,
#    'phi': 0.0, 'sext': 0.0, 'zext': 0.0, 'trunc': 0.0, 'bitcast': 0.0,
#}
#DEFAULT = 1.0
#FALLBACK_TRIP_COUNT = 1024   # usado quando o SCEV nao resolve o trip count
#
#def get_trip_counts(ll_file):
#    """Parse print<scalar-evolution>: (func, header) -> trip count (None se desconhecido)."""
#    out = subprocess.run(
#        ["opt", "-passes=print<scalar-evolution>", "-disable-output", ll_file],
#        capture_output=True, text=True
#    ).stderr
#
#    trip_counts = {}
#    func = None
#    for line in out.splitlines():
#        m = re.search(r'Determining loop execution counts for: @(\S+)', line)
#        if m:
#            func = m.group(1)
#            continue
#        m = re.search(r'Loop %([^:]+): (?:<multiple exits> )?(?:Unpredictable backedge-taken count|backedge-taken count is (.+))', line)
#        if m and func:
#            header = m.group(1)
#            expr = (m.group(2) or "").strip()
#            mc = re.match(r'^i\d+ (\d+)$', expr)
#            # constante -> int; <<Unknown>> / simbolico / Unpredictable -> None (fallback)
#            trip_counts[(func, header)] = int(mc.group(1)) if mc else None
#    return trip_counts
#
#def get_loop_nests(ll_file):
#    """Parse print<loops>: (func, bloco) -> [headers dos loops que o contem].
#
#    O print<loops> lista em cada loop TODOS os blocos que ele contem
#    (incluindo blocos de subloops), entao um bloco em profundidade 3
#    aparece nas linhas de depth 1, 2 e 3.
#    """
#    out = subprocess.run(
#        ["opt", "-passes=print<loops>", "-disable-output", ll_file],
#        capture_output=True, text=True
#    ).stderr
#
#    nests = defaultdict(list)
#    func = None
#    for line in out.splitlines():
#        m = re.search(r"Loop info for function '(\S+?)':", line)
#        if m:
#            func = m.group(1)
#            continue
#        m = re.search(r'Loop at depth (\d+) containing: (.+)', line)
#        if m and func:
#            blocos = re.findall(r'%([\w.]+)', m.group(2))
#            mh = re.search(r'%([\w.]+)<header>', m.group(2))
#            header = mh.group(1) if mh else blocos[0]
#            for bloco in blocos:
#                nests[(func, bloco)].append(header)
#    return nests
#
#def parse_blocks(ll_file):
#    """(func, bloco) -> [opcodes das instrucoes]."""
#    blocks = defaultdict(list)
#    func = None
#    current = None
#    with open(ll_file) as f:
#        for line in f:
#            s = line.strip()
#            m = re.match(r'define\s+.*@(\S+?)\(', s)
#            if m:
#                func = m.group(1)
#                current = "entry"
#                continue
#            if func is None:
#                continue
#            if s == "}":
#                func = None
#                current = None
#                continue
#            label = re.match(r'^([\w.]+):', s)
#            if label:
#                current = label.group(1)
#                continue
#            m = re.match(r'(?:%\S+\s*=\s*)?(\w+)\s', s)
#            if m and current is not None:
#                blocks[(func, current)].append(m.group(1))
#    return blocks
#
#def frequencia(func, bloco, nests, trip_counts):
#    """Frequencia do bloco = produto dos trip counts dos loops que o contem.
#    Bloco fora de loops -> 1 (produto vazio)."""
#    freq = 1
#    for header in nests.get((func, bloco), []):
#        tc = trip_counts.get((func, header))
#        freq *= tc if tc is not None else FALLBACK_TRIP_COUNT
#    return freq
#
#def estimate(ll_file, verbose=False):
#    blocks = parse_blocks(ll_file)
#    trip_counts = get_trip_counts(ll_file)
#    nests = get_loop_nests(ll_file)
#
#    if verbose:
#        for (func, header), tc in sorted(trip_counts.items()):
#            status = str(tc) if tc is not None else f"desconhecido (fallback {FALLBACK_TRIP_COUNT})"
#            print(f"  loop %{header} @{func}: trip count = {status}", file=sys.stderr)
#
#    total = 0.0
#    for (func, bloco), instrs in blocks.items():
#        freq = 1
#        for header in nests.get((func, bloco), []):
#            tc = trip_counts.get((func, header))
#            freq *= tc if tc is not None else FALLBACK_TRIP_COUNT
#        custo_bloco = sum(ENERGIA.get(i, DEFAULT) for i in instrs)
#        total += freq * custo_bloco
#    return total
#
#if __name__ == "__main__":
#    verbose = "--verbose" in sys.argv
#    ll_file = [a for a in sys.argv[1:] if not a.startswith("--")][0]
#    print(f"{estimate(ll_file, verbose):.2f}")

# VERSAO USANDO SCEV TRIP COUNT
# Frequencia de cada bloco = produto dos trip counts (SCEV) dos loops que o contem.
# Quando o SCEV nao resolve o trip count (<<Unknown>> / Unpredictable),
# usa FALLBACK_TRIP_COUNT para aquele loop.
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
FALLBACK_TRIP_COUNT = 1024   # usado quando o SCEV nao resolve o trip count

def get_trip_counts(ll_file):
    """Parse print<scalar-evolution>: (func, header) -> trip count (None se desconhecido).

    O SCEV reporta o backedge-taken count (quantas vezes o laco volta ao inicio).
    O numero de iteracoes e esse valor + 1.
    """
    out = subprocess.run(
        ["opt", "-passes=print<scalar-evolution>", "-disable-output", ll_file],
        capture_output=True, text=True
    ).stderr

    trip_counts = {}
    func = None
    for line in out.splitlines():
        m = re.search(r'Determining loop execution counts for: @(\S+)', line)
        if m:
            func = m.group(1)
            continue
        m = re.search(r'Loop %([^:]+): (?:<multiple exits> )?(?:Unpredictable backedge-taken count|backedge-taken count is (.+))', line)
        if m and func:
            header = m.group(1)
            expr = (m.group(2) or "").strip()
            mc = re.match(r'^i\d+ (\d+)$', expr)
            # constante -> iteracoes = backedge-taken + 1
            # <<Unknown>> / simbolico / Unpredictable -> None (fallback)
            trip_counts[(func, header)] = int(mc.group(1)) if mc else None
    return trip_counts

def get_loop_nests(ll_file):
    """Parse print<loops>: (func, bloco) -> [headers dos loops que o contem].

    O print<loops> lista em cada loop TODOS os blocos que ele contem
    (incluindo blocos de subloops), entao um bloco em profundidade 3
    aparece nas linhas de depth 1, 2 e 3.
    """
    out = subprocess.run(
        ["opt", "-passes=print<loops>", "-disable-output", ll_file],
        capture_output=True, text=True
    ).stderr

    nests = defaultdict(list)
    func = None
    for line in out.splitlines():
        m = re.search(r"Loop info for function '(\S+?)':", line)
        if m:
            func = m.group(1)
            continue
        m = re.search(r'Loop at depth (\d+) containing: (.+)', line)
        if m and func:
            blocos = re.findall(r'%([\w.]+)', m.group(2))
            mh = re.search(r'%([\w.]+)<header>', m.group(2))
            header = mh.group(1) if mh else blocos[0]
            for bloco in blocos:
                nests[(func, bloco)].append(header)
    return nests

def parse_blocks(ll_file):
    """(func, bloco) -> [opcodes das instrucoes]."""
    blocks = defaultdict(list)
    func = None
    current = None
    with open(ll_file) as f:
        for line in f:
            s = line.strip()
            m = re.match(r'define\s+.*@(\S+?)\(', s)
            if m:
                func = m.group(1)
                current = "entry"
                continue
            if func is None:
                continue
            if s == "}":
                func = None
                current = None
                continue
            label = re.match(r'^([\w.]+):', s)
            if label:
                current = label.group(1)
                continue
            m = re.match(r'(?:%\S+\s*=\s*)?(\w+)\s', s)
            if m and current is not None:
                blocks[(func, current)].append(m.group(1))
    return blocks

def frequencia(func, bloco, nests, trip_counts):
    """Frequencia do bloco = produto dos trip counts dos loops que o contem.
    Bloco fora de loops -> 1 (produto vazio)."""
    freq = 1
    for header in nests.get((func, bloco), []):
        tc = trip_counts.get((func, header))
        freq *= tc if tc is not None else FALLBACK_TRIP_COUNT
    return freq

def estimate(ll_file, verbose=False):
    blocks = parse_blocks(ll_file)
    trip_counts = get_trip_counts(ll_file)
    nests = get_loop_nests(ll_file)

    if verbose:
        for (func, header), tc in sorted(trip_counts.items()):
            status = str(tc) if tc is not None else f"desconhecido (fallback {FALLBACK_TRIP_COUNT})"
            print(f"  loop %{header} @{func}: trip count = {status}", file=sys.stderr)

    total = 0.0
    for (func, bloco), instrs in blocks.items():
        freq = frequencia(func, bloco, nests, trip_counts)
        custo_bloco = sum(ENERGIA.get(i, DEFAULT) for i in instrs)
        total += freq * custo_bloco
    return total

if __name__ == "__main__":
    verbose = "--verbose" in sys.argv
    ll_file = [a for a in sys.argv[1:] if not a.startswith("--")][0]
    print(f"{estimate(ll_file, verbose):.2f}")