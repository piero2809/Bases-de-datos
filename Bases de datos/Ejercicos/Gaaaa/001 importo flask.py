import mysql.connector                                  ##Importo el conector a la base de datos
from flask import Flask                                 ##Importo Flask

conexion = mysql.connector.connect(
  host="localhost",
  user="portafolioceac",
  password="1portafolioceac",
  database="portafolio"
  )

                                                        ##Me conecto a la base de datos

cursor = conexion.cursor()                              ##Creo un cursor

cursor.execute ("SELECT * FROM piezas_y_categorias;")   ## Pido el contendio de la vista

filas = cursor.fetchall()                               ##Lo guardo en una lista

for fila in filas :                                     ##Para cada elemento de la lista
    print (fila)                                        ##Lo imprimo en pantalla


app = Flask(__name__)                                   ##Creo una aplicación Flask (web)

@app.route("/")                                         ##Atrapo la ruta raiz (/)
def holamundo():                                        ##Defino una funcion
    return "Hola Mundo"                                 ##Devuelvo algo

if __name__ == "__main__":                              ##Si este es el archivo principal
    app.run(debug=True)                                 ##Ejecuta la web