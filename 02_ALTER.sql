# Fazendo modificações no banco

# Criando a coluna MARCA com um valor padrão na tabela Produtos
ALTER TABLE produtos
ADD MARCA VARCHAR(50) DEFAULT "n/a";

# Modificando tipo de dado em Marca
ALTER TABLE produtos
MODIFY Marca VARCHAR(200);

# Removendo a coluna Marca
ALTER TABLE produtos
DROP COLUMN Marca;

