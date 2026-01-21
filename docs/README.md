---
layout: default
title: README
---

# 🌐 docs/

Site estático com documentação web do projeto.

---

## 📑 Índice

1. [📂 Estrutura](#-estrutura)
2. [🎯 Propósito](#-propósito)
3. [🚀 Como Visualizar](#-como-visualizar)
4. [🔗 Fonte do Conteúdo](#-fonte-do-conteúdo)

---

## 📂 Estrutura

```
docs/
├── README.md               # 👈 Você está aqui
├── _config.yml             # Configuração Jekyll/GitHub Pages
├── index.html              # Página principal
├── introducao.html         # Introdução ao projeto
├── referencias.html        # Referências e recursos
├── notas_tecnicas.html     # Notas técnicas
├── assets/                 # CSS, JavaScript, imagens
│   ├── css/
│   │   ├── style.css
│   │   ├── light-theme.css
│   │   └── dark-theme.css
│   └── ts/
│       ├── main.js
│       ├── router.js
│       ├── theme.js
│       └── animations.js
├── projetos-simples/       # Documentação de projetos simples
│   ├── base.html
│   ├── blink_led.html
│   ├── sensor_temperatura.html
│   └── template.html
└── projetos-avancados/     # Documentação de projetos avançados
    ├── base.html
    └── controle_motor_dc.html
```

## 🎯 Propósito

Versão web navegável da documentação do repositório, ideal para:
- Navegação visual mais amigável
- Compartilhamento fácil
- Acesso rápido via navegador
- Apresentação de projetos

## 🚀 Como Visualizar

### Localmente
Abra `index.html` diretamente no navegador:
```bash
# No diretório docs/
open index.html  # macOS
xdg-open index.html  # Linux
start index.html  # Windows
```

### GitHub Pages
Se hospedado no GitHub, acesse:
```
https://<seu-usuario>.github.io/<nome-do-repo>/
```

### Live Server (VS Code)
1. Instale a extensão "Live Server"
2. Clique com botão direito em `index.html`
3. Selecione "Open with Live Server"

## 🔗 Fonte do Conteúdo

O conteúdo aqui é gerado/inspirado em:
- **[../learn/](../learn/)** - Documentação de aprendizado
- **[../mcu/](../mcu/)** - Código e projetos
- **[../README.md](../README.md)** - Visão geral

---

**Status:** Site básico implementado

**Melhorias futuras:**
- Geração automática a partir dos Markdown
- Sistema de busca
- Filtros por MCU/nível
- Dark/Light mode toggle aprimorado
