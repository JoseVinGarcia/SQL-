-- Fazendo modificações no banco
-- LEMBRANDO: RODE OS COMANDOS DE CREATE ANTES

USE Mercado;

-- Na tabela CLIENTE o primeiro nome, Daniel, está com um espaço no final, vamos alterar isso
UPDATE cliente
SET nome = 'DANIEL'
WHERE codigo = 1;

-- Na tabela CLIENTE, a coluna telefone está como decimal, vamos alterar para VARCHAR
ALTER TABLE cliente
MODIFY telefone VARCHAR(15);

-- Na tabela GRUPO, está escrito BEBIBAS ao invés de BEBIDAS, vamos alterar isso também
UPDATE grupo
SET descricao = 'BEBIDAS'
WHERE codigo = 3;

-- Alterando o nome de Produtos para Produto
ALTER TABLE produtos
RENAME TO produto;

-- Criando a coluna MARCA com um valor padrão na tabela Produtos
ALTER TABLE produto
ADD MARCA VARCHAR(50) DEFAULT 'n/a';

-- Modificando tipo de dado em Marca
ALTER TABLE produto
MODIFY Marca VARCHAR(200) DEFAULT 'n/a';

-- Removendo a coluna Marca
ALTER TABLE produto
DROP COLUMN Marca;

-- Adicionado o valor de custo onde está NULL
UPDATE produto
SET cod_grupo = 1
WHERE codigo IN (6,7);

-- Adicionando o Preço de Venda
ALTER TABLE produto
ADD COLUMN preco_venda DECIMAL(10, 2);

UPDATE produto
SET preco_venda = CASE codigo
    WHEN 1 THEN 5.50
    WHEN 2 THEN 65.00
    WHEN 3 THEN 9.00
    WHEN 4 THEN 6.50
    WHEN 5 THEN 24.90
    WHEN 6 THEN 28.00
    WHEN 7 THEN 89.90
    WHEN 8 THEN 21.50
    WHEN 9 THEN 10.00
END
WHERE codigo IN (1, 2, 3, 4, 5, 6, 7, 8, 9);

-- Tornando obrigatorio a PRECO_VENDA
ALTER TABLE produto
MODIFY preco_venda DECIMAL(10, 2) NOT NULL;

-- Recalculando o total dos itens (quantidade x preço de venda)
UPDATE pedido_item i
JOIN produto p ON p.codigo = i.codigo_produto
SET i.total = i.quantidade * p.preco_venda
WHERE i.id_item > 0;

-- Acertando os pagamentos para bater com o novo total de cada pedido
-- 1: Cada pagamento recebe o total do pedido
UPDATE pedido_pagamento pg
JOIN (SELECT nro_pedido, SUM(total) AS total_pedido
      FROM pedido_item
      GROUP BY nro_pedido) t ON t.nro_pedido = pg.nro_pedido
SET pg.recebido = t.total_pedido
WHERE pg.id_pgto > 0;

-- 2: O pedido 4 foi pago em duas formas (crédito e débito, valores iguais), cada uma fica com metade
UPDATE pedido_pagamento
SET recebido = ROUND(recebido / 2, 2)
WHERE nro_pedido = 4;
