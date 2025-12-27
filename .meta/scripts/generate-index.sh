#!/bin/bash
# Script para gerar índices automaticamente (estrutura básica)

# Cores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}=== Gerar Índices de Diretórios ===${NC}\n"

# Validação de entrada
if [ $# -eq 0 ]; then
    echo -e "${YELLOW}ℹ️  Uso: $0 <diretório>${NC}"
    echo -e "${YELLOW}ℹ️  Exemplo: $0 ../../mcu/i0-arduino/j1-exercicios${NC}"
    exit 0
fi

TARGET_DIR=$1

# Validar que o diretório existe
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${RED}❌ Erro: Diretório '$TARGET_DIR' não existe${NC}"
    exit 1
fi

# Validar permissões de escrita
if [ ! -w "$TARGET_DIR" ]; then
    echo -e "${RED}❌ Erro: Sem permissão de escrita em '$TARGET_DIR'${NC}"
    exit 1
fi


generate_index() {
    local dir=$1
    local output="${dir}/README.md"
    
    echo -e "${BLUE}📝 Gerando índice para: ${dir}${NC}"
    
    # Validar que há conteúdo no diretório
    if [ -z "$(ls -A "$dir" 2>/dev/null)" ]; then
        echo -e "${YELLOW}⚠️  Diretório vazio: ${dir}${NC}"
        return 1
    fi
    
    # Header básico
    cat > "$output" << EOF
# $(basename "$dir")/

Índice gerado automaticamente.

---

## 📂 Estrutura

EOF
    
    # Listar arquivos e pastas
    echo '```' >> "$output"
    tree -L 2 -I 'README.md' "$dir" >> "$output" 2>/dev/null || ls -la "$dir" | grep -v README.md >> "$output"
    echo '```' >> "$output"
    
    # Footer
    cat >> "$output" << EOF

---

**Gerado automaticamente em:** $(date +"%Y-%m-%d %H:%M:%S")

EOF
    
    echo -e "${GREEN}✅ Índice gerado${NC}"
}

# Perguntar qual diretório indexar
read -p "Caminho do diretório para gerar índice (ex: ../../mcu/i0-arduino): " DIR_PATH

if [ -d "$DIR_PATH" ]; then
    generate_index "$DIR_PATH"
else
    echo -e "${YELLOW}⚠️  Diretório não encontrado!${NC}"
fi

echo -e "\n${YELLOW}⚠️  Nota: Este é um índice básico. Customize conforme necessário!${NC}"
