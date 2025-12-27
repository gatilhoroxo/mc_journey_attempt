# 🤖 Scripts de Automação

Scripts para facilitar tarefas repetitivas no repositório.

---

## 📜 Scripts Disponíveis

### 1. `create-exercise.sh`
**Propósito:** Criar novo exercício a partir do template

**Uso:**
```bash
cd .meta/scripts
./create-exercise.sh
```

**O que faz:**
- Solicita informações (MCU, nível, número, nome)
- Cria pasta do exercício
- Copia template de README.md
- Cria arquivos de código (`.ino` ou `.c`)

**Exemplo:**
```
MCU: i0-arduino
Nível: nivel-1-basico
Número: k4
Nome: pwm_led
→ Cria: mcu/i0-arduino/j1-exercicios/nivel-1-basico/k4-pwm_led/
```

---

### 2. `update-tracker.sh`
**Propósito:** Atualizar contador de progresso

**Uso:**
```bash
cd .meta/scripts
./update-tracker.sh
```

**O que faz:**
- Conta exercícios concluídos por MCU
- Exibe estatísticas
- Lembra de atualizar TRACKER.md manualmente

**Output:**
```
📊 Contando exercícios concluídos...
Arduino: 3 exercícios
ESP32: 0 exercícios
...
```

---

### 3. `generate-index.sh`
**Propósito:** Gerar índice básico de README.md

**Uso:**
```bash
cd .meta/scripts
./generate-index.sh
```

**O que faz:**
- Solicita caminho do diretório
- Gera README.md com estrutura de arquivos
- Adiciona timestamp de geração

**Nota:** ⚠️ Sobrescreve README.md existente! Use com cuidado.

---

## 🚀 Execução

### Linux/macOS
```bash
cd .meta/scripts
./nome-do-script.sh
```

### Windows (Git Bash)
```bash
cd .meta/scripts
bash nome-do-script.sh
```

---

## 📝 Personalizações

### Adicionar novo script
1. Criar arquivo `.sh` nesta pasta
2. Adicionar shebang: `#!/bin/bash`
3. Tornar executável: `chmod +x script.sh`
4. Documentar neste README

### Template de script
```bash
#!/bin/bash
# Descrição do script

# Cores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}=== Título do Script ===${NC}\n"

# Seu código aqui

echo -e "${GREEN}✅ Concluído!${NC}"
```

---

## 🔗 Links Relacionados

- **Templates:** [`../../learn/i5-templates/`](../../learn/i5-templates/)
- **Tracker:** [`../../learn/i3-diario-aprendizado/TRACKER.md`](../../learn/i3-diario-aprendizado/TRACKER.md)
- **Voltar:** [`../README.md`](../README.md)

---

**Última atualização:** 2025-12-26
