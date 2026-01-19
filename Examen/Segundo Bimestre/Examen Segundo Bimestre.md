
Nuestro proyecto grupal es en base a la idea de una tienda de cosas retro, llamada Retroplay, para poder generar el catalogo de productos y reservarlos utilizamos una base de datos relacional siendo su función almacenar los datos de los productos y usarios. Se utilizo un modelo de datos relacional para poder conectar entre si las tablas que fuesen necesarias. Las entidades necesarias para la BD es usuarios, productos, reservas y lineas de reservas. Reservas tiene una clave foranea de usuarios y lineas de reservas tiene una clave foranea de reservas y productos, es decir que una reserva puede tener varias lineas de reservas y una linea de reservas pertenece a una reserva.


En primer lugar, creamos un diagrama de entidad relacion con la web Dia-Jocarsa, luego al intentar aplicar la base de datos en mysql a través de la consola, daba error puesto que la pagina exporta los comandos sql de creacion de tablas en desorden y al tener claves foráneas daba errores. Entonces, tuvimos que corregir la estructura de la base de datos y poner en orden que comando de creacion de tablas debería ir primero. Luego de ordenar la base de datos:

### Pasos a seguir.

1. Crear la base de datos Retroplay si no existe
```sql
CREATE DATABASE IF NOT EXISTS retroplay;
```
2. Crear Tabla usuarios
```sql
CREATE TABLE IF NOT EXISTS usuarios (
  id INT NOT NULL AUTO_INCREMENT,
  nickname VARCHAR(255),
  correo VARCHAR(255),
  telefono VARCHAR(255),
  contrasena VARCHAR(255),
  PRIMARY KEY (id)
);
```
Creamos la Tabla usuarios con un `id` autoincrementable para que MYSQL lo genere automaticamente. Luego usamos `nickname`, `correo`, `telefono` y `contrasena` guardar la informacion de registro e inicio de sesión. Cada entidad esta puesta como VARCHAR (255) para que pueda almacenar hasta 255 caracteres sin embargo esto es solo por ahora y no pensamos mantenerlo asi en proximas actualizaciones.

3. Crear tabla producto
```sql
CREATE TABLE IF NOT EXISTS producto (
  id INT NOT NULL AUTO_INCREMENT,
  categoria VARCHAR(255),
  titulo VARCHAR(255),
  descripcion VARCHAR(255),
  precio VARCHAR(255),
  imagen VARCHAR(255), 
  PRIMARY KEY (id)
);
```
Creamos la tabla producto con un `id` autoincrementable para que MYSQL lo genere automaticamente. Luego usamos `categoria`, `titulo`, `descripcion`, `precio` y `imagen` guardar la informacion de los productos tanto consolas como videojuegos. Cada entidad esta puesta como VARCHAR (255) para que pueda almacenar hasta 255 caracteres y creamos la primary key en id para que esta evite duplicados o valores nulos

4. Crear tabla reservas con una FK
```sql
CREATE TABLE IF NOT EXISTS reservas (
  id INT NOT NULL AUTO_INCREMENT,
  fecha VARCHAR(255),
  usuario_id INT,
  PRIMARY KEY (id),
  CONSTRAINT fk_reservas_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);
```

Creamos la tabla reservas con un `id` autoincrementable para que MYSQL lo genere automaticamente. Luego usamos `fecha` y `usuario_id` guardar la informacion de las reservas. Cada entidad esta puesta como VARCHAR (255) para que pueda almacenar hasta 255 caracteres. Esta tabla vincula usuarios con reservas a traves de un FK `usuario_id`

5. Crear tabla linea reservas con dos FK
```sql
CREATE TABLE IF NOT EXISTS lineareservas (
  id INT NOT NULL AUTO_INCREMENT,
  reservas_id INT,
  producto_id INT,
  PRIMARY KEY (id),
  CONSTRAINT fk_lineareservas_reserva FOREIGN KEY (reservas_id) REFERENCES reservas(id),
  CONSTRAINT fk_lineareservas_producto FOREIGN KEY (producto_id) REFERENCES producto(id)
);
```
Esta tabla funciona como intermediaria entre reservas y producto

6. Crear usuario con permisos
```sql
CREATE USER 
'retroplay'@'localhost' 
IDENTIFIED  BY 'Retroplay123$';

GRANT USAGE ON *.* TO 'retroplay'@'localhost';

ALTER USER 'retroplay'@'localhost' 
REQUIRE NONE 
WITH MAX_QUERIES_PER_HOUR 0 
MAX_CONNECTIONS_PER_HOUR 0 
MAX_UPDATES_PER_HOUR 0 
MAX_USER_CONNECTIONS 0;

-- dale acceso a la base de datos retroplay
GRANT ALL PRIVILEGES ON retroplay.* 
TO 'retroplay'@'localhost';

-- recarga la tabla de privilegios
FLUSH PRIVILEGES;
```
Aqui creamos un usuario con permisos para la base de datos que posteriormente usaremos para la conexión de php con mysql.

7. Se crea una muestra con IA para hacer un insert en la base de datos
```sql
-- INSERTS CONSOLAS
INSERT INTO producto (categoria, titulo, descripcion, precio, imagen) VALUES 
('Consola', 'Game Boy Classic', 'La consola portátil original de 1989, color gris.', '15€', 'gb_classic.jpg'),
('Consola', 'Game Boy Color', 'Versión a color en carcasa transparente púrpura.', '15€', 'gb_color.jpg'),
('Consola', 'Game Boy Advance', 'Diseño horizontal ergonómico, color índigo.', '15€', 'gba_indigo.jpg'),
('Consola', 'Game Boy Advance SP', 'Modelo plegable con luz frontal, color plata.', '15€', 'gba_sp.jpg'),
('Consola', 'Nintendo DS', 'Primera generación con doble pantalla, color gris.', '15€', 'nds_fat.jpg'),
('Consola', 'Nintendo DS Lite', 'Versión más ligera y brillante, color blanco.', '15€', 'nds_lite.jpg'),
('Consola', 'Nintendo NES', 'La clásica consola de 8 bits con dos mandos.', '15€', 'nes_console.jpg'),
('Consola', 'Super Nintendo', 'El cerebro de la bestia, 16 bits de potencia.', '15€', 'snes_console.jpg'),
('Consola', 'Nintendo 64', 'Consola de 64 bits color negro carbón.', '15€', 'n64_black.jpg'),
('Consola', 'GameCube', 'Consola compacta con asa, color morado.', '15€', 'gamecube.jpg'),
('Consola', 'Sega Mega Drive', 'La competidora de 16 bits con Sonic.', '15€', 'megadrive.jpg'),
('Consola', 'Sega Dreamcast', 'La última consola de Sega, pionera online.', '15€', 'dreamcast.jpg'),
('Consola', 'PlayStation 1', 'La gris original que cambió la industria.', '15€', 'ps1_fat.jpg'),
('Consola', 'PSOne', 'Versión slim rediseñada de la PlayStation.', '15€', 'psone.jpg'),
('Consola', 'PlayStation 2', 'La consola más vendida de la historia.', '15€', 'ps2_fat.jpg'),
('Consola', 'Atari 2600', 'Clásica con acabado de madera y joystick.', '15€', 'atari2600.jpg'),
('Consola', 'Nintendo Wii', 'Revolución por movimiento, color blanco.', '15€', 'wii_white.jpg'),
('Consola', 'Sega Game Gear', 'La portátil a color de Sega.', '15€', 'gamegear.jpg'),
('Consola', 'Neo Geo Pocket', 'Portátil de culto de SNK.', '15€', 'neogeo_pocket.jpg'),
('Consola', 'PSP 1000', 'PlayStation Portable, modelo original.', '15€', 'psp_1000.jpg');
-- INSERTS VIDEOJUEGOS
INSERT INTO producto (categoria, titulo, descripcion, precio, imagen) VALUES 
('Videojuego', 'Super Mario Bros', 'El clásico de plataformas para NES.', '5€', 'mario_nes.jpg'),
('Videojuego', 'Tetris', 'El juego de puzles definitivo para Game Boy.', '5€', 'tetris_gb.jpg'),
('Videojuego', 'Pokémon Rojo', 'Atrapa a todos los monstruos de bolsillo.', '5€', 'pokemon_rojo.jpg'),
('Videojuego', 'Pokémon Azul', 'Edición compañera de la versión Roja.', '5€', 'pokemon_azul.jpg'),
('Videojuego', 'Legend of Zelda: Link Awakening', 'Aventura clásica en la isla Koholint.', '5€', 'zelda_gb.jpg'),
('Videojuego', 'Super Mario World', 'El debut de Mario y Yoshi en 16 bits.', '5€', 'mario_world.jpg'),
('Videojuego', 'Sonic the Hedgehog', 'Velocidad pura para Mega Drive.', '5€', 'sonic_1.jpg'),
('Videojuego', 'Street Fighter II', 'El rey de los juegos de lucha.', '5€', 'sf2.jpg'),
('Videojuego', 'Donkey Kong Country', 'Gráficos renderizados revolucionarios.', '5€', 'dk_country.jpg'),
('Videojuego', 'Super Mario 64', 'Mario da el salto al 3D.', '5€', 'mario64.jpg'),
('Videojuego', 'Ocarina of Time', 'Obra maestra de aventura en N64.', '5€', 'zelda_oot.jpg'),
('Videojuego', 'GoldenEye 007', 'El shooter que definió el multijugador.', '5€', 'goldeneye.jpg'),
('Videojuego', 'Mario Kart 64', 'Carreras alocadas con amigos.', '5€', 'mariokart64.jpg'),
('Videojuego', 'Final Fantasy VII', 'RPG legendario de PlayStation.', '5€', 'ff7.jpg'),
('Videojuego', 'Crash Bandicoot', 'Plataformas desafiantes con el marsupial.', '5€', 'crash1.jpg'),
('Videojuego', 'Spyro the Dragon', 'Aventura de plataformas 3D.', '5€', 'spyro.jpg'),
('Videojuego', 'Pokémon Esmeralda', 'La edición definitiva de la 3ra generación.', '5€', 'pokemon_emerald.jpg'),
('Videojuego', 'New Super Mario Bros', 'Regreso a las raíces en la DS.', '5€', 'new_mario_ds.jpg'),
('Videojuego', 'Nintendogs', 'Simulador de mascotas virtual.', '5€', 'nintendogs.jpg'),
('Videojuego', 'Mario Kart DS', 'Carreras portátiles con modo online.', '5€', 'mariokart_ds.jpg');
```


En conclusión, este script implementa una base de datos relacional completa para un catálogo de productos retro, con soporte para usuarios y reservas.
Su estructura refleja principios fundamentales de diseño de bases de datos: normalización y separación de responsabilidades.
Además, incluye configuración de seguridad básica mediante un usuario dedicado, lo que es esencial en entornos reales.
Este tipo de esquema es un punto de partida sólido para aplicaciones web o sistemas de gestión que requieran persistencia de datos estructurada y segura.


