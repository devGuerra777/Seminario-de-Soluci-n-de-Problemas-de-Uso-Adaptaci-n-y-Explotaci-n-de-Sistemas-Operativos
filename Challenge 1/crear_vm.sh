#!/bin/bash

# ──────────────────────────────────────────────────────────────
# 🖥️ Script para crear y configurar una VM con VBoxManage
# Autor: Ramiro
# Uso: ./crear_vm.sh <Nombre_VM> <CPUs> <RAM_GB> <VRAM_MB> <Disco_GB> <Nombre_SATA> <Nombre_IDE>
# ──────────────────────────────────────────────────────────────

clear
echo "╔══════════════════════════════════════════════════════╗"
echo "║            🧠 ASISTENTE DE CREACIÓN DE VM            ║"
echo "╚══════════════════════════════════════════════════════╝"
sleep 1

# Validar argumentos
if [ "$#" -ne 7 ]; then
  echo "🚨 Uso incorrecto."
  echo "👉 Uso: $0 <Nombre_VM> <CPUs> <RAM_GB> <VRAM_MB> <Disco_GB> <Nombre_SATA> <Nombre_IDE>"
  exit 1
fi

# Asignación de variables
NOMBRE_VM=$1
CPUS=$2
RAM=$(($3 * 1024))
VRAM=$4
DISCO_GB=$5
DISCO_MB=$(($DISCO_GB * 1024))
SATA_CTRL=$6
IDE_CTRL=$7
VHD="$HOME/VirtualBox VMs/$NOMBRE_VM/$NOMBRE_VM.vdi"

# ───── Creación de la VM ─────
echo "📦 Creando máquina virtual '$NOMBRE_VM'..."
VBoxManage createvm --name "$NOMBRE_VM" --ostype "Linux" --register

# ───── Configuración de recursos ─────
echo "🧩 Asignando recursos..."
VBoxManage modifyvm "$NOMBRE_VM" --cpus $CPUS --memory $RAM --vram $VRAM

# ───── Creación del disco duro ─────
echo "💾 Creando disco duro virtual de $DISCO_GB GB..."
VBoxManage createmedium disk --filename "$VHD" --size $DISCO_MB --format VDI

# ───── Configuración del controlador SATA ─────
echo "🔧 Añadiendo controlador SATA '$SATA_CTRL'..."
VBoxManage storagectl "$NOMBRE_VM" --name "$SATA_CTRL" --add sata --controller IntelAHCI
VBoxManage storageattach "$NOMBRE_VM" --storagectl "$SATA_CTRL" --port 0 --device 0 --type hdd --medium "$VHD"

# ───── Configuración del controlador IDE ─────
echo "📀 Añadiendo controlador IDE '$IDE_CTRL' con unidad vacía..."
VBoxManage storagectl "$NOMBRE_VM" --name "$IDE_CTRL" --add ide
VBoxManage storageattach "$NOMBRE_VM" --storagectl "$IDE_CTRL" --port 0 --device 0 --type dvddrive --medium emptydrive

# ───── Mostrar información final ─────
echo
echo "📊 Configuración final de la VM '$NOMBRE_VM':"
echo "─────────────────────────────────────────────"
VBoxManage showvminfo "$NOMBRE_VM" | grep -E "Name:|Number of CPUs|Memory size|VRAM size|SATA|IDE|File:"
echo "─────────────────────────────────────────────"
echo "✅ ¡VM creada con éxito!"

