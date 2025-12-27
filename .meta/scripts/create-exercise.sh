#!/bin/bash
# Script para criar novo exercício a partir do template

# Cores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Criar Novo Exercício ===${NC}\n"

# Função de validação
validate_mcu() {
    case "$1" in
        i0-arduino|i1-esp32|i2-rp2040-a|i3-rp2040-zero|i4-stm8) return 0 ;;
        *) return 1 ;;
    esac
}

validate_nivel() {
    case "$1" in
        nivel-1-basico|nivel-2-intermediario|nivel-3-avancado) return 0 ;;
        *) return 1 ;;
    esac
}

validate_num() {
    if [[ "$1" =~ ^k[0-9]+$ ]]; then
        return 0
    else
        return 1
    fi
}

validate_nome() {
    if [[ "$1" =~ ^[a-z0-9_-]+$ ]]; then
        return 0
    else
        return 1
    fi
}

# Solicitar e validar MCU
while true; do
    read -p "MCU (i0-arduino/i1-esp32/i2-rp2040-a/i3-rp2040-zero/i4-stm8): " MCU
    if validate_mcu "$MCU"; then
        break
    else
        echo -e "${RED}❌ MCU inválido. Use um dos valores listados.${NC}"
    fi
done

# Solicitar e validar Nível
while true; do
    read -p "Nível (nivel-1-basico/nivel-2-intermediario/nivel-3-avancado): " NIVEL
    if validate_nivel "$NIVEL"; then
        break
    else
        echo -e "${RED}❌ Nível inválido. Use um dos valores listados.${NC}"
    fi
done

# Solicitar e validar Número
while true; do
    read -p "Número do exercício (ex: k4): " NUM
    if validate_num "$NUM"; then
        break
    else
        echo -e "${RED}❌ Número inválido. Use formato kN (ex: k1, k2, k10).${NC}"
    fi
done

# Solicitar e validar Nome
while true; do
    read -p "Nome do exercício (ex: pwm_led): " NOME
    if validate_nome "$NOME"; then
        break
    else
        echo -e "${RED}❌ Nome inválido. Use apenas letras minúsculas, números, underscore e hífen.${NC}"
    fi
done

# Criar caminho completo
EXERCISE_PATH="../../mcu/$MCU/j1-exercicios/$NIVEL/${NUM}-${NOME}"

# Verificar se já existe
if [ -d "$EXERCISE_PATH" ]; then
    echo -e "${YELLOW}⚠️  Exercício já existe!${NC}"
    exit 1
fi

# Criar diretório
echo -e "${BLUE}📁 Criando diretório...${NC}"
mkdir -p "$EXERCISE_PATH"

# Copiar template
echo -e "${BLUE}📝 Copiando template...${NC}"
cp "../../learn/i5-templates/template-exercicio.md" "$EXERCISE_PATH/README.md"

# Criar arquivo de código básico
echo -e "${BLUE}💻 Criando arquivo de código...${NC}"
if [[ "$MCU" == "i0-arduino" ]]; then
    touch "$EXERCISE_PATH/basic.ino"
    touch "$EXERCISE_PATH/better.ino"
elif [[ "$MCU" == "i4-stm8" ]]; then
    touch "$EXERCISE_PATH/basic.c"
    touch "$EXERCISE_PATH/better.c"
else
    touch "$EXERCISE_PATH/basic.c"
    touch "$EXERCISE_PATH/better.c"
fi

echo -e "${GREEN}✅ Exercício criado com sucesso!${NC}"
echo -e "${BLUE}📍 Local: ${EXERCISE_PATH}${NC}"
echo -e "${YELLOW}📝 Não esqueça de editar o README.md!${NC}"
echo -e "${YELLOW}📊 Atualize o TRACKER.md em learn/i3-diario-aprendizado/${NC}"
