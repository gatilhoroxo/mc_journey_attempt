#!/bin/bash
# Script para atualizar o tracker de progresso

# Cores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

TRACKER_FILE="../../learn/i3-diario-aprendizado/TRACKER.md"

echo -e "${BLUE}=== Atualizar Tracker de Progresso ===${NC}\n"

# Validar que o tracker existe
if [ ! -f "$TRACKER_FILE" ]; then
    echo -e "${RED}❌ Erro: Arquivo TRACKER.md não encontrado em $TRACKER_FILE${NC}"
    exit 1
fi

# Validar estrutura de diretórios MCU
REQUIRED_DIRS=(
    "../../mcu/i0-arduino"
    "../../mcu/i1-esp32"
    "../../mcu/i2-rp2040-a"
    "../../mcu/i3-rp2040-zero"
    "../../mcu/i4-stm8"
)

for dir in "${REQUIRED_DIRS[@]}"; do
    if [ ! -d "$dir" ]; then
        echo -e "${YELLOW}⚠️  Aviso: Diretório $dir não encontrado${NC}"
    fi
done

# Contar exercícios concluídos por MCU
count_completed() {
    local mcu_path=$1
    local count=0
    
    # Buscar por [x] em README.md de exercícios
    if [ -d "$mcu_path" ]; then
        count=$(find "$mcu_path" -name "README.md" -exec grep -l "Status.*🟢 Concluído" {} \; 2>/dev/null | wc -l)
    fi
    
    echo $count
}

echo -e "${BLUE}📊 Contando exercícios concluídos...${NC}\n"

# Arduino
arduino_done=$(count_completed "../../mcu/i0-arduino/j1-exercicios")
echo -e "Arduino: ${GREEN}${arduino_done}${NC} exercícios"

# ESP32
esp32_done=$(count_completed "../../mcu/i1-esp32/j1-exercicios")
echo -e "ESP32: ${GREEN}${esp32_done}${NC} exercícios"

# RP2040-A
rp2040a_done=$(count_completed "../../mcu/i2-rp2040-a/j1-exercicios")
echo -e "RP2040-A: ${GREEN}${rp2040a_done}${NC} exercícios"

# RP2040 Zero
rp2040z_done=$(count_completed "../../mcu/i3-rp2040-zero/j1-exercicios")
echo -e "RP2040 Zero: ${GREEN}${rp2040z_done}${NC} exercícios"

# STM8
stm8_done=$(count_completed "../../mcu/i4-stm8/j1-exercicios")
echo -e "STM8: ${GREEN}${stm8_done}${NC} exercícios"

echo -e "\n${YELLOW}📝 Lembre-se de atualizar manualmente:${NC}"
echo -e "  - Marcar [x] nos exercícios concluídos no TRACKER.md"
echo -e "  - Atualizar barras de progresso"
echo -e "  - Atualizar 'Última atualização' com a data atual"
echo -e "\n${BLUE}📍 Arquivo: ${TRACKER_FILE}${NC}"
