-- Deletando o banco de dados

USE Mercado;

-- 1 - REMOVENDO APENAS DADOS COM SEGURANÇA
-- Sempre bom rodar um SELECT antes!
-- Ordem ideal: primeiro tabelas filhas, depois a tabela mãe (chaves estrangeiras).

 -- Aqui começa a transição
START TRANSACTION;
DELETE FROM pedido_pagamento WHERE nro_pedido = 16;
DELETE FROM pedido_item      WHERE nro_pedido = 16;
DELETE FROM pedido           WHERE numero_pedido = 16;

-- conferir: deve mostrar 15
SELECT COUNT(*) FROM pedido;

-- desfaz (Caso queira confirmar use o COMMIT no lugar de ROLLBACK)
-- ATENÇÃO: Depois do commit, nao é possivel usar o rollback para desfazer!
ROLLBACK;


-- 2 - REMOVENDO O BANCO INTEIRO:

-- 2.1 BACKUP com --databases (Rodar as duas linhas abaixo juntas no CMD)
--cd "C:\Program Files\MySQL\MySQL Server 8.4\bin"
--mysqldump -u root -p --databases Mercado --single-transaction --routines --triggers --result-file="C:\Users\[USUARIO]\Documents\backup_mercado.sql"

-- 2.2 REMOVENDO DATABASE
DROP DATABASE IF EXISTS Mercado;

-- 2.3 RESTAURANDO (Também no CMD)
--cd "C:\Program Files\MySQL\MySQL Server 8.4\bin"
--mysql -u root -p < "C:\Users\[USUARIO]\Documents\backup_mercado.sql"

-- 4 TESTE DE RESTAURAÇÃO (um backup só vale se restaurar)
-- deve voltar a 16
SELECT COUNT(*) FROM pedido;
