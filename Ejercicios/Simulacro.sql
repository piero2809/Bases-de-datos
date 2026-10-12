/*
Hacer una base de datos del portafolio
Existen dos entidades
- Pieza (Identificador PK, Titulo, Descripción, imagen, url,
 id_categoria fk)

- Categoría (Identificador PK, Titulo, Descripcion)

Debe existir una FK entre Pieza y categoria. Hacer un join entre las dos 
tablas y una vista  (view) de este join



Paso 2 : Hacer una aplicacion en python- consola:
- Mensaje de bienvenida
Que presente opciones CRUD
BUCLE INFINITO
Atrapar las opciones con if - elif
para cada una de las opciones, ejecutar MySQL INSERT, SELECT, UPDATE, 
DELETE

Paso 3: Hacer un front simulado, del portafolio, en html y css
- Crea una estructura HTML basica y legal
En body crea un header, main footer
*/


sudo mysql -u root -p

CREATE DATABASE portafolio;

SHOW DATABASES;

USE portafolio;

CREATE TABLE Categorias(
    identificador INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR (100) NOT NULL,
    descripcion TEXT
);


CREATE TABLE Piezas(
    identificador INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR (150) NOT NULL,
    descripcion TEXT,
    imagen VARCHAR (255),
    url VARCHAR (255),
    id_categoria INT NOT NULL
);



ALTER TABLE Piezas
ADD CONSTRAINT fk_pieza_categoria
FOREIGN KEY (id_categoria) REFERENCES Categorias(identificador)
    ON DELETE CASCADE
    ON UPDATE CASCADE;


INSERT INTO categoria (titulo, descripcion) VALUES
('Diseño Web', 'Proyectos de interfaces web y desarrollo frontend.'),
('Ilustración Digital', 'Arte digital, personajes y conceptos visuales.'),
('Fotografía', 'Sesiones fotográficas, retratos y paisajes urbanos.');

INSERT INTO Pieza (titulo, descripcion, imagen, url, id_categoria) VALUES
('Landing Page EcoStore', 'Diseño y desarrollo de una página de ventas para una tienda ecológica.', 'eco_landing.jpg', 'https://ejemplo.com/ecostore', 1),

('Personaje: Luna la Exploradora', 'Ilustración de una heroína espacial para un libro infantil.', 'luna_exploradora.png', 'https://ejemplo.com/luna', 2),

('Retrato Urbano - Ciudad de Noche', 'Fotografía en blanco y negro tomada en el centro de la ciudad.', 'ciudad_noche.jpg', 'https://ejemplo.com/ciudad-noche', 3);





CREATE VIEW piezas_y_categorias AS 
SELECT 
    Categorias.titulo AS categoriatitulo,
    Categorias.descripcion AS categoriadescripcion,
    Piezas.titulo AS piezatitulo,
    Piezas.descripcion AS piezadescripcion,
    imagen,
    url
FROM Piezas
LEFT JOIN Categorias
    ON Piezas.id_categoria = Categorias.Identificador;





-- crea usuario nuevo con contraseña
-- creamos el nombre de usuario que queramos
CREATE USER 
'portafolioceac'@'localhost' 
IDENTIFIED  BY '1portafolioceac';

-- permite acceso a ese usuario
GRANT USAGE ON *.* TO 'portafolioceac'@'localhost';
--[tuservidor] == localhost
-- La contraseña puede requerir Mayus, minus, numeros, caracteres, min len

-- quitale todos los limites que tenga
ALTER USER 'portafolioceac'@'localhost' 
REQUIRE NONE 
WITH MAX_QUERIES_PER_HOUR 0 
MAX_CONNECTIONS_PER_HOUR 0 
MAX_UPDATES_PER_HOUR 0 
MAX_USER_CONNECTIONS 0;

-- dale acceso a la base de datos empresadam
GRANT ALL PRIVILEGES ON portafolio.* 
TO 'portafolioceac'@'localhost';

-- recarga la tabla de privilegios
FLUSH PRIVILEGES;

