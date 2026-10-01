-- O role em PostGree representa um usuário ou um grupo de permissões.
-- Assim, o usuário nada mais é do que uma função com permissão de login

--Para criar role: CREATE ROLE nome_do_role
-- Criação de roles usadas como "perfis de permissão".
CREATE ROLE readonly;    -- Será usada para conceder acesso somente leitura
CREATE ROLE admin_role;  -- Perfil de administrador
CREATE ROLE sales_user;  -- Perfil específico para área de vendas

--Para criar usuários deve-se atribuir a permissão de login ao role e a senha
-- Cria uma role (usuário) simples com permissão de login e senha definida.
CREATE ROLE john LOGIN PASSWORD '12345';

-- Cria outra role (usuário) com configurações adicionais como validade e limite de conexões.
CREATE ROLE leo
WITH
  LOGIN                -- Pode se autenticar no banco
  PASSWORD 'secure_password' -- Senha definida
  VALID UNTIL '2025-12-31'   -- Data de expiração da conta
  CONNECTION LIMIT 5;        -- Limite máximo de sessões simultâneas


--O GRANT no PostgreSQL (e em outros bancos de dados SQL) é o comando utilizado para conceder permissões a um usuário ou role
--Também pode ser usado para atribuir um role a um usuário, algo como atribuir perfís de usuários
--SINTAXE: GRANT permissao ON nivel TO role_name

-- Concede permissão de leitura (SELECT) na tabela "produto" para a role readonly.
GRANT SELECT ON TABLE produto TO readonly;

-- Associa o perfil readonly ao usuário john.
GRANT readonly TO john;

-- Concede permissões específicas diretamente ao usuário john na tabela cliente.
GRANT SELECT, INSERT, UPDATE ON TABLE cliente TO john;

-- Concede permissão para acessar (USAGE) e criar objetos (CREATE) dentro do schema public.
-- OBS: USAGE não lê nem lista dados; apenas permite utilizar o schema.
GRANT USAGE, CREATE ON SCHEMA public TO sales_user;

-- Concede acesso total (SELECT, INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER) em todas as tabelas existentes no schema publico
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin_role;

-- Concede acesso total às SEQUENCES (necessário para manipular colunas com SERIAL/IDENTITY).
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin_role;

-- Concede permissões no nível do banco (CONNECT, CREATE, TEMP).
GRANT ALL PRIVILEGES ON DATABASE notas TO admin_role;

--O comando ALTER ROLE serve para modificar as propriedades de uma role (usuário ou grupo) no PostgreSQL.
--ALTER ROLE nome_da_role [ WITH ] opção1 opção2 ... ;

-- Alterar a senha de uma role existente.
ALTER ROLE leo WITH PASSWORD 'nova_senha';

-- Eleva o usuário 'leo' ao nível de SUPERUSER.
-- Um SUPERUSER no PostgreSQL ignora todas as regras de permissões (GRANT/REVOKE),
-- passando a ter acesso irrestrito a todos os bancos, schemas, tabelas e configurações do servidor.
-- Equivale ao usuário "root" no Linux: pode criar/excluir qualquer objeto, gerenciar roles, 
-- executar funções privilegiadas e até comprometer a segurança do sistema se mal utilizado.
ALTER ROLE leo WITH SUPERUSER;

-- Alterar validade da role.
ALTER ROLE leo VALID UNTIL '2026-12-31';

-- Ajustar limite de conexões permitidas.
ALTER ROLE leo CONNECTION LIMIT 10;

--Comando REVOKE é usado para retirar permissões que foram concedidas anteriormente com GRANT
--Sintaxe básica REVOKE <PRIVILÉGIOS> ON <OBJETO> FROM <ROLE>;

-- Revogar inserção e atualização na tabela cliente de john.
REVOKE INSERT, UPDATE ON TABLE cliente FROM john;

-- Revogar todas as permissões da tabela produto da role readonly.
REVOKE ALL PRIVILEGES ON TABLE produto FROM readonly;

-- Revogar permissão de uso e criação no schema public.
REVOKE USAGE, CREATE ON SCHEMA public FROM admin_role;

-- Revogar permissões no banco de dados.
REVOKE ALL PRIVILEGES ON DATABASE notas FROM admin_role;

-- Revogar permissões no schema public de sales_user.
REVOKE ALL PRIVILEGES ON SCHEMA public FROM sales_user;

--O comando DROP ROLE é usado para excluir uma role (usuário ou grupo) do PostgreSQL.
--Você só pode remover uma role se:
--Ela não tiver privilégios ativos
--Ela não estiver atribuída a outra role
DROP ROLE sales_user;

-- Lista todas as roles existentes no sistema.
SELECT * FROM pg_roles;
