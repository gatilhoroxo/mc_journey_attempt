# Blink LED 

## 🧩 Objetivo
Fazer um LED piscar usando o pino digital 13 do Arduino, compreendendo o funcionamento do loop principal, a manipulação de pinos digitais e a temporização com `delay()`.

---

## ⚙️ Componentes
| Componente | Quantidade | Função |
|------------|------------|--------|
| Arduino Uno | 1 | Microcontrolador principal |
| LED vermelho | 1 | Indicador visual |
| Resistor 220Ω | 1 | Limitar corrente do LED |
| Jumpers | - | Conexões elétricas |

---

## 🔌 Esquemático
**Conexões:**
- LED (ânodo) → Pino 13  
- LED (cátodo) → Resistor 220Ω → GND  

*(Pode ser desenhado no Fritzing ou em papel e digitalizado.)*

---

## 💻 Código
```cpp
void setup() {
  pinMode(13, OUTPUT);
}

void loop() {
  digitalWrite(13, HIGH);
  delay(1000);
  digitalWrite(13, LOW);
  delay(1000);
}
```

---

## 🔍 Explicação do Funcionamento
O pino 13 é configurado como saída digital.  
No loop principal, o Arduino coloca esse pino em nível alto (5V), acendendo o LED. Após 1 segundo (`delay(1000)`), o pino é colocado em nível baixo (0V), apagando o LED.  
O ciclo se repete indefinidamente, criando o efeito de piscar.

---

## ⚡ Conceitos Técnicos
- **Pino Digital:** O Arduino pode aplicar 0V (LOW) ou 5V (HIGH) em um pino de saída.
- **Função `pinMode()`:** Configura o pino como entrada (`INPUT`) ou saída (`OUTPUT`).
- **Função `digitalWrite()`:** Define o estado lógico do pino.
- **Função `delay()`:** Pausa a execução do código pelo número de milissegundos indicado.
- **Clock interno:** O temporizador do Arduino usa o cristal oscilador de 16 MHz para medir o tempo.

---

## 🧪 Testes e Resultados
O LED piscou com um intervalo constante de 1 segundo.  
Ao alterar o valor de `delay(1000)` para `delay(200)`, o piscar tornou-se cinco vezes mais rápido, demonstrando a relação direta entre o tempo de atraso e a frequência de piscagem.

---

## 🧰 Possíveis Melhorias
- Tornar o tempo de piscagem ajustável via potenciômetro (entrada analógica).  
- Controlar o LED via comunicação serial.  
- Substituir `delay()` por `millis()` para permitir multitarefas simples.

---

## ⚠️ Problemas e Soluções
> **Problema:** LED não acendia.  
> **Causa:** Pino incorreto ou LED invertido.  
> **Solução:** Verificar o lado correto do LED (ânodo no pino digital, cátodo no GND via resistor).

---

## 📚 Referências
- [Documentação oficial do Arduino](https://docs.arduino.cc/)
- [ATmega328P Datasheet](https://www.microchip.com/en-us/product/ATmega328P)

---

> _Projeto desenvolvido por Pirado — explorando o vasto mar dos microcontroladores._
