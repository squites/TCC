#!/bin/bash

# Uso: ./run.sh <caminho_do_source> <nome_saida>
#
# Exemplos:
#   ./run.sh cbench/telecom_CRC32/src crc32
#   ./run.sh cbench/automotive_qsort1/src qsort
#   ./run.sh benchmarks/matmul.c matmul

SOURCE=$1
NOME=$2

if [ -z "$SOURCE" ] || [ -z "$NOME" ]; then
    echo "Uso: $0 <caminho_do_source> <nome_saida>"
    echo ""
    echo "Exemplos:"
    echo "  $0 cbench/telecom_CRC32/src crc32"
    echo "  $0 cbench/automotive_qsort1/src qsort"
    echo "  $0 benchmarks/matmul.c matmul"
    exit 1
fi

mkdir -p ir
TMP=$(mktemp -d)
SDK=$(xcrun --show-sdk-path 2>/dev/null)
ROOT="$(cd "$(dirname "$0")" && pwd)"

echo "Gerando IR de $NOME..."

# se SOURCE é uma pasta (múltiplos .c), junta com llvm-link
# se é um arquivo único, gera direto
if [ -d "$SOURCE" ]; then
    cd $TMP
    clang -O0 -Xclang -disable-O0-optnone -emit-llvm -S \
        -isysroot $SDK "$ROOT/$SOURCE"/*.c 2>/dev/null

    if ! ls *.ll >/dev/null 2>&1; then
        echo "  ✗ falha ao compilar"
        rm -rf $TMP
        exit 1
    fi

    llvm-link -S *.ll -o "$ROOT/ir/${NOME}.ll"
    cd "$ROOT"
elif [ -f "$SOURCE" ]; then
    clang -O0 -Xclang -disable-O0-optnone -emit-llvm -S \
        -isysroot $SDK "$SOURCE" -o ir/${NOME}.ll 2>/dev/null

    if [ ! -f "ir/${NOME}.ll" ]; then
        echo "  ✗ falha ao compilar"
        rm -rf $TMP
        exit 1
    fi
else
    echo "  ✗ caminho não encontrado: $SOURCE"
    rm -rf $TMP
    exit 1
fi

# normaliza para SSA
opt -passes="mem2reg,loop-simplify" -S ir/${NOME}.ll -o ir/${NOME}_ssa.ll

rm -rf $TMP

echo "  ✓ ir/${NOME}.ll gerado"
echo "  ✓ ir/${NOME}_ssa.ll gerado (normalizado)"
