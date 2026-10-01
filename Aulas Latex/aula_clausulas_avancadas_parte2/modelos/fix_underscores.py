import re

with open('trabalho_pratico2.tex', 'r', encoding='utf-8') as f:
    text = f.read()

replacements = [
    ('id_tanque', 'id\\_tanque'),
    ('nome_tanque', 'nome\\_tanque'),
    ('capacidade_litros', 'capacidade\\_litros'),
    ('id_lote', 'id\\_lote'),
    ('id_matriz', 'id\\_matriz'),
    ('id_vacina', 'id\\_vacina'),
    ('nome_vacina', 'nome\\_vacina'),
    ('data_fabricacao', 'data\\_fabricacao'),
    ('id_certificado', 'id\\_certificado'),
    ('codigo_inspecao', 'codigo\\_inspecao'),
    ('status_aprovado', 'status\\_aprovado'),
    ('dose_ml', 'dose\\_ml'),
]

for old, new in replacements:
    text = text.replace(new, old)
    text = text.replace(old, new)

# One more fix
text = text.replace('FuncionarioProjeto', 'LoteVacina')
text = text.replace(' tbFuncionario ', ' tbLote ')
text = text.replace(' tbProjeto ', ' tbVacina ')

with open('trabalho_pratico2.tex', 'w', encoding='utf-8') as f:
    f.write(text)

