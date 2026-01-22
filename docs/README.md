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
├── index.md                # Página principal (Markdown)
├── introducao.md           # Introdução ao projeto (Markdown)
├── referencias.md          # Referências e recursos (Markdown)
│
├── _layouts/               # Layouts Jekyll
│   ├── default.html       # Layout padrão
│   └── projeto.html       # Layout para páginas de projetos
│
├── _includes/              # Componentes reutilizáveis
│   ├── header.html        # Cabeçalho do site
│   ├── footer.html        # Rodapé do site
│   └── nav.html           # Navegação principal
│
├── _sass/                  # Módulos SCSS (após conversão)
│   ├── _variables.scss    # Variáveis de tema (cores, fontes)
│   ├── _base.scss         # Estilos base (body, typography)
│   └── _components.scss   # Componentes (tables, badges, animations)
│
└── assets/                 # Arquivos estáticos
    └── css/
        └── style.scss     # Arquivo principal SCSS (importa módulos)
```

## 🎯 Propósito

Versão web navegável da documentação do repositório usando **Jekyll** e **GitHub Pages**, ideal para:
- Navegação visual mais amigável
- Compartilhamento fácil via URL
- Acesso rápido via navegador
- Apresentação de projetos com formatação consistente
- Documentação técnica com syntax highlighting

## 🚀 Como Visualizar

### GitHub Pages (Produção)
Se hospedado no GitHub, acesse:
```
https://<seu-usuario>.github.io/<nome-do-repo>/
```

### Desenvolvimento Local (Recomendado)

#### Pré-requisitos
- Ruby >= 2.5.0
- Bundler
- Jekyll

#### Instalação (Ubuntu 24)
```bash
# Instalar Ruby e dependências
sudo apt update
sudo apt install ruby-full build-essential zlib1g-dev

# Configurar gems no diretório do usuário
echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Instalar Bundler e Jekyll
gem install bundler jekyll
```

#### Executar localmente
```bash
# No diretório docs/
cd docs/

# Instalar dependências (primeira vez)
bundle install

# Iniciar servidor de desenvolvimento
bundle exec jekyll serve

# Acessar em http://localhost:4000
```

#### Opções úteis
```bash
# Rodar em porta diferente
bundle exec jekyll serve --port 4001

# Reconstruir automaticamente ao editar
bundle exec jekyll serve --livereload

# Modo detalhado (debug)
bundle exec jekyll serve --verbose
```

## 🔗 Fonte do Conteúdo

O conteúdo aqui é gerado/inspirado em:
- **[../learn/](../learn/)** - Documentação de aprendizado
- **[../mcu/](../mcu/)** - Código e projetos
- **[../README.md](../README.md)** - Visão geral

---

**Status:** Site Jekyll configurado e funcional

**Tecnologias:**
- Jekyll (gerador de sites estáticos)
- GitHub Pages (hospedagem)
- Kramdown (processador Markdown)
- SCSS modular (estilos)
- Liquid (templating)

**Funcionalidades:**
- ✅ Sistema de temas (Dark/Light mode)
- ✅ Syntax highlighting para código
- ✅ Navegação responsiva
- ✅ Layouts reutilizáveis
- ✅ Markdown com GitHub Flavored Markdown

**Melhorias futuras:**

- Geração automática de índice de projetos
- Sistema de busca integrado
- Filtros por MCU/nível de dificuldade
- Breadcrumbs para navegação
- Integração com coleção `_projetos`
