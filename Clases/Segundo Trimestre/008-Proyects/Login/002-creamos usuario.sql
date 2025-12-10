CREATE USER 
'superaplicacion'@'localhost' 
IDENTIFIED  BY 'Superaplicacion123$';


GRANT USAGE ON *.* TO 'superaplicacion'@'localhost';

ALTER USER 'superaplicacion'@'localhost' 
REQUIRE NONE 
WITH MAX_QUERIES_PER_HOUR 0 
MAX_CONNECTIONS_PER_HOUR 0 
MAX_UPDATES_PER_HOUR 0 
MAX_USER_CONNECTIONS 0;

-- dale acceso a la base de datos empresadam
GRANT ALL PRIVILEGES ON superaplicacion.* 
TO 'superaplicacion'@'localhost';

-- recarga la tabla de privilegios
FLUSH PRIVILEGES;
