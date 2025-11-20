/*
Preguntas específicas del examen
Vamos a crear una base de datos llamada portafolioexamen Crea dos tablas, 
piezasportafolio (Identificador,titulo,descripcion,fecha,id_categoria), 
y categoriasportafolio(Identificador, nombre) Crea claves primarias, y 
clave foranea para enlazar autores con piezas 
Inserta registros en ambas tablas Demuestra que 
puedes insertar, leer, actualizar y eliminar registros
 Crea una seleccion cruzada con LEFT JOIN y una vista de esa misma peticion 
 Crea un usuario con permisos para acceder a esa base de datos
*/



CREATE DATABASE portafolioexamen;          --Se crea BD


USE portafolioexamen


--Se crea base de datos con claves primarias'

CREATE TABLE piezasportafolio (
    identificador INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR (255) NOT NULL,
    descripcion TEXT,
    fecha VARCHAR (255),
    id_categoria INT NOT NULL
);

CREATE TABLE categoriasportafolio(
    identificador INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR (255)
);

--Se crea la clave foránea'
ALTER TABLE piezasportafolio
ADD CONSTRAINT fk_piezasportafolio_categoriasportafolio
FOREIGN KEY (id_categoria) REFERENCES categoriasportafolio(identificador)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

--Se hacen los inserts'
INSERT INTO categoriasportafolio VALUES (
    NULL,
    'DAM'
);

INSERT INTO categoriasportafolio VALUES (
    NULL,
    'DAW'
);


INSERT INTO piezasportafolio VALUES (
    NULL,
    'Landing page para tienda online',
    'Diseño y maquetacion con HTML',
    '15-03-2025',
    1
    );

INSERT INTO piezasportafolio VALUES (
    NULL,
    'Aplicación de Gestión de Tareas',
    'App full-stack con React y Node.js para organizar tareas diarias.',
    '2025-07-22', 
    2
);

-- Se muestra la tabla
SELECT * FROM piezasportafolio

-- Se hace el update
UPDATE piezasportafolio SET
    titulo = 'aplicacion de gestion de gastos',
    descripcion = 'App full-stack con JavaScript para organizar gastos',
    fecha ='2025-03-15'
    WHERE identificador = 1;

-- Se hace el delete
DELETE FROM piezasportafolio WHERE identificador = 1;



--Creamos la vista
CREATE VIEW piezas_y_categorias_examen AS 
SELECT 
    nombre,
    titulo,
    descripcion,
    fecha
FROM piezasportafolio
LEFT JOIN categoriasportafolio
    ON piezasportafolio.id_categoria = categoriasportafolio.identificador;

--'Creamos el usuario
CREATE USER 
'portafolioexamen'@'localhost' 
IDENTIFIED  BY '1portafolioexamen'; --Se crea la contraseña

-- Permite acceso a ese usuario
GRANT USAGE ON *.* TO 'portafolioexamen'@'localhost';

--Se quitan los limites
ALTER USER 'portafolioexamen'@'localhost' 
REQUIRE NONE 
WITH MAX_QUERIES_PER_HOUR 0 
MAX_CONNECTIONS_PER_HOUR 0 
MAX_UPDATES_PER_HOUR 0 
MAX_USER_CONNECTIONS 0;

--Se le da acceso a la base de datos portafolioexamen
GRANT ALL PRIVILEGES ON portafolioexamen.* 
TO 'portafolioexamen'@'localhost';

--Recarga la tabla de privilegios
FLUSH PRIVILEGES;



