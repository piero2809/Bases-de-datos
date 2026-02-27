InnoDB - Cell level locking
MyISAM = row level locking

MERGE_MYISAM = Distribuir una base de datos a lo largo de multiples servidres // Cada servidor tiene un cacho de la base de datos.

Memory - Memoria RAM = Mucha velocidad de acceso pero mucho menos espacio (En RAM que en disco duro) // Es volátil 
Archive - Comprimido = Comprime la informacion de la tabla // Ocupa menos espacio en el disco // El acceso a la informacion es lento que con los otros motores 
Blackhole - Agujero negro = Hay ocasiones en las que necesitas tablas intermediarias para operaciones temporales. En ese caso blackhole no deja rastro
CSV -