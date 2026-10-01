CREATE TYPE tipo_endereco_enum AS ENUM ('Entrega', 'Cobrança');
CREATE TYPE status_entrega_enum AS ENUM ('Pendente', 'Em Transporte', 'Entregue', 'Cancelado');
CREATE TYPE status_pedido_enum AS ENUM ('Pendente', 'Pago', 'Enviado', 'Entregue', 'Cancelado');


CREATE TABLE estados (
    estado_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    sigla CHAR(2) NOT NULL UNIQUE
);

CREATE TABLE cidades (
    cidade_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    estado_id INTEGER REFERENCES estados(estado_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);


CREATE TABLE clientes (
    cliente_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE fornecedores (
    fornecedor_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    contato VARCHAR(100)
);

CREATE TABLE enderecos (
    endereco_id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES clientes(cliente_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    fornecedor_id INTEGER REFERENCES fornecedores(fornecedor_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    tipo_endereco tipo_endereco_enum,
    rua VARCHAR(100) NOT NULL,
    cidade_id INTEGER REFERENCES cidades(cidade_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
    cep VARCHAR(20) NOT NULL,
    pais VARCHAR(50) NOT NULL DEFAULT 'Brasil',
    CONSTRAINT chk_cliente_or_fornecedor CHECK (
        (cliente_id IS NOT NULL AND fornecedor_id IS NULL) OR
        (cliente_id IS NULL AND fornecedor_id IS NOT NULL)
    )
);

--CHECK é uma constraint que limita o intervalo de valores que podem ser colocados em uma coluna. 

CREATE TABLE produtos (
    produto_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco NUMERIC(10,2) NOT NULL,
    estoque INTEGER NOT NULL,
    reservado INTEGER DEFAULT 0,
    disponivel INTEGER NOT NULL
);

CREATE INDEX idx_produtos_nome ON produtos(nome);


CREATE TABLE categorias (
    categoria_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    categoria_pai_id INTEGER REFERENCES categorias(categoria_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);


CREATE TABLE produtos_categorias (
    produto_id INTEGER REFERENCES produtos(produto_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    categoria_id INTEGER REFERENCES categorias(categoria_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    
    PRIMARY KEY (produto_id, categoria_id)
);


CREATE TABLE produtos_fornecedores (
    produto_id INTEGER REFERENCES produtos(produto_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    fornecedor_id INTEGER REFERENCES fornecedores(fornecedor_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);



CREATE TABLE pedidos (
    pedido_id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES clientes(cliente_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
    endereco_entrega_id INTEGER REFERENCES enderecos(endereco_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
    endereco_cobranca_id INTEGER REFERENCES enderecos(endereco_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status status_pedido_enum DEFAULT 'Pendente' NOT NULL,
    subtotal NUMERIC(10,2) NOT NULL,
    desconto NUMERIC(10,2) DEFAULT 0,
    total NUMERIC(10,2) NOT NULL
);



CREATE TABLE itens_pedido (
    pedido_id INTEGER REFERENCES pedidos(pedido_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    produto_id INTEGER REFERENCES produtos(produto_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
    quantidade INTEGER NOT NULL,
    preco_unitario NUMERIC(10,2) NOT NULL,
    PRIMARY KEY (pedido_id, produto_id)
);


CREATE TABLE metodos_pagamento (
    metodo_id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    permite_parcelamento BOOLEAN NOT NULL DEFAULT FALSE,
    desconto NUMERIC(5,2) DEFAULT 0
);


CREATE TABLE pagamentos (
    pagamento_id SERIAL PRIMARY KEY,
    pedido_id INTEGER REFERENCES pedidos(pedido_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    valor NUMERIC(10,2) NOT NULL,
    data_pagamento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    metodo_id INTEGER NOT NULL REFERENCES metodos_pagamento(metodo_id) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
    numero_de_parcelas INTEGER,
    CONSTRAINT chk_numero_de_parcelas CHECK (numero_de_parcelas IS NULL OR numero_de_parcelas > 0)
);


CREATE TABLE cupons_desconto (
    cupom_id SERIAL PRIMARY KEY,
    codigo VARCHAR(50) UNIQUE NOT NULL,
    desconto NUMERIC(5,2) NOT NULL,
    data_validade DATE NOT NULL
);

CREATE TABLE pedidos_cupons (
    pedido_id INTEGER REFERENCES pedidos(pedido_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    cupom_id INTEGER REFERENCES cupons_desconto(cupom_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
    PRIMARY KEY (pedido_id, cupom_id)
);

CREATE TABLE avaliacoes_produto (
    avaliacao_id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES clientes(cliente_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    produto_id INTEGER REFERENCES produtos(produto_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    nota INTEGER CHECK (nota >= 1 AND nota <= 5),
    comentario TEXT,
    data_avaliacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (cliente_id, produto_id)
);


CREATE TABLE entregas (
    entrega_id SERIAL PRIMARY KEY,
    pedido_id INTEGER REFERENCES pedidos(pedido_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    data_entrega_prevista DATE,
    data_entrega_realizada DATE,
    status_entrega status_entrega_enum
);

