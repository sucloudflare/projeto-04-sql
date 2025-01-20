# Projeto de Modelagem de Banco de Dados para Oficina

Este projeto visa a criação de um banco de dados para o contexto de uma oficina, com a implementação de um esquema lógico completo. O banco de dados foi projetado para gerenciar informações de clientes, funcionários, serviços, ordens de serviço, pagamentos e relacionamentos entre essas entidades.

## Objetivo

O objetivo deste projeto é demonstrar como modelar um banco de dados relacional para uma oficina, com a definição das tabelas, relacionamentos e a realização de consultas SQL avançadas para análise de dados. O projeto envolve a criação de um banco de dados funcional com a persistência de dados para testes e realização de consultas.

## Estrutura do Banco de Dados

As seguintes tabelas foram criadas para modelar as operações de uma oficina:

1. **Cliente**: Contém informações sobre os clientes da oficina, tanto pessoa física quanto jurídica.
2. **Funcionario**: Contém informações sobre os funcionários da oficina.
3. **Servico**: Contém os serviços oferecidos pela oficina, como reparos e manutenções.
4. **OrdemServico**: Contém as ordens de serviço geradas pelos clientes para a realização de serviços na oficina.
5. **Servico_Ordem**: Relacionamento entre os serviços e as ordens de serviço, com a quantidade de cada serviço realizado.
6. **Pagamento**: Contém informações sobre os pagamentos realizados pelos clientes pelas ordens de serviço.

## Consultas SQL

Algumas das consultas SQL implementadas no projeto são:

1. **Recuperar todas as ordens de serviço com informações do cliente e status.**
2. **Recuperar a quantidade total de serviços realizados em uma ordem.**
3. **Filtrar ordens de serviço por status 'Em Andamento'.**
4. **Consultar o total de pagamentos realizados por ordem de serviço.**
5. **Ordenar os serviços por preço.**
6. **Recuperar todos os serviços realizados em uma ordem específica.**
7. **Verificar a soma total de todos os pagamentos realizados na oficina.**

## Como Executar

1. Clone este repositório.
2. Execute o script `oficina_project.sql` em um banco de dados MySQL ou PostgreSQL.
3. Realize as consultas SQL para testar as funcionalidades.

## Licença

Este projeto está licenciado sob a Licença MIT - consulte o arquivo [LICENSE](LICENSE) para mais detalhes.
