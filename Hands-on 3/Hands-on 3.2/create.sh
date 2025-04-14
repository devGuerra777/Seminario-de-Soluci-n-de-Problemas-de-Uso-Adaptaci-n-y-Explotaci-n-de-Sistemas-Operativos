#!/bin/bash

# Crear el archivo y agregar "Hola Mundo"
echo "Hola Mundo" > mytext

# Mostrar el contenido del archivo
echo
echo "Contenido del archivo mytext:"
cat mytext

# Crear el directorio backup
echo
echo "Creando el directorio 'backup'..."
mkdir backup

# Mover el archivo mytext al directorio backup
echo
echo "Moviendo 'mytext' al directorio 'backup'..."
mv mytext backup/

# Listar el contenido del directorio backup
echo
echo "Contenido del directorio 'backup':"
ls backup

# Eliminar el archivo mytext dentro de backup
echo
echo "Eliminando el archivo 'mytext' dentro de 'backup'..."
rm backup/mytext

# Eliminar el directorio backup
echo
echo "Eliminando el directorio 'backup'..."
rmdir backup

echo
echo "Proceso completado."
