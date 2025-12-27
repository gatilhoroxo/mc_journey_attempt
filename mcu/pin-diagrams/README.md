# 📍 Pin Diagrams

Diagramas de pinagem e referências para cada microcontrolador.

---

## 📂 Estrutura

Cada MCU possui:
- Diagrama visual ASCII da pinagem
- Link para datasheet oficial
- Tabela de mapeamento de pinos
- Notas sobre pinos especiais

---

## 🎯 Microcontroladores

### [Arduino Uno R3](arduino-uno-r3.md)
- ATmega328P
- 14 pinos digitais (6 PWM)
- 6 entradas analógicas
- [Datasheet](https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-7810-Automotive-Microcontrollers-ATmega328P_Datasheet.pdf)

### [ESP32 DevKit V1](esp32-devkit-v1.md)
- ESP32-WROOM-32
- 30 GPIOs (18 ADC, 16 PWM)
- WiFi + Bluetooth
- [Datasheet](https://www.espressif.com/sites/default/files/documentation/esp32_datasheet_en.pdf)

### [RP2040-A](rp2040-a.md)
- Raspberry Pi RP2040
- 26 GPIOs multifuncionais
- 8 PIO state machines
- [Datasheet](https://datasheets.raspberrypi.com/rp2040/rp2040-datasheet.pdf)

### [RP2040 Zero](rp2040-zero.md)
- Raspberry Pi RP2040 (formato compacto)
- 13 GPIOs expostos
- LED RGB integrado
- [Datasheet](https://datasheets.raspberrypi.com/rp2040/rp2040-datasheet.pdf)

### [STM8S103F3](stm8s103f3.md)
- STMicroelectronics STM8
- 15 pinos I/O
- 5 canais ADC
- [Datasheet](https://www.st.com/resource/en/datasheet/stm8s103f3.pdf)

---

## 🔍 Como Usar

1. **Escolha seu MCU** na lista acima
2. **Consulte o diagrama** para identificar pinos
3. **Verifique limitações** na seção de notas
4. **Leia o datasheet** para detalhes técnicos

---

## 📝 Convenções

```
[PIN] - Número físico do pino
GPIO# - Número GPIO lógico
PWM - Capaz de PWM
ADC - Capaz de leitura analógica
I2C - SDA/SCL
SPI - MOSI/MISO/SCK/CS
UART - TX/RX
* - Pino especial (boot, strapping, etc)
```

---

## ⚠️ Atenção

- Sempre verifique níveis de tensão (3.3V vs 5V)
- Pinos strapping do ESP32 afetam boot
- Alguns pinos têm pull-ups/pull-downs internos
- Consulte limites de corrente no datasheet

---

**Última atualização:** 2025-01-28
