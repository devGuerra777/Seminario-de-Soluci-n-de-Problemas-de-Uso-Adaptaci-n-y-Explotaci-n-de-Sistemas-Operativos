#!/bin/bash

# Colores
verde='\e[32m'
rojo='\e[31m'
azul='\e[34m'
amarillo='\e[33m'
reset='\e[0m'

while true; do
    clear
    echo -e "${azul}"
    echo "╔═════════════════════════════════════════════╗"
    echo "║        🔧 MENÚ DE SERVICIOS EN LINUX        ║"
    echo "╠═════════════════════════════════════════════╣"
    echo -e "║ ${amarillo}1.${azul} Listar contenido de una carpeta         ║"
    echo -e "║ ${amarillo}2.${azul} Crear archivo de texto con línea        ║"
    echo -e "║ ${amarillo}3.${azul} Comparar dos archivos de texto          ║"
    echo -e "║ ${amarillo}4.${azul} Mostrar archivo con awk                 ║"
    echo -e "║ ${amarillo}5.${azul} Buscar texto con grep                   ║"
    echo -e "║ ${amarillo}6.${azul} Salir                                    ║"
    echo "╚═════════════════════════════════════════════╝"
    echo -ne "${reset}"
    read -p "Selecciona una opción [1-6]: " opcion

    case $opcion in
        1)
            read -p "📁 Ruta absoluta del directorio: " ruta
            if [ -d "$ruta" ]; then
                echo -e "${verde}"
                ls -la "$ruta"
                echo -e "${reset}"
            else
                echo -e "${rojo}❌ La ruta no es válida.${reset}"
            fi
            read -p "Presiona Enter para continuar..."
            ;;
        2)
            read -p "📝 Nombre del archivo: " archivo
            read -p "🖊️  Texto a guardar: " linea
            echo "$linea" > "$archivo"
            echo -e "${verde}✅ Archivo '$archivo' creado.${reset}"
            read -p "Presiona Enter para continuar..."
            ;;
        3)
            read -p "📄 Primer archivo: " file1
            read -p "📄 Segundo archivo: " file2
            if [[ -f "$file1" && -f "$file2" ]]; then
                echo -e "${amarillo}"
                diff "$file1" "$file2"
                echo -e "${reset}"
            else
                echo -e "${rojo}❌ Uno o ambos archivos no existen.${reset}"
            fi
            read -p "Presiona Enter para continuar..."
            ;;
        4)
            read -p "📄 Archivo para usar con awk: " awkfile
            if [ -f "$awkfile" ]; then
                echo -e "${verde}📤 Mostrando segunda columna:${reset}"
                awk '{print $2}' "$awkfile"
            else
                echo -e "${rojo}❌ El archivo no existe.${reset}"
            fi
            read -p "Presiona Enter para continuar..."
            ;;
        5)
            read -p "📄 Archivo para buscar con grep: " grepfile
            read -p "🔍 Patrón a buscar: " patron
            if [ -f "$grepfile" ]; then
                echo -e "${verde}📤 Resultados encontrados:${reset}"
                grep "$patron" "$grepfile"
            else
                echo -e "${rojo}❌ El archivo no existe.${reset}"
            fi
            read -p "Presiona Enter para continuar..."
            ;;
        6)
            echo -e "${amarillo}👋 Saliendo del programa...${reset}"
            break
            ;;
        *)
            echo -e "${rojo}❌ Opción no válida.${reset}"
            sleep 1
            ;;
    esac
done
