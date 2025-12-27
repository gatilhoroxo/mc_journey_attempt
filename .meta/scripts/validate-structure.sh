#!/bin/bash
# Script para validar estrutura do repositório

# Cores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

REPO_ROOT="../.."
ERRORS=0
WARNINGS=0

echo -e "${BLUE}╔══════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Validação de Estrutura do Repo      ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════╝${NC}\n"

# Função de erro
error() {
    echo -e "${RED}❌ ERRO: $1${NC}"
    ((ERRORS++))
}

# Função de aviso
warning() {
    echo -e "${YELLOW}⚠️  AVISO: $1${NC}"
    ((WARNINGS++))
}

# Função de sucesso
success() {
    echo -e "${GREEN}✅ $1${NC}"
}

echo -e "${BLUE}[1/7] Verificando diretórios principais...${NC}"
# Estrutura principal
REQUIRED_DIRS=(
    "$REPO_ROOT/learn"
    "$REPO_ROOT/mcu"
    "$REPO_ROOT/docs"
    "$REPO_ROOT/projetos-integrados"
    "$REPO_ROOT/.meta"
)

for dir in "${REQUIRED_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        success "$(basename "$dir")/"
    else
        error "Diretório obrigatório não encontrado: $dir"
    fi
done

echo -e "\n${BLUE}[2/7] Verificando estrutura MCU...${NC}"
# Diretórios MCU
MCU_DIRS=(
    "$REPO_ROOT/mcu/i0-arduino"
    "$REPO_ROOT/mcu/i1-esp32"
    "$REPO_ROOT/mcu/i2-rp2040-a"
    "$REPO_ROOT/mcu/i3-rp2040-zero"
    "$REPO_ROOT/mcu/i4-stm8"
)

for mcu_dir in "${MCU_DIRS[@]}"; do
    if [ -d "$mcu_dir" ]; then
        success "$(basename "$mcu_dir")/"
        
        # Verificar subpastas j1-exercicios e j2-projetos
        if [ ! -d "$mcu_dir/j1-exercicios" ]; then
            warning "$mcu_dir deve conter j1-exercicios/"
        fi
        if [ ! -d "$mcu_dir/j2-projetos" ]; then
            warning "$mcu_dir deve conter j2-projetos/"
        fi
        
        # Verificar README.md
        if [ ! -f "$mcu_dir/README.md" ]; then
            error "$mcu_dir deve conter README.md"
        fi
    else
        error "Diretório MCU não encontrado: $mcu_dir"
    fi
done

echo -e "\n${BLUE}[3/7] Verificando convenção de nomenclatura...${NC}"
# Verificar que diretórios seguem padrão iN- e jN-
INVALID_NAMES=$(find "$REPO_ROOT/learn" "$REPO_ROOT/mcu" -maxdepth 2 -type d \
    ! -name "i[0-9]*" \
    ! -name "j[0-9]*" \
    ! -name "k[0-9]*" \
    ! -name "nivel-*" \
    ! -name "learn" \
    ! -name "mcu" \
    ! -name ".git*" \
    ! -path "*/.*" \
    2>/dev/null | grep -v "^\.$" | head -n 5)

if [ -n "$INVALID_NAMES" ]; then
    warning "Alguns diretórios não seguem convenção iN-/jN-:"
    echo "$INVALID_NAMES" | while read -r line; do
        echo "  - $(basename "$line")"
    done
else
    success "Convenção de nomenclatura OK"
fi

echo -e "\n${BLUE}[4/7] Verificando READMEs obrigatórios...${NC}"
# READMEs obrigatórios
REQUIRED_READMES=(
    "$REPO_ROOT/README.md"
    "$REPO_ROOT/learn/README.md"
    "$REPO_ROOT/mcu/README.md"
    "$REPO_ROOT/docs/README.md"
    "$REPO_ROOT/projetos-integrados/README.md"
)

for readme in "${REQUIRED_READMES[@]}"; do
    if [ -f "$readme" ]; then
        # Verificar se tem conteúdo
        if [ -s "$readme" ]; then
            success "$(echo "$readme" | sed "s|$REPO_ROOT/||")"
        else
            warning "README vazio: $(echo "$readme" | sed "s|$REPO_ROOT/||")"
        fi
    else
        error "README obrigatório não encontrado: $(echo "$readme" | sed "s|$REPO_ROOT/||")"
    fi
done

echo -e "\n${BLUE}[5/7] Verificando templates...${NC}"
TEMPLATE_DIR="$REPO_ROOT/learn/i5-templates"
REQUIRED_TEMPLATES=(
    "template-exercicio.md"
    "template-projeto.md"
    "template-diario.md"
    "template-conceito.md"
    "template-componente.md"
)

if [ -d "$TEMPLATE_DIR" ]; then
    for template in "${REQUIRED_TEMPLATES[@]}"; do
        if [ -f "$TEMPLATE_DIR/$template" ]; then
            success "$template"
        else
            warning "Template não encontrado: $template"
        fi
    done
else
    error "Diretório de templates não encontrado: $TEMPLATE_DIR"
fi

echo -e "\n${BLUE}[6/7] Verificando scripts...${NC}"
SCRIPTS_DIR="$REPO_ROOT/.meta/scripts"
REQUIRED_SCRIPTS=(
    "create-exercise.sh"
    "update-tracker.sh"
    "generate-index.sh"
    "validate-structure.sh"
)

if [ -d "$SCRIPTS_DIR" ]; then
    for script in "${REQUIRED_SCRIPTS[@]}"; do
        if [ -f "$SCRIPTS_DIR/$script" ]; then
            # Verificar se é executável
            if [ -x "$SCRIPTS_DIR/$script" ]; then
                success "$script (executável)"
            else
                warning "$script existe mas não é executável (rode: chmod +x)"
            fi
        else
            warning "Script não encontrado: $script"
        fi
    done
else
    error "Diretório de scripts não encontrado: $SCRIPTS_DIR"
fi

echo -e "\n${BLUE}[7/7] Verificando arquivos especiais...${NC}"
# .gitignore
if [ -f "$REPO_ROOT/.gitignore" ]; then
    success ".gitignore existe"
    
    # Verificar entradas importantes
    if grep -q "\.vscode" "$REPO_ROOT/.gitignore" 2>/dev/null; then
        success "  - Ignora .vscode/"
    else
        warning "  - .gitignore não ignora .vscode/"
    fi
    
    if grep -q "build" "$REPO_ROOT/.gitignore" 2>/dev/null; then
        success "  - Ignora build/"
    else
        warning "  - .gitignore não ignora build/"
    fi
else
    warning ".gitignore não encontrado"
fi

# TRACKER.md
if [ -f "$REPO_ROOT/learn/i3-diario-aprendizado/TRACKER.md" ]; then
    success "TRACKER.md existe"
else
    warning "TRACKER.md não encontrado"
fi

# Resumo final
echo -e "\n${BLUE}╔══════════════════════════════════════╗${NC}"
echo -e "${BLUE}║           RESUMO FINAL               ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════╝${NC}\n"

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}🎉 Estrutura perfeita! Nenhum erro ou aviso.${NC}"
    exit 0
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}✅ Sem erros, mas há $WARNINGS aviso(s).${NC}"
    exit 0
else
    echo -e "${RED}❌ Encontrados $ERRORS erro(s) e $WARNINGS aviso(s).${NC}"
    echo -e "${YELLOW}Por favor, corrija os erros antes de continuar.${NC}"
    exit 1
fi
