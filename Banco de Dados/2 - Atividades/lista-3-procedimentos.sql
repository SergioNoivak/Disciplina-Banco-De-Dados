-- EXERCÍCIO (6)

CREATE OR REPLACE PROCEDURE registrar_produto(
    p_nome VARCHAR,
    p_descricao TEXT,
    p_preco NUMERIC,
    p_estoque INTEGER
) LANGUAGE plpgsql AS $$
DECLARE
    v_disponivel INTEGER;
BEGIN
    v_disponivel := p_estoque;

    INSERT INTO produtos (
        nome,
        descricao,
        preco,
        estoque,
        reservado,
        disponivel
    ) VALUES (
        p_nome,
        p_descricao,
        p_preco,
        p_estoque,
        0,
        v_disponivel
    );
END;
$$;

-- Exemplo de uso:
CALL registrar_produto('Notebook Gamer', 'Notebook para jogos', 5000.00, 10);

-- EXERCÍCIO (7)


CREATE OR REPLACE PROCEDURE registrar_pedido(
    p_cliente_id INTEGER,
    p_produto_id INTEGER,
    p_quantidade INTEGER
) LANGUAGE plpgsql AS $$
DECLARE
    v_pedido_id INTEGER;
    v_preco_unitario NUMERIC;
BEGIN
    -- Obter preço do produto
    SELECT preco INTO v_preco_unitario
    FROM produtos
    WHERE produto_id = p_produto_id;

    -- Criar pedido
    INSERT INTO pedidos (
        cliente_id,
        status,
        subtotal,
        total
    ) VALUES (
        p_cliente_id,
        'Pendente',
        v_preco_unitario * p_quantidade,
        v_preco_unitario * p_quantidade
    ) RETURNING pedido_id INTO v_pedido_id;

    -- Inserir item do pedido
    INSERT INTO itens_pedido (
        pedido_id,
        produto_id,
        quantidade,
        preco_unitario
    ) VALUES (
        v_pedido_id,
        p_produto_id,
        p_quantidade,
        v_preco_unitario
    );

    -- Atualizar reserva e disponibilidade do produto
    UPDATE produtos
    SET reservado = reservado + p_quantidade,
        disponivel = disponivel - p_quantidade
    WHERE produto_id = p_produto_id;
END;
$$;

-- Exemplo de uso:
CALL registrar_pedido(1, 1, 2);

-- EXERCÍCIO (8)

CREATE OR REPLACE PROCEDURE confirmar_pagamento_pedido(
    p_pedido_id INTEGER
) LANGUAGE plpgsql AS $$
DECLARE
    v_produto_id INTEGER;
    v_quantidade INTEGER;
BEGIN
    -- Obter informações do item do pedido
    SELECT produto_id, quantidade 
    INTO v_produto_id, v_quantidade
    FROM itens_pedido 
    WHERE pedido_id = p_pedido_id;

    -- Atualizar status do pedido
    UPDATE pedidos
    SET status = 'Pago'
    WHERE pedido_id = p_pedido_id;

    -- Atualizar estoque e reserva do produto
    UPDATE produtos
    SET estoque = estoque - v_quantidade,
        reservado = reservado - v_quantidade
    WHERE produto_id = v_produto_id;
END;
$$;

-- Exemplo de uso:
CALL confirmar_pagamento_pedido(1);

-- EXERCÍCIO (9)


CREATE OR REPLACE PROCEDURE registrar_avaliacao(
    p_cliente_id INTEGER,
    p_produto_id INTEGER,
    p_nota INTEGER,
    p_comentario TEXT
) LANGUAGE plpgsql AS $$
DECLARE
    v_comprou BOOLEAN;
BEGIN
    -- Verifica se o cliente comprou o produto
    SELECT EXISTS (
        SELECT 1 
        FROM pedidos p
        JOIN itens_pedido ip ON p.pedido_id = ip.pedido_id
        WHERE p.cliente_id = p_cliente_id
        AND ip.produto_id = p_produto_id
        AND p.status = 'Entregue'
    ) INTO v_comprou;

    IF v_comprou THEN
        INSERT INTO avaliacoes_produto (
            cliente_id,
            produto_id,
            nota,
            comentario
        ) VALUES (
            p_cliente_id,
            p_produto_id,
            p_nota,
            p_comentario
        );
    END IF;
END;
$$;