# SQL!

Um estudo simples de SQL, feito e testado no **MySQL Workbench 8.0.40 Community**, com versão de servidor de **8.4.3**.

### Por quê?

Uma prova de que um banco pode ser criado com comandos simples e consultas eficientes. Vou mapear e documentar meus passos a medida que for atualizando o banco.

### Caso de Uso

Para esse banco, fiz uma simulação simples: Um mercado quer um banco de dados para cadastrar seus produtos do zero.
O banco inicialmente terá 6 tabelas: Cliente, Grupo, Pedido, Pedido_Item, Pedido_Pagamento e Produtos.

| Tabela           | Descrição                                      |
|------------------|------------------------------------------------|
| Cliente          | Informações a respeito dos Clientes            |
| Grupo            | As categorias de item dentro do mercado        |
| Pedido           | O registro inicial dos pedidos                 |
| Pedido_Item      | O registro dos itens de cada pedido            |
| Pedido_Pagamento | O registro do tipo de pagamento de cada pedido |
| Produtos         | Os produtos cadastrados                        |

Você vai notar que os pedidos são registrados em 3 tabelas diferentes, isso é feito para evitar redundância.

### Como Rodar
Rode os seguintes arquivos .sql em ordem:
1. 01_CREATE.sql
2. 02_ALTER.sql
3. 03_QUERY.sql
4. 04_DELETE_and_BACKUP.sql

### Afazeres

- [X] Comandos de criação
- [X] Comandos de alteração
- [X] Comandos de Consulta
- [X] Comandos de Backup
- [X] Comandos de remoção
