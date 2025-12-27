# i0-arduino/

Arduino - Introdução com framework conhecido.

---

## 📑 Índice

1. [📂 Estrutura](#-estrutura)
2. [🎯 Objetivo](#-objetivo)
3. [📌 Por Que Começar com Arduino?](#-por-que-começar-com-arduino)
4. [🔧 Setup e Configuração](#-setup-e-configuração)
5. [📚 Conteúdo por Nível](#-conteúdo-por-nível)
6. [📖 Referências Específicas Arduino](#-referências-específicas-arduino)
7. [💡 Dicas Específicas Arduino](#-dicas-específicas-arduino)
8. [🔗 Próximo Passo](#-próximo-passo)

---

## 📂 Estrutura

```
i0-arduino/
├── README.md              # 👈 Você está aqui
├── j1-exercicios/         # Exercícios progressivos
│   ├── README.md
│   ├── nivel-1-basico/
│   │   ├── info-basico.md
│   │   ├── k1-blink_led/
│   │   ├── k2-botao-led/
│   │   └── k3-sensor_temperatura/
│   ├── nivel-2-intermediario/
│   │   └── info-intermediario.md
│   └── nivel-3-avancado/
│       └── info-avancado.md
└── j2-projetos/           # Projetos completos
    └── README.md
```

## 🎯 Objetivo

Relembrar conceitos básicos de microcontroladores usando o framework Arduino antes de mergulhar em programação bare metal.

**Por que Arduino?**
- Framework familiar e bem documentado
- Abstração útil para entender conceitos
- Grande comunidade de suporte
- Rápido para prototipar e testar ideias
- Curva de aprendizado suave
- Excelente porta de entrada para embedded

---

## 📌 Por Que Começar com Arduino?

Pense no Arduino como o **Zoro** dos microcontroladores: direto ao ponto, confiável e perfeito para começar a jornada. Assim como o Zoro dominou as espadas básicas antes de desenvolver técnicas avançadas, você vai dominar os fundamentos aqui antes de partir para frameworks mais complexos!

### Vantagens do Arduino
- ✅ Sintaxe C++ simplificada e intuitiva
- ✅ Setup rápido (plug and play)
- ✅ Biblioteca enorme de exemplos
- ✅ Comunidade gigantesca (milhões de usuários)
- ✅ Documentação em português abundante
- ✅ Hardware barato e acessível
- ✅ IDE amigável para iniciantes

### Desvantagens (Para Aprender)
- ⚠️ Abstrai muito o hardware real
- ⚠️ Não ensina manipulação de registradores
- ⚠️ Código pode ficar "preguiçoso" (ineficiente)
- ⚠️ Dificulta entendimento de bare-metal depois

**Solução:** Use Arduino para aprender conceitos, depois migre para ESP-IDF/bare-metal para dominar o hardware!

---

## 🔧 Setup e Configuração

### Hardware Necessário
- Arduino UNO R3 (ATmega328P)
- Cabo USB tipo A para B
- Protoboard
- LEDs, resistores, botões
- Sensores básicos (LM35, DHT11, potenciômetro)
- Jumpers macho-macho

### Instalação do Ambiente

#### Opção 1: Arduino IDE (Recomendado para Iniciantes)
```bash
# Linux
sudo apt install arduino

# Mac
brew install --cask arduino

# Windows
# Baixe de: https://www.arduino.cc/en/software
```

**Configuração Inicial:**
1. Abra Arduino IDE
2. Ferramentas → Placa → Arduino AVR Boards → Arduino Uno
3. Ferramentas → Porta → Selecione porta COM/ttyUSB/ttyACM
4. Arquivo → Exemplos → 01.Basics → Blink
5. Clique em "Upload" (→)

#### Opção 2: PlatformIO (Recomendado para Desenvolvedores)
```bash
# Instale via VS Code Extension
# Extension ID: platformio.platformio-ide

# Criar projeto novo
pio init --board uno

# Compilar
pio run

# Upload
pio run --target upload

# Monitor serial
pio device monitor
```

**platformio.ini:**
```ini
[env:uno]
platform = atmelavr
board = uno
framework = arduino
monitor_speed = 9600
```

### Seu Primeiro "Blink"

```cpp
// Arquivo: blink.ino

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);  // LED_BUILTIN = pino 13
}

void loop() {
  digitalWrite(LED_BUILTIN, HIGH);  // Liga LED
  delay(1000);                      // Aguarda 1 segundo
  digitalWrite(LED_BUILTIN, LOW);   // Desliga LED
  delay(1000);                      // Aguarda 1 segundo
}
```

**Upload:**
```bash
# Arduino IDE: Sketch → Upload (Ctrl+U)

# PlatformIO CLI:
pio run --target upload
```

---

## 📚 Conteúdo por Nível

### Nível 1 - Básico
- GPIO digital (digitalWrite, digitalRead)
- PWM (analogWrite)
- ADC (analogRead)
- Serial (comunicação UART)

**Conceitos Fundamentais:**
- Estrutura setup() e loop()
- Pull-up/pull-down resistors
- Duty cycle em PWM
- Conversão ADC (0-1023 para 0-5V)

### Nível 2 - Intermediário
- Interrupts (attachInterrupt)
- I2C/Wire (displays OLED, sensores)
- SPI (cartão SD, displays TFT)
- Timers (millis, micros)
- EEPROM
- Bibliotecas externas

**Projetos Típicos:**
- Display LCD 16x2 com I2C
- Sensor ultrassônico HC-SR04
- Servo motor controle
- Comunicação serial avançada

### Nível 3 - Avançado
- Manipulação direta de registradores (PORTB, DDRB)
- Interrupções por timer
- Watchdog timer
- Power management (sleep modes)
- Bootloader customizado
- Criação de bibliotecas próprias

**Transição para Bare-Metal:**
- Comparação Arduino vs. Registradores
- Performance optimization
- Redução de footprint de código

---

## 📖 Referências Específicas Arduino

### Documentação Essencial
1. **Arduino Reference** - https://www.arduino.cc/reference/en/
2. **ATmega328P Datasheet** - https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-7810-Automotive-Microcontrollers-ATmega328P_Datasheet.pdf
3. **Arduino Language Reference** - Funções, sintaxe, exemplos

### Livros Recomendados
- "Arduino Cookbook" - Michael Margolis
- "Programming Arduino" - Simon Monk
- "Arduino: A Technical Reference" - J.M. Hughes
- "Arduino para Iniciantes" - Monk Simon (PT-BR)

### Canais YouTube (PT-BR)
- Brincando com Ideias
- WR Kits
- Laboratório de Garagem
- Manual do Mundo (projetos)
- Vida de Silício

### Tutoriais Online
- Arduino Project Hub - https://create.arduino.cc/projecthub
- Tinkercad Circuits (simulador) - https://www.tinkercad.com/
- Instructables Arduino - https://www.instructables.com/circuits/arduino/

### Bibliotecas Úteis
```cpp
// Display LCD I2C
#include <LiquidCrystal_I2C.h>

// Servo motor
#include <Servo.h>

// Sensor DHT (temperatura/umidade)
#include <DHT.h>

// EEPROM
#include <EEPROM.h>

// SPI
#include <SPI.h>

// Wire (I2C)
#include <Wire.h>
```

---

## 💡 Dicas Específicas Arduino

### Pinos Especiais do Arduino UNO
- **Digital 0 (RX):** UART receive - evite usar se precisar de Serial
- **Digital 1 (TX):** UART transmit - evite usar se precisar de Serial
- **Digital 2, 3:** Suportam interrupts externos (attachInterrupt)
- **Digital 3, 5, 6, 9, 10, 11:** Suportam PWM (analogWrite)
- **Digital 13:** LED embutido (LED_BUILTIN)
- **Analog A0-A5:** 6 entradas analógicas ADC 10-bit
- **A4 (SDA), A5 (SCL):** I2C/TWI

### Boas Práticas

**Evite delay() em projetos sérios:**
```cpp
// ❌ Ruim - bloqueia execução
delay(1000);

// ✅ Bom - não-bloqueante
unsigned long previousMillis = 0;
const long interval = 1000;

void loop() {
  unsigned long currentMillis = millis();
  
  if (currentMillis - previousMillis >= interval) {
    previousMillis = currentMillis;
    // Seu código aqui
  }
}
```

**Use constantes para pinos:**
```cpp
// ✅ Bom - fácil manutenção
const int LED_PIN = 13;
const int BUTTON_PIN = 2;

void setup() {
  pinMode(LED_PIN, OUTPUT);
  pinMode(BUTTON_PIN, INPUT_PULLUP);
}
```

**Serial Monitor para Debug:**
```cpp
void setup() {
  Serial.begin(9600);
  Serial.println("Sistema iniciado!");
}

void loop() {
  int sensorValue = analogRead(A0);
  Serial.print("Sensor: ");
  Serial.println(sensorValue);
  delay(500);
}
```

### Cálculos Comuns

**ADC para Voltagem:**
```cpp
int raw = analogRead(A0);
float voltage = (raw / 1023.0) * 5.0;  // 0-5V
```

**LM35 Temperatura:**
```cpp
int raw = analogRead(A0);
float voltage = (raw / 1023.0) * 5.0;
float tempC = voltage * 100.0;  // LM35: 10mV/°C
```

**PWM Duty Cycle:**
```cpp
analogWrite(PIN, 128);  // 50% duty cycle (0-255)
```

### Debugging

**Serial Plotter:**
```cpp
// Ferramentas → Serial Plotter
void loop() {
  int value = analogRead(A0);
  Serial.println(value);  // Plota gráfico em tempo real
  delay(50);
}
```

**LED de Debug:**
```cpp
void debugBlink(int times) {
  for(int i = 0; i < times; i++) {
    digitalWrite(LED_BUILTIN, HIGH);
    delay(200);
    digitalWrite(LED_BUILTIN, LOW);
    delay(200);
  }
}
```

---

## 🔗 Próximo Passo

Após completar o **Nível 2** aqui, siga para:
- **[../i1-esp32/](../i1-esp32/)** - ESP32 com WiFi/Bluetooth e ESP-IDF

Ou consulte:
- **Roadmap geral:** [`../../learn/roadmap_geral.md`](../../learn/roadmap_geral.md)
- **Referências:** [`../../REFERENCIAS.md`](../../REFERENCIAS.md)
- **Voltar:** [`../README.md`](../README.md)

---

**Status atual:** Nível 1 em andamento

**Próxima etapa:** Completar exercícios básicos antes de avançar para ESP32
