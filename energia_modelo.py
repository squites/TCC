# energia_modelo.py
ENERGIA_POR_TIPO = {
    'load':   6.0,   # acesso a memória — mais caro
    'store':  6.0,
    'call':   8.0,
    'br':     1.5,
    'fadd':   3.0,   # ponto flutuante
    'fmul':   3.5,
    'fsub':   3.0,
    'fdiv':   5.0,
    'add':    1.0,   # inteiro — mais barato
    'sub':    1.0,
    'mul':    2.0,
    'icmp':   1.0,
    'getelementptr': 1.5,
    'default': 1.0
}