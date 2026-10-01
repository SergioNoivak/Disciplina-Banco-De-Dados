# 🗄️ Disciplina de Banco de Dados

Bem-vindo ao repositório da disciplina de **Banco de Dados** (UniRV - Universidade de Rio Verde). Este repositório contém todo o material de estudo, apresentações de aula, apostilas em LaTeX, listas de exercícios, conjuntos de dados (datasets), scripts SQL e avaliações práticas.

---

## 📌 Visão Geral do Conteúdo

O repositório está organizado para cobrir desde os fundamentos teóricos de bancos de dados até técnicas avançadas de modelagem, otimização e programação em banco de dados.

### 📚 Principais Módulos Teóricos e Práticos
1. **Introdução a Banco de Dados**: Conceitos fundamentais, SGBDs, arquitetura ANSI/SPARC.
2. **Modelagem Conceptual (MER)**: Entidades, atributos, relacionamentos, cardinalidade, especialização/generalização e agregação.
3. **Modelagem Lógica**: Mapeamento do modelo ER para o modelo relacional, chaves primárias, estrangeiras e integridade referencial.
4. **Normalização de Dados**: 1ª FN, 2ª FN e 3ª FN (eliminação de redundâncias e anomalias).
5. **Linguagem SQL (DDL, DML, DCL)**:
   - **DDL (Data Definition Language)**: `CREATE TABLE`, `ALTER TABLE`, `DROP TABLE`, tipos de dados e restrições.
   - **DML (Data Manipulation Language)**: `INSERT`, `UPDATE`, `DELETE` e `SELECT` (básico e avançado).
   - **Cláusulas Avançadas**: `JOIN` (INNER, LEFT, RIGHT, FULL), `GROUP BY`, `HAVING`, subconsultas e funções de agregação.
   - **DCL (Data Control Language)**: Gerenciamento de permissões (`GRANT`, `REVOKE`).
6. **Desempenho e Indexação**: Criação e estrutura de índices para otimização de consultas SQL.
7. **Programação em Banco de Dados**: Funções, *Stored Procedures* e *Triggers*.

---

## 📂 Estrutura do Repositório

```text
.
├── Aulas BD/                        # Apresentações em PDF e PPTX, scripts de aula
│   └── 1 - Aulas/                   # Slides ordenados por tópicos da disciplina
│       ├── Aula 01 - Introdução ao banco de dados
│       ├── Aula 02 - MER
│       ├── Aula 03 - Relacionamento, Especialização e Agregação
│       ├── Aula 04 & 05 - Modelo Lógico
│       ├── Aula 06 & 07 - Normalização
│       ├── Aula 08 a 11 - DDL (Modelo Físico e Atividades)
│       ├── Aula 12 & 13 - DML Básica e Avançada
│       ├── Aula 14 - Cláusulas Avançadas (SQL SELECT)
│       ├── Aula 15 - DCL
│       ├── Aula 16 - Indexação
│       ├── Aula 17 - Funções e Procedimentos
│       └── Revisão N1 & Material Completo
│
├── Aulas Latex/                     # Códigos-fonte TeX para apostilas, provas e listas
│   ├── apostila_sql/                # Apostila didática de SQL
│   ├── aula_*/                      # Documentos TeX de aulas específicas
│   ├── atividade_*/                 # Atividades práticas (MER, Lógico, Queries)
│   ├── normalizacao_parte_*/        # Material didático de Normalização
│   ├── provas/                      # Avaliações práticas e teóricas
│   ├── csv/                         # Base de dados em formato CSV para exercícios
│   └── notas/                       # (Ignorado no Git) Planilhas de notas dos alunos
│
├── Banco de Dados/                  # Recursos e trabalhos práticos
│   ├── 2 - Atividades/              # Atividades complementares
│   ├── Dataset/                     # Conjuntos de dados para prática de SQL
│   ├── Livro/                       # Materiais e referências bibliográficas
│   └── trabalhoPratico/             # Projetos práticos da disciplina
│
├── atividade/                       # Atividades com diagramas ERD (.png) e relatórios
│   ├── erd1.png ... erd6.png        # Diagramas Entidade-Relacionamento
│   └── atividade_comprof.tex        # Documento TeX de atividade orientada
│
└── .gitignore                       # Filtros de arquivos temporários, LaTeX e notas
```

---

## 🔒 Privacidade e Segurança (.gitignore)

A pasta `Aulas Latex/notas/`, contendo as planilhas de desempenho e notas dos alunos, está configurada no arquivo `.gitignore` para garantir a privacidade e segurança das informações.

Além disso, arquivos temporários de compilação do LaTeX (`.aux`, `.log`, `.fls`, `.fdb_latexmk`, `.synctex.gz`) e arquivos de trava (`.~lock.*#`) são automaticamente ignorados pelo controle de versão.

---

## 🛠️ Requisitos e Ferramentas Recomendadas

- **SGBDs Relacionais**: MySQL, PostgreSQL, SQLite ou MariaDB.
- **Compilador LaTeX**: TeX Live / MikTeX ou extensão LaTeX no VS Code / Overleaf.
- **Visualizador de Diagramas**: MySQL Workbench, brModelo, dbeaver ou dbdiagram.io.
- **Python / Jupyter Notebook**: Para manipulação de datasets `.csv` e integração com bancos de dados.

---

## ✒️ Autor / Instituição

- **Instituição**: UniRV - Universidade de Rio Verde
- **Disciplina**: Banco de Dados
