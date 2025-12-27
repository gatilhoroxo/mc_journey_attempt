# i2-rp2040-a/

RP2040 - Microcontrolador dual-core ARM com PIO.

---

## 📑 Índice

1. [📂 Estrutura](#-estrutura)
2. [🎯 Objetivo](#-objetivo)
3. [🔧 Setup](#-setup)
4. [📚 Conteúdo por Nível](#-conteúdo-por-nível)
5. [🔗 Próximo Passo](#-próximo-passo)

---

## 📂 Estrutura

```
i2-rp2040-a/
├── README.md              # 👈 Você está aqui
├── j1-exercicios/         # Exercícios progressivos
│   ├── README.md
│   ├── nivel-1-basico/
│   ├── nivel-2-intermediario/
│   └── nivel-3-avancado/
└── j2-projetos/           # Projetos completos
    └── README.md
```

## 🎯 Objetivo

Aprofundar em arquitetura ARM Cortex-M0+ e explorar PIO (Programmable I/O).

**Por que RP2040?**
- Dual-core ARM Cortex-M0+ (133 MHz)
- PIO (state machines programáveis)
- Excelente documentação oficial
- Baixo custo
- SDK completo (C/C++)
- DMA e recursos avançados

**Diferencial:**
PIO permite criar periféricos customizados via hardware!

## 🔧 Setup

### Hardware Necessário
- RP2040-A (placa de desenvolvimento)
- Cabo USB
- Protoboard
- Componentes eletrônicos

### Software
- **SDK:** Raspberry Pi Pico SDK (C/C++)
- **IDE:** VS Code + CMake
- **Debug:** OpenOCD + Picoprobe (ou outro SWD debugger)

### Instalação
```bash
# Linux
sudo apt install cmake gcc-arm-none-eabi libnewlib-arm-none-eabi build-essential
git clone https://github.com/raspberrypi/pico-sdk.git
cd pico-sdk
git submodule update --init
export PICO_SDK_PATH=/path/to/pico-sdk
```

## 📚 Conteúdo por Nível

### Nível 1 - Básico
- GPIO (SDK functions)
- PWM
- UART
- ADC
- Multicore básico

### Nível 2 - Intermediário
- I2C e SPI
- Timers e Interrupts
- DMA
- PIO básico (criar periféricos simples)

### Nível 3 - Avançado
- PIO avançado (protocolos customizados)
- Otimização multicore
- Bare metal (sem SDK)
- Manipulação de registradores

## 🔗 Próximo Passo

Após completar o **Nível 2** aqui, você pode:
- **[../i3-rp2040-zero/](../i3-rp2040-zero/)** - Versão compacta
- **[../i4-stm8/](../i4-stm8/)** - Bare metal 8-bit

Ou consulte:
- **Roadmap geral:** [`../../learn/roadmap_geral.md`](../../learn/roadmap_geral.md)
- **Voltar:** [`../README.md`](../README.md)

---

**Status atual:** Em planejamento

**Pré-requisito:** Completar ESP32 Nível 2
