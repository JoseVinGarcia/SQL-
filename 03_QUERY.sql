-- Consultas

USE Mercado;

-- Consulta 1: Nome de clientes com telefone, organizados por ordem alfabética:
SELECT * FROM mercado.cliente
WHERE telefone IS NOT NULL
ORDER BY nome;

-- Consulta 2: Os 3 produtos de maior custo
SELECT * FROM produto
ORDER BY custo DESC
LIMIT 3;

-- Consulta 3: Pedidos de Janeiro/2019
SELECT * FROM mercado.pedido
WHERE data_emissao BETWEEN '2019_01_01' AND '2019_01_31';

-- Consulta 4: Quantidade de produtos por grupo, incluindo grupos vazios
SELECT g.descricao, count(p.cod_grupo) AS quantidade
FROM grupo g
LEFT JOIN produto p
ON g.codigo = p.cod_grupo
GROUP BY g.descricao;

-- Consulta 5: Total comprado por cliente
-- Cliente vem primeiro, para exibir também os cliente sem pedido
-- Distinct, senão a consulta conta quantas linhas de itens o cliente comprou, não quantos pedidos ele fechou
SELECT c.nome, COUNT(DISTINCT p.numero_pedido) AS quantidade, COALESCE(SUM(pi.total),0) AS total
FROM cliente c
LEFT JOIN pedido p
ON p.codigo_cliente = c.codigo
LEFT JOIN pedido_item pi
-- And para filtrar só os pedidos não cancelados
ON pi.nro_pedido = p.numero_pedido AND pi.cancelado = 'N'
GROUP BY c.nome
ORDER BY total DESC;

-- Consulta 6: Quantidade vendida por produto
SELECT p.codigo, p.descricao, COALESCE(SUM(pi.quantidade),0) AS quantidade_vendida
FROM produto p
LEFT JOIN pedido_item pi
ON p.codigo = pi.codigo_produto
GROUP BY p.codigo, p.descricao
ORDER BY quantidade_vendida DESC;

-- Consulta 7: Produtos nunca vendidos
-- Usamos o filtro WHERE para encontrar na tabela pedido_item os codigos de produto não listados!
SELECT p.codigo, p.descricao, COALESCE(SUM(pi.quantidade),0) AS quantidade_vendida
FROM produto p
LEFT JOIN pedido_item pi
ON p.codigo = pi.codigo_produto
WHERE pi.codigo_produto IS NULL 
GROUP BY p.codigo, p.descricao
ORDER BY quantidade_vendida DESC;

-- Consulta 8: Clientes que nunca fizeram pedido
SELECT * FROM cliente c
LEFT JOIN pedido p
ON c.codigo = p.codigo_cliente
WHERE p.codigo_cliente IS NULL;

-- Consulta 9: Pedidos e faturamento por mês
-- Formatamos os dados para Ano e Mes, contamos (distinguindo) os numeros de pedido, somamos o total.
-- Agrupamos por ano e mes, ja que é o valor pedido
SELECT DATE_FORMAT(data_emissao,"%Y-%m") as mes, COUNT(DISTINCT p.numero_pedido), SUM(pi.TOTAL)
FROM pedido p
LEFT JOIN pedido_item pi
ON p.numero_pedido = pi.nro_pedido AND pi.cancelado = "N"
GROUP BY mes
ORDER BY mes;

-- Consulta 10: Total recebido por forma de pagamento
SELECT pp.tipo as Tipo, COUNT(DISTINCT pp.nro_pedido) as Pedidos, SUM(pp.recebido) as Total_Recebido
FROM pedido_pagamento pp
GROUP BY pp.tipo
ORDER BY Total_Recebido;
