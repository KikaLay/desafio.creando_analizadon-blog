--  Crear base de datos llamada películas.
CREATE DATABASE blog_db;

\ c blog_db;

--Crear las tablas indicadas de acuerdo al modelo de datos.

CREATE TABLE usuarios(
    id SERIAL NOT NULL PRIMARY KEY,
    email VARCHAR (255) NOT NULL
);
CREATE TABLE posts (
    id INT NOT NULL PRIMARY KEY,
    usuario_fk INT NOT NULL,
    titulo VARCHAR (255),
    fecha DATE NOT NULL,
    FOREIGN KEY (usuario_fk) REFERENCES usuarios(id)
);
CREATE TABLE comentarios (
    id SERIAL PRIMARY KEY,
    post_fk INT NOT NULL,
    usuario_fk INT NOT NULL,
    texto VARCHAR (255) NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (post_fk) REFERENCES posts(id),
    FOREIGN KEY (usuario_fk) REFERENCES usuarios(id)
);

-- Cargar info archivos a su tabla correspondiente.
\copy usuarios FROM 'C:\Users\Alumno\Desktop\usuarios.csv' csv header;

\copy posts FROM 'C:\Users\Alumno\Desktop\posts.csv' csv header;

\copy comentarios FROM 'C:\Users\Alumno\Desktop\comentarios.csv' csv header;

select * from comentarios;
-- Seleccionar el correo, id y título de todos los post publicados por el usuario 5.
select email,usuarios.id, titulo
from usuarios  
inner join posts on usuarios.id = posts.usuario_fk 
where usuarios.id = 5;

-- Listar el correo, id y el detalle de todos los comentarios que no hayan sido realizados por el usuario con email usuario06@hotmail.com.
select email, usuarios.id, texto 
from comentarios
left join  usuarios on comentarios.usuario_fk = usuarios.id
where usuarios.email != 'usuario06@hotmail.com';

-- Listar los usuarios que no han publicado ningún post.
select * from usuarios
full outer join posts on usuarios.id = posts.usuario_fk 
where usuarios.id is null or posts.usuario_fk is null;


-- Listar todos los post con sus comentarios (incluyendo aquellos que no poseen comentarios).
select titulo, texto 
from posts 
full outer join comentarios on posts.id = comentarios.post_fk;


-- Listar todos los usuarios que hayan publicado un post en Junio.
select * from usuarios  
left join posts on posts.usuario_fk  = usuarios.id
where posts.fecha between '2020-06-01' and '2020-06-30';