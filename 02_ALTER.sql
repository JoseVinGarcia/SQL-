# Fazendo modificações no banco

# Alterando o nome de Produtos para Produto
ALTER TABLE produtos
RENAME TO produto;

# Criando a coluna MARCA com um valor padrão na tabela Produtos
ALTER TABLE produtos
ADD MARCA VARCHAR(50) DEFAULT 'n/a';

# Modificando tipo de dado em Marca
ALTER TABLE produtos
MODIFY Marca VARCHAR(200);

# Removendo a coluna Marca
ALTER TABLE produtos
DROP COLUMN Marca;

# Na tabela CLIENTE, a coluna telefone está como decimal, vamos alterar para VARCHAR
ALTER TABLE cliente
MODIFY telefone VARCHAR(15);
