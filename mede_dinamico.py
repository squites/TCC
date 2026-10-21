##!/usr/bin/env python3
## mede_dinamico.py — consolida as medições dinâmicas (mperf + powermetrics) de
## resultados_dinamico/ e compara com a estimativa estática (estima_energia_v4.py).
##
## A comparação segue as duas perguntas causais do modelo estático:
##   (a) o passe removeu o trabalho que o modelo estima? -> ΔnJ estático  ×  Δ instruções
##   (b) menos instruções virou menos tempo/energia?     -> Δ instruções  ×  Δ cycles / Δ mJ
##
## Repetições: cada step é medido REPETICOES vezes (ver experimento_dinamico.sh);
## a 1ª repetição é descartada (warmup) e as demais entram como mediana, com a
## dispersão de Δcycles entre reps em [min..max] — o piso de ruído da medição.
##
## Uso: python3 mede_dinamico.py     (depois de ./experimento_dinamico.sh)
#
#import hashlib
#import json
#import re
#import statistics
#import subprocess
#import sys
#from collections import defaultdict
#from pathlib import Path
#
#DIR_RES = Path("resultados_dinamico")
#DIR_IR = Path("ir_opt_dyn")
#
#
#def parse_mperf(path):
#    """JSON do mperf; tolerante a lixo antes/depois do objeto."""
#    texto = path.read_text()
#    ini, fim = texto.find("{"), texto.rfind("}")
#    if ini == -1 or fim <= ini:
#        return None
#    try:
#        return json.loads(texto[ini:fim + 1])
#    except json.JSONDecodeError:
#        return None
#
#
#def parse_power(path):
#    """Média de 'CPU Power: X mW' do powermetrics, descartando a 1ª e a última
#    amostras (janelas parciais, antes/depois da execução)."""
#    pot = [float(m.group(1)) for m in
#           re.finditer(r"CPU Power:\s*([\d.]+)\s*mW", path.read_text())]
#    if len(pot) > 2:
#        pot = pot[1:-1]
#    return sum(pot) / len(pot) if pot else None
#
#
#def contador(counters, nome):
#    return counters.get(nome, 0)
#
#
#def ir_do_tag(tag):
#    """IR que foi de fato medida para o tag. O baseline usa o _ssa.ll; o _base.ll
#    é a saída crua do clang (pré-mem2reg) e NÃO representa o que foi medido."""
#    if tag.endswith("_base"):
#        return DIR_IR / (tag[:-len("_base")] + "_ssa.ll")
#    return DIR_IR / f"{tag}.ll"
#
#
#def hash_ir(ll):
#    """Hash da IR ignorando comentários (';' — o ModuleID muda de path entre steps).
#    Usado para detectar steps com IR idêntica (passes que não dispararam), cuja
#    medição é compartilhada pelo experimento_dinamico.sh (deduplicação)."""
#    if not ll.exists():
#        return None
#    linhas = [l for l in ll.read_text().splitlines() if not l.startswith(";")]
#    return hashlib.md5("\n".join(linhas).encode()).hexdigest()
#
#
#def estatico_nj(tag):
#    """Estimativa estática (nJ) da IR do step, via estima_energia_v4.py."""
#    ll = ir_do_tag(tag)
#    if not ll.exists():
#        return None
#    out = subprocess.run(["python3", "estima_energia_v4.py", str(ll)],
#                         capture_output=True, text=True)
#    try:
#        return float(out.stdout.strip())
#    except ValueError:
#        return None
#
#
#def metricas(dados, power_mw):
#    c = dados.get("counters", {})
#    cycles = contador(c, "cycles")
#    instr = contador(c, "instructions")
#    if not cycles or not instr:
#        return None
#    ldst = contador(c, "INST_LDST")
#    simd_uop = contador(c, "MAP_SIMD_UOP")
#    branch = contador(c, "INST_BRANCH")
#    brmiss = contador(c, "BRANCH_MISPRED_NONSPEC")
#    l1d = contador(c, "L1D_CACHE_MISS_LD") + contador(c, "L1D_CACHE_MISS_ST")
#    wall_s = dados.get("time", {}).get("wall_ns", 0) / 1e9
#    return {
#        "cycles": cycles,
#        "instr": instr,
#        "ldst": ldst,
#        "ipc": instr / cycles,
#        "l1d_miss_1k": 1000.0 * l1d / instr,          # misses L1D por 1000 instruções
#        "br_miss_pct": 100.0 * brmiss / branch if branch else 0.0,
#        "ldst_pct": 100.0 * ldst / instr,              # contrapartida dinâmica do caracteriza.py
#        # MAP_SIMD_UOP inclui FP escalar (mapeia na unidade SIMD do M1), então o
#        # baseline não é zero — a métrica sobe após loop-vectorize porque o total
#        # de instruções cai para o mesmo trabalho FP
#        "simd_pct": 100.0 * simd_uop / instr,
#        "energia_mJ": power_mw * wall_s if power_mw and wall_s else None,
#    }
#
#
#def mediana(valores):
#    vals = [v for v in valores if v is not None]
#    return statistics.median(vals) if vals else None
#
#
#def human(v):
#    """36.7G / 820M — magnitude legível."""
#    if v is None:
#        return "-"
#    if abs(v) >= 1e9:
#        return f"{v / 1e9:.2f}G"
#    if abs(v) >= 1e6:
#        return f"{v / 1e6:.1f}M"
#    return f"{v:.0f}"
#
#
#def pct(novo, ref):
#    if novo is None or not ref:
#        return None
#    return (novo - ref) / ref * 100
#
#
#def fp(v):
#    """Formata percentual com sinal, ou '-'."""
#    return f"{v:+.1f}%" if v is not None else "-"
#
#
#def main():
#    # agrupa repetições: tag -> [(índice_rep, caminho)]; arquivos antigos sem
#    # ".repN" contam como repetição única (compatibilidade)
#    grupos = defaultdict(list)
#    for p in DIR_RES.glob("*.mperf.json"):
#        stem = p.name[:-len(".mperf.json")]
#        m = re.match(r"^(.*)\.rep(\d+)$", stem)
#        if m:
#            grupos[m.group(1)].append((int(m.group(2)), p))
#        else:
#            grupos[stem].append((0, p))
#    if not grupos:
#        sys.exit("Nenhuma medição em resultados_dinamico/ — rode ./experimento_dinamico.sh")
#
#    progs = sorted({t[:-len("_base")] if t.endswith("_base") else t.split("_seq")[0]
#                    for t in grupos})
#
#    for prog in progs:
#        print("=" * 100)
#        print(f"=== PROGRAMA: {prog} ===")
#        print("=" * 100)
#        print("  leitura: (a) modelo x instruções: Δest(nJ) × Δinstr   |"
#              "   (b) instruções x máquina: Δinstr × Δcycles / ΔE")
#
#        tags_prog = [t for t in grupos if t == f"{prog}_base" or t.startswith(f"{prog}_seq")]
#        tags_prog.sort(key=lambda t: (t != f"{prog}_base",
#                                      t.split("_seq")[1].split("_step")[0] if "_seq" in t else "",
#                                      int(t.rsplit("_step", 1)[1]) if "_step" in t else 0))
#
#        base = base_nj = None
#        seq_atual = None
#        vistos = {}     # hash_ir -> primeiro tag (deduplicação por IR idêntica)
#        for tag in tags_prog:
#            reps = sorted(grupos[tag])
#            if len(reps) > 1:
#                reps = reps[1:]          # descarta a 1ª repetição (warmup)
#            medidas = []
#            for _, p in reps:
#                dados = parse_mperf(p)
#                pw = Path(str(p).replace(".mperf.json", ".power.txt"))
#                power = parse_power(pw) if pw.exists() else None
#                m = metricas(dados, power) if dados else None
#                if m:
#                    medidas.append(m)
#            if not medidas:
#                print(f"  {tag}: sem dados válidos")
#                continue
#            med = {k: mediana([x[k] for x in medidas]) for k in medidas[0]}
#            nj = estatico_nj(tag)
#            nreps = len(medidas)
#
#            h = hash_ir(ir_do_tag(tag))
#            if h is not None and h in vistos:
#                nota = f"  [IR idêntica a {vistos[h]} — medição compartilhada]"
#            else:
#                nota = ""
#                if h is not None:
#                    vistos[h] = tag
#
#            if tag == f"{prog}_base":
#                print(f"\n--- baseline (sem passes; {nreps} reps) ---")
#            else:
#                seq = tag.split("_seq")[1].split("_step")[0]
#                if seq != seq_atual:
#                    seq_atual = seq
#                    arq_seq = DIR_RES / f"{prog}_seq{seq}.seq"
#                    desc = arq_seq.read_text().strip() if arq_seq.exists() else ""
#                    print(f"\n--- seq{seq}: {desc} ({nreps} reps) ---")
#
#            if tag == f"{prog}_base":
#                base, base_nj = med, nj
#                # dispersão de cycles do baseline = indicador do piso de ruído
#                cycs = [x["cycles"] for x in medidas]
#                ruido = (max(cycs) - min(cycs)) / 2 / med["cycles"] * 100
#                print(f"  {tag:<26} est={nj:>13,.0f} nJ | "
#                      f"instr={human(med['instr'])} | ldst={human(med['ldst'])} | "
#                      f"cycles={human(med['cycles'])} (±{ruido:.1f}%) | "
#                      f"IPC={med['ipc']:.2f} | L1D/1k={med['l1d_miss_1k']:.1f} | "
#                      f"LDST={med['ldst_pct']:.1f}% | SIMD={med['simd_pct']:.1f}% | "
#                      f"E={med['energia_mJ']:,.0f} mJ{nota}")
#                continue
#
#            d_nj = pct(nj, base_nj)
#            d_i = pct(med["instr"], base["instr"])
#            d_l = pct(med["ldst"], base["ldst"])
#            d_c = pct(med["cycles"], base["cycles"])
#            d_e = pct(med["energia_mJ"], base["energia_mJ"])
#            dcs = [pct(x["cycles"], base["cycles"]) for x in medidas]
#            lo, hi = min(dcs), max(dcs)
#
#            print(f"  {tag:<26} est={nj:>13,.0f} nJ ({fp(d_nj):>7}) | "
#                  f"(a) Δinstr {fp(d_i):>7} Δldst {fp(d_l):>7} | "
#                  f"(b) cycles={human(med['cycles'])} ({fp(d_c):>7} "
#                  f"[{lo:+.1f}% .. {hi:+.1f}%]) IPC={med['ipc']:.2f} | "
#                  f"L1D/1k={med['l1d_miss_1k']:.1f} | SIMD={med['simd_pct']:.1f}% | "
#                  f"E={med['energia_mJ']:,.0f} mJ ({fp(d_e):>7}){nota}")
#        print()
#
#
#if __name__ == "__main__":
#    main()

#!/usr/bin/env python3
# mede_dinamico.py — consolida as medições dinâmicas (mperf + IOReport) de
# resultados_dinamico/ e compara com a estimativa estática (estima_energia_v4.py).
#
# A comparação segue as duas perguntas do trabalho:
#   (a) o passe removeu o trabalho que o modelo estima? -> Δ custo estático × Δ instruções
#   (b) menos instruções virou menos tempo/energia?     -> Δ instruções × Δ cycles / Δ energia
#
# Energia (IOReport, lida pelo driver):
#   E_kernel = energia do canal durante as N execuções do kernel
#   E_ativa  = E_kernel − (E_repouso / t_repouso) × t_kernel
#   A energia ativa desconta o consumo de fundo do sistema no mesmo intervalo.
#
# Repetições: a 1ª é descartada (warmup); as demais entram como mediana, com a
# dispersão entre reps em [min..max] — o piso de ruído da medição.
#
# Uso: python3 mede_dinamico.py     (depois de ./experimento_dinamico.sh)

import hashlib
import json
import re
import statistics
import subprocess
import sys
from collections import defaultdict
from pathlib import Path

DIR_RES = Path("resultados_dinamico")
DIR_IR = Path("ir_opt_dyn")


def parse_mperf(path):
    """JSON do mperf; tolerante a lixo antes/depois do objeto."""
    texto = path.read_text()
    ini, fim = texto.find("{"), texto.rfind("}")
    if ini == -1 or fim <= ini:
        return None
    try:
        return json.loads(texto[ini:fim + 1])
    except json.JSONDecodeError:
        return None


def parse_energia(path):
    """Arquivo do driver: cabeçalho com repouso_s/kernel_s e uma linha por canal
    (canal, unidade, repouso_J, kernel_J). Retorna energias de CPU e DRAM."""
    info, canais = {}, {}
    for linha in path.read_text().splitlines():
        if linha.startswith("#"):
            for par in linha[1:].split():
                chave, _, valor = par.partition("=")
                info[chave] = float(valor)
            continue
        partes = linha.split("\t")
        if len(partes) != 4 or partes[0] == "canal":
            continue
        nome, _unidade, rep, ker = partes
        canais[nome] = (float(rep), float(ker))
    if not canais or "repouso_s" not in info or "kernel_s" not in info:
        return None

    rs, ks = info["repouso_s"], info["kernel_s"]

    def somar(filtro):
        sel = [v for k, v in canais.items() if filtro(k)]
        if not sel:
            return None, None
        rep = sum(v[0] for v in sel)
        ker = sum(v[1] for v in sel)
        return ker, ker - (rep / rs) * ks

    # "CPU Energy" é o agregado da CPU; os canais por núcleo já estão incluídos nele
    e_cpu, e_cpu_ativa = somar(lambda k: k.endswith("CPU Energy"))
    e_dram, e_dram_ativa = somar(lambda k: "DRAM" in k)
    return {
        "e_cpu_J": e_cpu,
        "e_cpu_ativa_J": e_cpu_ativa,
        "e_dram_J": e_dram,
        "e_dram_ativa_J": e_dram_ativa,
    }


def contador(counters, nome):
    return counters.get(nome, 0)


def ir_do_tag(tag):
    """IR que foi de fato medida para o tag. Baseline e A/A usam o _ssa.ll."""
    for sufixo in ("_base", "_aa"):
        if tag.endswith(sufixo):
            return DIR_IR / (tag[:-len(sufixo)] + "_ssa.ll")
    return DIR_IR / f"{tag}.ll"


def hash_ir(ll):
    """Hash da IR ignorando comentários (';'), para detectar IRs idênticas."""
    if not ll.exists():
        return None
    linhas = [l for l in ll.read_text().splitlines() if not l.startswith(";")]
    return hashlib.md5("\n".join(linhas).encode()).hexdigest()


def estatico(tag):
    """Custo estimado (unidades arbitrárias) da IR do step, via estima_energia_v4.py."""
    ll = ir_do_tag(tag)
    if not ll.exists():
        return None
    out = subprocess.run(["python3", "estima_energia_v4.py", str(ll)],
                         capture_output=True, text=True)
    try:
        return float(out.stdout.strip())
    except ValueError:
        return None


def metricas(dados, energia):
    c = dados.get("counters", {})
    cycles = contador(c, "cycles")
    instr = contador(c, "instructions")
    if not cycles or not instr:
        return None
    ldst = contador(c, "INST_LDST")
    simd_uop = contador(c, "MAP_SIMD_UOP")
    branch = contador(c, "INST_BRANCH")
    brmiss = contador(c, "BRANCH_MISPRED_NONSPEC")
    l1d = contador(c, "L1D_CACHE_MISS_LD") + contador(c, "L1D_CACHE_MISS_ST")
    m = {
        "cycles": cycles,
        "instr": instr,
        "ldst": ldst,
        "ipc": instr / cycles,
        "l1d_miss_1k": 1000.0 * l1d / instr,
        "br_miss_pct": 100.0 * brmiss / branch if branch else 0.0,
        "ldst_pct": 100.0 * ldst / instr,
        # MAP_SIMD_UOP inclui FP escalar no M1, então o baseline não é zero
        "simd_pct": 100.0 * simd_uop / instr,
        "e_cpu_J": None, "e_cpu_ativa_J": None,
        "e_dram_J": None, "e_dram_ativa_J": None,
    }
    if energia:
        m.update(energia)
    return m


def mediana(valores):
    vals = [v for v in valores if v is not None]
    return statistics.median(vals) if vals else None


def human(v):
    if v is None:
        return "-"
    if abs(v) >= 1e9:
        return f"{v / 1e9:.2f}G"
    if abs(v) >= 1e6:
        return f"{v / 1e6:.1f}M"
    return f"{v:.0f}"


def pct(novo, ref):
    if novo is None or not ref:
        return None
    return (novo - ref) / ref * 100


def fp(v):
    return f"{v:+.1f}%" if v is not None else "-"


def fj(v):
    return f"{v:.3f} J" if v is not None else "-"


def faixa(vals):
    vals = [v for v in vals if v is not None]
    return f"[{min(vals):+.1f}% .. {max(vals):+.1f}%]" if vals else "[-]"

def carregar(reps_por_indice):
    """rep -> métricas, descartando a 1ª rodada (warmup)."""
    indices = sorted(reps_por_indice)
    if len(indices) > 1:
        indices = indices[1:]
    out = {}
    for r in indices:
        p = reps_por_indice[r]
        dados = parse_mperf(p)
        pe = Path(str(p).replace(".mperf.json", ".energy.txt"))
        energia = parse_energia(pe) if pe.exists() else None
        m = metricas(dados, energia) if dados else None
        if m:
            out[r] = m
    return out


def delta_pareado(reps, base_reps, chave):
    """Mediana e faixa das variações rodada a rodada contra o baseline."""
    comuns = sorted(set(reps) & set(base_reps))
    ds = [pct(reps[r][chave], base_reps[r][chave]) for r in comuns]
    ds = [d for d in ds if d is not None]
    if not ds:
        return None, "[-]", ""
    lo, hi = min(ds), max(ds)
    marca = " ✓" if lo > 0 or hi < 0 else ""
    return statistics.median(ds), f"[{lo:+.1f}% .. {hi:+.1f}%]", marca


def main():
    grupos = defaultdict(dict)   # tag -> {rep: caminho}
    for p in DIR_RES.glob("*.mperf.json"):
        m = re.match(r"^(.*)\.rep(\d+)$", p.name[:-len(".mperf.json")])
        if m:
            grupos[m.group(1)][int(m.group(2))] = p
    if not grupos:
        sys.exit("Nenhuma medição em resultados_dinamico/ — rode ./experimento_dinamico.sh")

    invalidos = sorted(p.name[:-len(".invalido")] for p in DIR_RES.glob("*.invalido"))
    progs = sorted({t[:-len("_base")] for t in grupos if t.endswith("_base")})

    for prog in progs:
        print("=" * 100)
        print(f"=== PROGRAMA: {prog} ===")
        print("=" * 100)
        print("  Δ de cycles e energia: pareados por rodada contra o baseline da mesma rodada;"
              " ✓ = intervalo exclui zero")

        inv = [t for t in invalidos if t.startswith(prog)]
        if inv:
            print(f"  versões INVÁLIDAS (checksum diferente do baseline): {', '.join(inv)}")

        base_tag, aa_tag = f"{prog}_base", f"{prog}_aa"
        base_reps = carregar(grupos[base_tag])
        if not base_reps:
            print("  baseline sem dados válidos")
            continue
        base_med = {k: mediana([m[k] for m in base_reps.values()])
                    for k in next(iter(base_reps.values()))}
        base_est = estatico(base_tag)

        print(f"\n--- baseline ({len(base_reps)} rodadas) ---")
        print(f"  {base_tag:<26} est={base_est:>15,.0f} | instr={human(base_med['instr'])} | "
              f"ldst={human(base_med['ldst'])} | cycles={human(base_med['cycles'])} | "
              f"IPC={base_med['ipc']:.2f} | L1D/1k={base_med['l1d_miss_1k']:.1f} | "
              f"SIMD={base_med['simd_pct']:.1f}% | E={fj(base_med['e_cpu_J'])}")

        def linha(tag, nota=""):
            reps = carregar(grupos[tag])
            if not reps:
                print(f"  {tag}: sem dados válidos")
                return
            med = {k: mediana([m[k] for m in reps.values()]) for k in next(iter(reps.values()))}
            est = estatico(tag)
            d_c, f_c, s_c = delta_pareado(reps, base_reps, "cycles")
            d_e, f_e, s_e = delta_pareado(reps, base_reps, "e_cpu_J")
            print(f"  {tag:<26} est={est:>15,.0f} ({fp(pct(est, base_est)):>7}) | "
                  f"Δinstr {fp(pct(med['instr'], base_med['instr'])):>7} "
                  f"Δldst {fp(pct(med['ldst'], base_med['ldst'])):>7} | "
                  f"Δcycles {fp(d_c):>7} {f_c}{s_c} IPC={med['ipc']:.2f} | "
                  f"SIMD={med['simd_pct']:.1f}% | ΔE {fp(d_e):>7} {f_e}{s_e}{nota}")

        if aa_tag in grupos:
            print("\n--- controle A/A: mesmo binário do baseline, medido como versão separada ---")
            linha(aa_tag)

        tags_seq = sorted((t for t in grupos if t.startswith(f"{prog}_seq")),
                          key=lambda t: (t.split("_seq")[1].split("_step")[0],
                                         int(t.rsplit("_step", 1)[1])))
        vistos = {hash_ir(ir_do_tag(base_tag)): base_tag}
        seq_atual = None
        for tag in tags_seq:
            seq = tag.split("_seq")[1].split("_step")[0]
            if seq != seq_atual:
                seq_atual = seq
                arq_seq = DIR_RES / f"{prog}_seq{seq}.seq"
                desc = arq_seq.read_text().strip() if arq_seq.exists() else ""
                print(f"\n--- seq{seq}: {desc} ---")
            h = hash_ir(ir_do_tag(tag))
            nota = ""
            if h is not None and h in vistos:
                nota = f"  [IR idêntica a {vistos[h]} — medição compartilhada]"
            elif h is not None:
                vistos[h] = tag
            linha(tag, nota)
        print()

#def main():
#    grupos = defaultdict(list)
#    for p in DIR_RES.glob("*.mperf.json"):
#        stem = p.name[:-len(".mperf.json")]
#        m = re.match(r"^(.*)\.rep(\d+)$", stem)
#        if m:
#            grupos[m.group(1)].append((int(m.group(2)), p))
#        else:
#            grupos[stem].append((0, p))
#    if not grupos:
#        sys.exit("Nenhuma medição em resultados_dinamico/ — rode ./experimento_dinamico.sh")
#
#    invalidos = sorted(p.name[:-len(".invalido")] for p in DIR_RES.glob("*.invalido"))
#
#    progs = sorted({t[:-len("_base")] if t.endswith("_base") else t.split("_seq")[0]
#                    for t in grupos})
#
#    for prog in progs:
#        print("=" * 100)
#        print(f"=== PROGRAMA: {prog} ===")
#        print("=" * 100)
#        print("  leitura: (a) modelo × instruções: Δest × Δinstr   |"
#              "   (b) instruções × máquina: Δinstr × Δcycles / ΔE (energia ativa)")
#
#        inv = [t for t in invalidos if t.startswith(prog)]
#        if inv:
#            print(f"  versões INVÁLIDAS (checksum diferente do baseline): {', '.join(inv)}")
#
#        tags_prog = [t for t in grupos if t == f"{prog}_base" or t.startswith(f"{prog}_seq")]
#        tags_prog.sort(key=lambda t: (t != f"{prog}_base",
#                                      t.split("_seq")[1].split("_step")[0] if "_seq" in t else "",
#                                      int(t.rsplit("_step", 1)[1]) if "_step" in t else 0))
#
#        base = base_est = None
#        seq_atual = None
#        vistos = {}
#        for tag in tags_prog:
#            reps = sorted(grupos[tag])
#            if len(reps) > 1:
#                reps = reps[1:]          # descarta a 1ª repetição (warmup)
#            medidas = []
#            for _, p in reps:
#                dados = parse_mperf(p)
#                pe = Path(str(p).replace(".mperf.json", ".energy.txt"))
#                energia = parse_energia(pe) if pe.exists() else None
#                m = metricas(dados, energia) if dados else None
#                if m:
#                    medidas.append(m)
#            if not medidas:
#                print(f"  {tag}: sem dados válidos")
#                continue
#            med = {k: mediana([x[k] for x in medidas]) for k in medidas[0]}
#            est = estatico(tag)
#            nreps = len(medidas)
#
#            h = hash_ir(ir_do_tag(tag))
#            if h is not None and h in vistos:
#                nota = f"  [IR idêntica a {vistos[h]} — medição compartilhada]"
#            else:
#                nota = ""
#                if h is not None:
#                    vistos[h] = tag
#
#            if tag == f"{prog}_base":
#                print(f"\n--- baseline (sem passes; {nreps} reps) ---")
#            else:
#                seq = tag.split("_seq")[1].split("_step")[0]
#                if seq != seq_atual:
#                    seq_atual = seq
#                    arq_seq = DIR_RES / f"{prog}_seq{seq}.seq"
#                    desc = arq_seq.read_text().strip() if arq_seq.exists() else ""
#                    print(f"\n--- seq{seq}: {desc} ({nreps} reps) ---")
#
#            if tag == f"{prog}_base":
#                base, base_est = med, est
#                cycs = [x["cycles"] for x in medidas]
#                ruido_c = (max(cycs) - min(cycs)) / 2 / med["cycles"] * 100
#                ecpu = [x["e_cpu_ativa_J"] for x in medidas if x["e_cpu_ativa_J"] is not None]
#                ruido_e = ((max(ecpu) - min(ecpu)) / 2 / med["e_cpu_ativa_J"] * 100
#                           if ecpu and med["e_cpu_ativa_J"] else None)
#                print(f"  {tag:<26} est={est:>15,.0f} | "
#                      f"instr={human(med['instr'])} | ldst={human(med['ldst'])} | "
#                      f"cycles={human(med['cycles'])} (±{ruido_c:.1f}%) | "
#                      f"IPC={med['ipc']:.2f} | L1D/1k={med['l1d_miss_1k']:.1f} | "
#                      f"LDST={med['ldst_pct']:.1f}% | SIMD={med['simd_pct']:.1f}% | "
#                      f"Ecpu={fj(med['e_cpu_ativa_J'])}"
#                      + (f" (±{ruido_e:.1f}%)" if ruido_e is not None else "")
#                      + f" | Edram={fj(med['e_dram_ativa_J'])}{nota}")
#                continue
#
#            d_est = pct(est, base_est)
#            d_i = pct(med["instr"], base["instr"])
#            d_l = pct(med["ldst"], base["ldst"])
#            d_c = pct(med["cycles"], base["cycles"])
#            d_ecpu = pct(med["e_cpu_ativa_J"], base["e_cpu_ativa_J"])
#            d_edram = pct(med["e_dram_ativa_J"], base["e_dram_ativa_J"])
#            f_c = faixa([pct(x["cycles"], base["cycles"]) for x in medidas])
#            f_e = faixa([pct(x["e_cpu_ativa_J"], base["e_cpu_ativa_J"]) for x in medidas])
#            d_ebruta = pct(med["e_cpu_J"], base["e_cpu_J"])
#            f_eb = faixa([pct(x["e_cpu_J"], base["e_cpu_J"]) for x in medidas])
#
#            print(f"  {tag:<26} est={est:>15,.0f} ({fp(d_est):>7}) | "
#                  f"(a) Δinstr {fp(d_i):>7} Δldst {fp(d_l):>7} | "
#                  f"(b) Δcycles {fp(d_c):>7} {f_c} IPC={med['ipc']:.2f} | "
#                  #f"ΔEcpu {fp(d_ecpu):>7} {f_e} | ΔEdram {fp(d_edram):>7}{nota}")
#                  f"ΔEcpu {fp(d_ecpu):>7} {f_e} | ΔEbruta {fp(d_ebruta):>7} {f_eb}{nota}")
#        print()


if __name__ == "__main__":
    main()