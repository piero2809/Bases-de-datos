En el cron, añado esta linea:

Terminal:
crontab -e

Añadis esto en la ultima linea

* * * * * /usr/bin/python3 /home/piero/Escritorio/Github/Bases-de-datos/Clases/Tercer Trimestre/Repaso mysqldump/004-escribe.py

Y luego
Control + O = Guardar
Control + X = Salir