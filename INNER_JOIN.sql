SELECT *
FROM usuario
RIGHT JOIN cargo ON
usuario.id = cargo.fk_usuario;

SELECT * 
FROM cargo
INNER JOIN cargo ON
usuario.id = cargo.fk_usuario;
