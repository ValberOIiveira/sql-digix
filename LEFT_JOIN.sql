-- Consulta total

SELECT *
FROM usuario;

SELECT *
FROM cargo;

-- Left Join que retorna todos os usuários e seus cargos

SELECT *
FROM usuario LEFT JOIN cargo 
ON usuario.id = cargo.fk_usuario;