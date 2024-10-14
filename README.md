# MVP de Gerenciamento de Pedidos em Delphi

Este é um MVP de gerenciamento de pedidos desenvolvido em Delphi, utilizando os padrões MVC (Model-View-Controller) e boas práticas de Clean Code. O sistema permite a criação, consulta, atualização e exclusão de pedidos de venda e seus itens associados.

## Funcionalidades

- **Gerenciamento de Clientes**: Consulta e seleção de clientes.
- **Gerenciamento de Produtos**: Consulta e seleção de produtos.
- **Cadastro de Pedidos**: Criação e armazenamento de pedidos com múltiplos itens.
- **Consulta de Pedidos**: Visualização dos detalhes de pedidos existentes.
- **Cancelamento de Pedidos**: Remoção de pedidos do sistema.

## Estrutura do Projeto

- /models -> Classes que representam os dados (TPedido, TItemPedido) 
- /repositories -> Classes que interagem com o banco de dados (PedidoRepository, ItemPedidoRepository) 
- /controllers -> Classes que implementam a lógica de negócio (PedidoController, ItemPedidoController) 
- /views -> Formulários e interfaces do usuário (UnPrincipal, uConsulta) 
- /utils -> Classes utilitárias (uDatabaseManager, UresourceUtils, UIniUtils)
- /Database -> DataModule (uDmWkPedidoVenda)
- /Dump -> Dump do banco de dados



## Requisitos

- Delphi (versão utilizada: Delphi 12)
- FireDAC para comunicação com o banco de dados MySQL
- MySQL Server
