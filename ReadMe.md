El archivo flex alexico.l es el archivo flex que generará el conjunto de tokens adaptado al lenguaje de programacion conocido por Python:
Contiene lo necesario para generar:
Numeros enteros
Funciones def-return
if
if-else
while
switch-case

Asimismo, será requisito distintivo y necesario del lenguaje Python la deteccion de la indentacion en Python como genrador de los bloques de código

Para mayor claridad, se ha decidido realizar una estrategia de depuración en cada print para que en caso de error, se sepa la secuncia de impresion por pantalla cmd y en que token se ha detenido.

-----------------------------------------------------------------------------------------------------------------------------------

El archivo asintactico.y es el archvo bison que generará el árbol sintáctico del lenguaje Python, para ello pasaremos como imput el conjunto de tokens desde el archivo flex (arriba comentado)
La estructura del programa principal se distribuirá de la siguiente manera descendente desde raiz a hojas del programa donde el programa principal será su raíz y las hojas las declaraciones finales.

Un program tiene un conjunto de estados - statements.

Los conjuntos de estados statements pueden ser vacíos o pueden tener una composición de uno o varios estados mas. Donde un estado individual y atomico sera un statement

Cada estado atomico o statement puede ser una expression, un if, un if-else, un while, un switch con sus cases, un print, un read como lectura, una funcion def, un return de valor de funcion.

Ademas cada print tiene una serie de print _arguments que puede ser vacio, un solo print entre parentesis o varios print
Donde cada print puede ser una expresion precedida de coma para el paso de parametros por referencia o una cadena de string entrecomillada.


Por su parte, los bloques cases pueden tener uno más bloques case más.

Finalmente como elemento terminal atómico tenemos la expresión, una expresion será la base de la programación:
Número
Identificador
Cadena de string
Identificador con declaracion de igualdad
Operaciones aritmeticas
Operaciones logicas
Operaciones entre parentesis

POr último, tendremos una funcion main que nos pedirá por imput un archivo en formato .txt y nos generará un archivo automático en Python de nombre output.txt:

Es importante recalcar que se ha usado la funcion malloc para asignar memoria disponible y free para liberarla.

---------------------------------------------------------------------------------------------------

Pruebas:
He generado dos archivos de pruebas, el primero de pruebas muy simples llamado prueba1.txt y el otro un poco más complejo llamado prueba2.txt.

prueba1.txt: contiene operaciones aritmeticas y print
prueba2.txt: incorporo además if-else y while a la estructura

-----------------------------------------------------------------------------------------------------

ejecucion:
los comandos para llevar a cabo la compilación y ejecución en la consola cmd será:
flex alexico.l
bison -d asintactico.y
gcc asintactico.tab.c lex.yy.c -o programa
programa "nombre del archivo de entrada.txt"
con esto obtendremos un resultante archivo output.txt


------------------------------------------------------------------------------------------------------

Resultado de proyecto:

el programa se compila con errores de sintaxis en determinados bloques al ejecutar los comandos correspondientes

Ej:
C:\Users\migue\OneDrive\Escritorio\Compilador>alexico.l

C:\Users\migue\OneDrive\Escritorio\Compilador>flex alexico.l

C:\Users\migue\OneDrive\Escritorio\Compilador>bison -d asintactico.y
asintactico.y: conflictos: 37 desplazamiento/reducción, 2 reducción/reducción

C:\Users\migue\OneDrive\Escritorio\Compilador>gcc asintactico.tab.c lex.yy.c -o programa

C:\Users\migue\OneDrive\Escritorio\Compilador>programa.exe prueba1.txt
TOKEN: IDENTIFIER (a)
TOKEN: OP_ASIG
TOKEN: NUMBER (10)
TOKEN: IDENTIFIER (b)
TOKEN: OP_ASIG
TOKEN: NUMBER (20)
TOKEN: IDENTIFIER (c)
TOKEN: OP_ASIG
TOKEN: IDENTIFIER (a)
TOKEN: OP_SUM
TOKEN: IDENTIFIER (b)
TOKEN: PRINT
TOKEN: PARENTESIS_I
TOKEN: CTE_STRING ("La suma de")
Error: syntax error

C:\Users\migue\OneDrive\Escritorio\Compilador>programa.exe prueba2.txt 
TOKEN: IDENTIFIER (a)
TOKEN: OP_ASIG
TOKEN: NUMBER (1)
TOKEN: IDENTIFIER (b)
TOKEN: OP_ASIG
TOKEN: NUMBER (3)
TOKEN: PRINT
TOKEN: PARENTESIS_I
TOKEN: CTE_STRING ("Comienzo del programa")
Error: syntax error

-----------------------------------------------------------------------------------------

Conclusiones:

El compilador da errores de sintaxis, tratamos de verlo junto al profesor pero no me ha sido posible identificar el origen de la posible ambiguedad de la gramática.
