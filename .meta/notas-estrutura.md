
# Notas sobre Estrutura do Repositório

## 🎯 Princípios de Organização

> gosto de organizar algumas coisas com índices do tipo i0, i1 em diante com coisas dentro nomeadas de j0, j1 em diante, e as coisas dentro com k0, k1 em diante (mas esses param nessas letras, caso for usar algo parecido tem que ser com [m,n,o] ou [p,q,r] ou [w,u,v], apenas)

> sinto que ainda falta algo como index em tudo nesse repositório para localizar o que tem dentro dele e de cada sub-diretório, e também nos readme que as vezes acho muito longo e tento separar em arquivos diferentes mas ainda parece desorganizado

## ✅ Reorganização Realizada (2025-12-25)

### 1. Sistema de Navegação com INDEX.md

Criados arquivos `INDEX.md` em todas as pastas principais:
- ✅ Raiz: `INDEX.md` (navegação principal)
- ✅ `learn/INDEX.md`
- ✅ `mcu/INDEX.md`
- ✅ `docs/INDEX.md`
- ✅ `projetos-integrados/INDEX.md`
- ✅ `.meta/INDEX.md`
- ✅ Cada subpasta de `learn/` (i1, i2, i3, i4, i5)
- ✅ Cada MCU em `mcu/` (i0-arduino, i1-esp32, etc)
- ✅ Pastas de exercícios e níveis

### 2. Convenções de Nomenclatura

**Implementado:**
- `iN-nome/` - Pastas principais (índice nível 1)
- `jN-nome.md` - Arquivos dentro de `iN/`
- `kN-nome/` - Subpastas de exercícios
- `mN-nome/` - Usado apenas em `.meta/`

**Formato de datas:**
- ISO 8601: `YYYY-MM-DD`
- Exemplo: `j1-2025-12-25.md`

### 3. Estrutura de Pastas

```
mc_journey_attempt/
├── INDEX.md                      ← Navegação principal
├── README.md                     ← Apresentação do projeto
├── REFERENCIAS.md                ← Referências gerais extraídas
├── README-OLD.md                 ← Backup do README antigo
│
├── learn/                        ← Renomeado de docs-learn/
│   ├── INDEX.md
│   ├── roadmap_geral.md
│   ├── i1-conceitos-fundamentais/
│   ├── i2-ferramentas/
│   ├── i3-diario-aprendizado/
│   ├── i4-referencias/
│   └── i5-templates/             ← Movido de ps.md
│
├── mcu/                          ← Mantém estrutura i0, i1, i2, i3, i4
│   └── [cada MCU com INDEX.md]
│
├── docs/                         ← Site estático (sem mudanças)
├── projetos-integrados/          ← Com INDEX.md
│
└── .meta/                        ← Nova pasta
    ├── INDEX.md
    ├── notas-estrutura.md        ← Este arquivo
    └── prompts/               ← Histórico de prompts
```

### 4. Arquivos INDEX.md

Cada `INDEX.md` contém:
- 📂 **Estrutura:** Lista de pastas/arquivos
- 🎯 **Propósito:** O que contém
- 📖 **Como usar:** Guia rápido
- 🔗 **Links:** Para próximos passos

### 5. Separação de Conteúdo

**README.md:**
- Apresentação do projeto
- Links rápidos
- Progresso
- Informações essenciais

**INDEX.md:**
- Navegação detalhada
- Estrutura completa
- Convenções
- Mapa do repositório

**REFERENCIAS.md:**
- Livros, cursos, comunidades
- Documentação oficial
- Sites e recursos

## 🔄 Próximas Melhorias

- [ ] Criar scripts de automação para gerar INDEX.md
- [ ] Adicionar badges de progresso
- [ ] Criar diagrama visual da estrutura
- [ ] Documentar padrão de commit messages

## 📝 Observações

- Prefixos i/j/k mantidos conforme preferência pessoal
- INDEX.md em cada pasta para fácil navegação
- README.md mais conciso e focado
- Conteúdo antigo preservado em README-OLD.md
 

