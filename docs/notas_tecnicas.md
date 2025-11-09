<div class="navbar">
  <a href="index.html">Início</a> |
  <a href="introducao.html">Introdução</a> |
  <a href="notas_tecnicas.html">Notas Técnicas</a> |
  <a href="referencias.html">Referências Úteis</a>
</div>

# Notas Técnicas — Arduino e Microcontroladores

## 🧠 Visão Geral
Esta seção contém anotações e explicações técnicas sobre o funcionamento interno do **Arduino Uno** e de seu microcontrolador principal, o **ATmega328P**.  
O objetivo é entender o que ocorre “por trás” das funções simples da IDE Arduino — aprofundando o conhecimento em nível de hardware e registradores.

---

## ⚙️ Estrutura do Arduino Uno

| Componente | Descrição |
|-------------|------------|
| **Microcontrolador** | ATmega328P — responsável pela execução do código. |
| **Clock** | Cristal oscilador de 16 MHz. |
| **Memória Flash** | 32 KB (para código do programa). |
| **SRAM** | 2 KB (para variáveis temporárias). |
| **EEPROM** | 1 KB (para dados permanentes). |
| **Tensão de Operação** | 5V |
| **Pinos Digitais** | 14 (6 podem ser usados como PWM). |
| **Entradas Analógicas** | 6 (A0 a A5). |

---

## ⚡ Funcionamento dos Pinos Digitais

Cada pino digital do ATmega328P pode ser configurado como **entrada** ou **saída**, controlando diretamente os registradores internos:

| Função Arduino | Registrador AVR | Descrição |
|----------------|----------------|------------|
| `pinMode(pin, OUTPUT)` | `DDRx` | Define se o pino é entrada (0) ou saída (1). |
| `digitalWrite(pin, HIGH)` | `PORTx` | Define o nível lógico (1 = HIGH / 0 = LOW). |
| `digitalRead(pin)` | `PINx` | Lê o estado atual do pino. |

Exemplo: o pino 13 está no **PORTB**, bit 5 (`PORTB5`).  
Assim, quando fazemos `digitalWrite(13, HIGH)`, internamente ocorre:
```c
PORTB |= (1 << PB5);
```

---

## 🔢 Mapeamento de Pinos (Arduino Uno)

| Pino Arduino | Pino no ATmega328P | Registrador |
|---------------|-------------------|--------------|
| 0–7 | PD0–PD7 | PORTD |
| 8–13 | PB0–PB5 | PORTB |
| A0–A5 | PC0–PC5 | PORTC |

---

## ⏱️ Temporização e Função delay()

A função `delay(ms)` usa o **Timer0**, que é um contador interno de 8 bits incrementado pelo clock de 16 MHz dividido por um *prescaler*.  
A biblioteca Arduino converte isso em milissegundos de forma automática, mas em nível de registrador é possível gerar interrupções precisas com os **Timers 0, 1 e 2**.

- **Timer0:** usado por `millis()` e `delay()`  
- **Timer1:** usado para funções de PWM e servo motor (16 bits)  
- **Timer2:** usado para temporizações adicionais (8 bits)

---

## 🔍 Conversor Analógico-Digital (ADC)

O ATmega328P possui um **ADC de 10 bits**, permitindo converter sinais analógicos (0–5V) em valores de 0 a 1023.

Exemplo:  
```c
int valor = analogRead(A0);
float tensao = valor * (5.0 / 1023.0);
```
O ADC é controlado pelos registradores:
- `ADMUX`: seleciona o canal de entrada e a referência de tensão.
- `ADCSRA`: controla a ativação e o início da conversão.
- `ADCL` e `ADCH`: armazenam o resultado da leitura.

---

## 🔄 Comunicação Serial (UART)

A porta serial (pinos 0 e 1) usa o módulo **USART** interno do ATmega328P.  
Ela converte dados binários em sinais elétricos para comunicação com o PC ou outros dispositivos.

Parâmetros configuráveis:
- **Baud rate:** velocidade de transmissão (ex: 9600 bps)  
- **8 bits de dados, 1 stop bit, sem paridade** (padrão Arduino)

Funções principais:
```c
Serial.begin(9600);   // Inicia comunicação
Serial.print("Olá");  // Envia texto
Serial.read();        // Lê dados recebidos
```

Registradores principais: `UBRR0H/L`, `UCSR0A/B/C`, `UDR0`.

---

## 🔌 Barramentos de Comunicação

### I²C (Two-Wire Interface)
Usa os pinos **A4 (SDA)** e **A5 (SCL)**.  
Permite conectar múltiplos dispositivos com apenas dois fios.  
Biblioteca: `Wire.h`

### SPI (Serial Peripheral Interface)
Usa os pinos **10 (SS)**, **11 (MOSI)**, **12 (MISO)** e **13 (SCK)**.  
É um protocolo rápido, usado em displays, memórias e sensores.  
Biblioteca: `SPI.h`

---

## 💾 Memória — Organização e Limites

| Tipo | Tamanho | Função |
|------|----------|--------|
| **Flash** | 32 KB | Armazena o programa (Sketch). |
| **SRAM** | 2 KB | Variáveis temporárias durante execução. |
| **EEPROM** | 1 KB | Dados permanentes (não voláteis). |

⚠️ Dica: Evite usar muitas variáveis globais e `String` dinâmicas — podem esgotar rapidamente a SRAM.

---

## 🧮 PWM — Modulação por Largura de Pulso

A técnica de **PWM (Pulse Width Modulation)** permite simular tensões analógicas usando pulsos digitais rápidos.  
Função: `analogWrite(pino, valor)` — onde `valor` varia de **0 a 255**.

O sinal é gerado pelos **Timers internos**, com frequências típicas de 490 Hz ou 980 Hz, dependendo do pino.

Exemplo: controlar brilho de LED ou velocidade de motor DC.

---

## 🔋 Alimentação e Regulação de Tensão

O Arduino Uno pode ser alimentado por:
- **Porta USB (5V)**  
- **Entrada Vin (7–12V)** — regulada internamente para 5V  
- **Pino 5V** — fornece até ~500mA (dependendo da fonte)

Internamente, o **regulador AMS1117-5.0** converte tensões mais altas em 5V estáveis para o microcontrolador.

---

## 🔧 Bootloader e Gravação de Código

O **bootloader** é um pequeno programa gravado na Flash do ATmega328P que permite carregar novos códigos via USB, sem necessidade de programador externo.  
Ele é ativado logo após o reset e espera comandos da IDE Arduino por alguns segundos.

Caso o bootloader seja apagado, pode-se regravar usando outro Arduino como **ISP (In-System Programmer)**.

---

## 📘 Resumo Técnico do ATmega328P

| Parâmetro | Valor |
|------------|--------|
| Arquitetura | AVR 8 bits RISC |
| Clock Máx. | 20 MHz |
| Flash | 32 KB |
| SRAM | 2 KB |
| EEPROM | 1 KB |
| Tensão de Operação | 1.8V – 5.5V |
| GPIO | 23 pinos |
| Timers | 3 (2×8 bits, 1×16 bits) |
| ADC | 10 bits, 6 canais |
| PWM | 6 canais |
| UART | 1 |
| I²C | 1 |
| SPI | 1 |

---

> _Notas técnicas organizadas por Pirado — explorando o Arduino além do básico, até os registradores e o coração do microcontrolador._
