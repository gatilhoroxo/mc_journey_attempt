
## 📚 NÍVEL 2 - INTERMEDIÁRIO (Semanas 7-10)

**Progresso:** [ ] Semana 7-8 | [ ] Semana 9 | [ ] Semana 10 | [ ] Projeto Final

---

## 📑 Índice

### [Semana 7-8: Timers e Interrupts](#semana-7-8-timers-e-interrupts)
- [Exercício 9: Timer Preciso](#exercício-9-timer-preciso)
- [Exercício 10: Interrupt de GPIO](#exercício-10-interrupt-de-gpio)

### [Semana 9: I2C e Display OLED](#semana-9-i2c-e-display-oled)
- [Exercício 11: OLED SSD1306](#exercício-11-oled-ssd1306)

### [Semana 10: WiFi Básico](#semana-10-wifi-básico)
- [Exercício 12: Conectar WiFi e Servidor Web](#exercício-12-conectar-wifi-e-servidor-web)

### [🎯 Projeto Final: Monitor de Temperatura WiFi](#-projeto-final-monitor-de-temperatura-wifi)

### [⚠️ Problemas Comuns e Soluções](#️-problemas-comuns-e-soluções)

### [🔗 Próximos Passos](#-próximos-passos)

---

## Semana 7-8: Timers e Interrupts

**📊 Metadados:**
- ⏱️ **Tempo estimado:** 16-20 horas
- 📊 **Dificuldade:** ⭐⭐⭐ Intermediário
- 🎯 **Habilidades desenvolvidas:** Hardware timers, ISR, interrupções de GPIO, eventos assíncronos
- ✅ **Checklist:** [ ] Exercício 9 | [ ] Exercício 10

### 📖 Fundamentos - Timers e Interrupções

**O que são Hardware Timers?**
- Contadores independentes da CPU
- Precisão muito superior a delays por software
- ESP32 tem 4 timers de 64 bits (General Purpose Timers)
- Não bloqueiam execução do código

**Vantagens sobre vTaskDelay:**
- Precisão em microsegundos
- Não dependem do scheduler
- Podem chamar callbacks automaticamente
- Múltiplos timers simultâneos

**Interrupções (Interrupts):**
- Mecanismo para responder imediatamente a eventos
- CPU para execução atual e executa ISR (Interrupt Service Routine)
- Após ISR, retorna ao ponto interrompido
- Prioridade sobre código normal

**Tipos de Interrupções no ESP32:**
- **GPIO:** Mudanças de estado em pinos
- **Timer:** Alarmes de tempo
- **UART, I2C, SPI:** Eventos de comunicação
- **ADC:** Conversão completa

**Regras Importantes para ISR:**
- Deve ser RÁPIDA (< 1ms ideal)
- Marcar função com `IRAM_ATTR` (executa da RAM)
- Evitar printf, malloc, delays
- Usar variáveis `volatile` para dados compartilhados
- Comunicar com código principal via flags/queues

**APIs Principais:**
```c
// Timers
gptimer_new_timer()              // Cria timer
gptimer_set_alarm_action()       // Configura alarme
gptimer_register_event_callbacks() // Registra callback
gptimer_enable()                 // Habilita timer
gptimer_start()                  // Inicia contagem

// Interrupções GPIO
gpio_install_isr_service()       // Instala serviço ISR
gpio_isr_handler_add()           // Adiciona handler
gpio_set_intr_type()             // Define tipo de trigger
```

---

### Exercício 9: Timer Preciso

**Objetivo:** Usar hardware timer ao invés de vTaskDelay para temporização precisa

**Componentes Necessários:**
- 1x LED (ou use GPIO_NUM_2)
- 1x Resistor 220Ω (se usar LED externo)
- Jumpers

**Conceitos:**
- Configuração de General Purpose Timer (GPTIMER)
- Callbacks de alarme
- Execução de código em ISR (IRAM_ATTR)
- Auto-reload de timers

```c
#include "driver/gptimer.h"

gptimer_handle_t gptimer = NULL;
bool led_state = false;

bool IRAM_ATTR timer_callback(gptimer_handle_t timer, 
                                const gptimer_alarm_event_data_t *edata,
                                void *user_data)
{
    led_state = !led_state;
    gpio_set_level(LED_PIN, led_state);
    return false;  // não precisa retornar high priority task woken
}

void app_main(void)
{
    gpio_reset_pin(LED_PIN);
    gpio_set_direction(LED_PIN, GPIO_MODE_OUTPUT);
    
    // Configurar timer
    gptimer_config_t timer_config = {
        .clk_src = GPTIMER_CLK_SRC_DEFAULT,
        .direction = GPTIMER_COUNT_UP,
        .resolution_hz = 1000000,  // 1MHz = 1us
    };
    gptimer_new_timer(&timer_config, &gptimer);
    
    // Configurar alarme
    gptimer_alarm_config_t alarm_config = {
        .alarm_count = 1000000,  // 1 segundo
        .reload_count = 0,
        .flags.auto_reload_on_alarm = true,
    };
    gptimer_set_alarm_action(gptimer, &alarm_config);
    
    // Registrar callback
    gptimer_event_callbacks_t cbs = {
        .on_alarm = timer_callback,
    };
    gptimer_register_event_callbacks(gptimer, &cbs, NULL);
    
    gptimer_enable(gptimer);
    gptimer_start(gptimer);
    
    while(1) {
        vTaskDelay(1000 / portTICK_PERIOD_MS);
    }
}
```

**Desafios:**
1. 🟢 **Fácil:** Mudar frequência do blink para 500ms (mais rápido)
2. 🟡 **Médio:** Usar 2 timers para controlar 2 LEDs em frequências diferentes
3. 🔴 **Difícil:** Criar cronômetro preciso (minutos:segundos:milissegundos) com display

---

### Exercício 10: Interrupt de GPIO

**Objetivo:** Responder imediatamente a eventos de botão usando interrupções

**Componentes Necessários:**
- 1x Botão (ou use botão BOOT GPIO_NUM_0)
- 1x LED
- 1x Resistor 220Ω (para LED)
- 1x Resistor 10kΩ (se usar botão externo)
- Jumpers

**Conceitos:**
- Configuração de interrupção GPIO
- ISR (Interrupt Service Routine)
- Tipos de trigger (POSEDGE, NEGEDGE, ANYEDGE)
- Variáveis voláteis
- Sincronização ISR vs main loop

```c
#define BUTTON_PIN GPIO_NUM_0

volatile int button_presses = 0;

void IRAM_ATTR button_isr_handler(void *arg)
{
    button_presses++;
}

void app_main(void)
{
    gpio_config_t io_conf = {
        .pin_bit_mask = (1ULL << BUTTON_PIN),
        .mode = GPIO_MODE_INPUT,
        .pull_up_en = GPIO_PULLUP_ENABLE,
        .pull_down_en = GPIO_PULLDOWN_DISABLE,
        .intr_type = GPIO_INTR_NEGEDGE,  // Falling edge
    };
    gpio_config(&io_conf);
    
    gpio_install_isr_service(0);
    gpio_isr_handler_add(BUTTON_PIN, button_isr_handler, NULL);
    
    while(1) {
        printf("Botão pressionado %d vezes\n", button_presses);
        vTaskDelay(1000 / portTICK_PERIOD_MS);
    }
}
```

**Desafios:**
1. 🟢 **Fácil:** Mudar para detectar rising edge (quando solta o botão)
2. 🟡 **Médio:** Implementar debounce na ISR usando timestamp
3. 🔴 **Difícil:** Usar queue (FreeRTOS) para comunicar ISR com task principal

---

## Semana 9: I2C e Display OLED

**📊 Metadados:**
- ⏱️ **Tempo estimado:** 10-12 horas
- 📊 **Dificuldade:** ⭐⭐⭐ Intermediário
- 🎯 **Habilidades desenvolvidas:** Protocolo I2C, comunicação com periféricos, displays gráficos
- ✅ **Checklist:** [ ] Exercício 11

### 📖 Fundamentos - I2C (Inter-Integrated Circuit)

**O que é I2C?**
- Protocolo de comunicação serial síncrono
- 2 fios: SDA (dados) e SCL (clock)
- Permite múltiplos dispositivos no mesmo barramento
- Cada dispositivo tem endereço único (7 ou 10 bits)

**Características:**
- **Master/Slave:** ESP32 geralmente é master
- **Velocidade:** 100kHz (standard), 400kHz (fast), 1MHz (fast+)
- **Endereçamento:** Cada slave tem ID (ex: 0x3C para OLED)
- **Pull-up:** Requer resistores externos (geralmente 4.7kΩ)

**Dispositivos Comuns I2C:**
- Displays OLED (SSD1306, SH1106)
- Sensores (BME280, MPU6050, AHT20)
- RTC (DS1307, DS3231)
- EEPROM
- Expansores de GPIO (PCF8574)

**Pinos ESP32:**
- **Padrão:** SDA = GPIO_NUM_21, SCL = GPIO_NUM_22
- Podem ser remapeados para outros pinos

**APIs Principais:**
```c
i2c_param_config()        // Configura parâmetros
i2c_driver_install()      // Instala driver
i2c_master_write_to_device() // Envia dados
i2c_master_read_from_device() // Lê dados
```

---

### Exercício 11: OLED SSD1306

**Objetivo:** Controlar display OLED via I2C

**Componentes Necessários:**
- 1x Display OLED 128x64 SSD1306 (I2C)
- Jumpers

**Conceitos:**
- Inicialização de barramento I2C
- Endereçamento de dispositivos I2C
- Uso de bibliotecas externas (component)
- Renderização gráfica em displays

```c
#include "driver/i2c.h"

#define I2C_MASTER_SCL_IO GPIO_NUM_22
#define I2C_MASTER_SDA_IO GPIO_NUM_21
#define I2C_MASTER_FREQ_HZ 400000

void i2c_master_init(void)
{
    i2c_config_t conf = {
        .mode = I2C_MODE_MASTER,
        .sda_io_num = I2C_MASTER_SDA_IO,
        .scl_io_num = I2C_MASTER_SCL_IO,
        .sda_pullup_en = GPIO_PULLUP_ENABLE,
        .scl_pullup_en = GPIO_PULLUP_ENABLE,
        .master.clk_speed = I2C_MASTER_FREQ_HZ,
    };
    
    i2c_param_config(I2C_NUM_0, &conf);
    i2c_driver_install(I2C_NUM_0, conf.mode, 0, 0, 0);
}

// Use biblioteca como SSD1306 driver
// Exemplo: https://github.com/nopnop2002/esp-idf-ssd1306
```

**Desafios:**
1. 🟢 **Fácil:** Exibir "Hello ESP32!" centralizado na tela
2. 🟡 **Médio:** Criar animação simples (texto deslizando)
3. 🔴 **Difícil:** Exibir gráfico de barras com leituras de ADC em tempo real

---

## Semana 10: WiFi Básico

**📊 Metadados:**
- ⏱️ **Tempo estimado:** 12-15 horas
- 📊 **Dificuldade:** ⭐⭐⭐⭐ Intermediário-Avançado
- 🎯 **Habilidades desenvolvidas:** WiFi, servidor HTTP, NVS, eventos de rede
- ✅ **Checklist:** [ ] Exercício 12

### 📖 Fundamentos - WiFi no ESP32

**Modos WiFi:**
- **Station (STA):** Conecta em roteador existente
- **Access Point (AP):** Cria própria rede WiFi
- **AP+STA:** Ambos simultaneamente

**Processo de Conexão:**
1. Inicializar NVS (armazenamento não-volátil)
2. Inicializar netif e event loop
3. Configurar WiFi (SSID, senha)
4. Iniciar WiFi e conectar
5. Aguardar evento de IP obtido

**HTTP Server:**
- Servidor web leve integrado no ESP-IDF
- Suporta GET, POST, PUT, DELETE
- Handlers por URI
- Pode servir páginas HTML estáticas ou dinâmicas

**NVS (Non-Volatile Storage):**
- Armazenamento persistente (não perde ao desligar)
- Usado pelo WiFi para salvar configurações
- Essencial inicializar antes de WiFi

**APIs Principais:**
```c
esp_netif_init()          // Inicializa interface de rede
esp_wifi_init()           // Inicializa WiFi
esp_wifi_set_mode()       // Define modo (STA/AP)
esp_wifi_set_config()     // Configura credenciais
esp_wifi_start()          // Inicia WiFi
esp_wifi_connect()        // Conecta ao AP
httpd_start()             // Inicia servidor HTTP
httpd_register_uri_handler() // Registra endpoint
```

---

### Exercício 12: Conectar WiFi e Servidor Web

**Objetivo:** Controlar LED através de página web

**Componentes Necessários:**
- 1x LED (ou use GPIO_NUM_2)
- 1x Resistor 220Ω (se usar LED externo)
- Rede WiFi disponível
- Jumpers

**Conceitos:**
- Configuração WiFi Station mode
- Event handlers de WiFi
- HTTP server e rotas
- Controle remoto via web

```c
#include "esp_wifi.h"
#include "esp_http_server.h"
#include "nvs_flash.h"

#define WIFI_SSID "SeuWiFi"
#define WIFI_PASS "SuaSenha"

esp_err_t led_on_handler(httpd_req_t *req)
{
    gpio_set_level(LED_PIN, 1);
    httpd_resp_send(req, "LED Ligado!", HTTPD_RESP_USE_STRLEN);
    return ESP_OK;
}

esp_err_t led_off_handler(httpd_req_t *req)
{
    gpio_set_level(LED_PIN, 0);
    httpd_resp_send(req, "LED Desligado!", HTTPD_RESP_USE_STRLEN);
    return ESP_OK;
}

void wifi_init(void)
{
    nvs_flash_init();
    esp_netif_init();
    esp_event_loop_create_default();
    
    wifi_init_config_t cfg = WIFI_INIT_CONFIG_DEFAULT();
    esp_wifi_init(&cfg);
    
    wifi_config_t wifi_config = {
        .sta = {
            .ssid = WIFI_SSID,
            .password = WIFI_PASS,
        },
    };
    
    esp_wifi_set_mode(WIFI_MODE_STA);
    esp_wifi_set_config(WIFI_IF_STA, &wifi_config);
    esp_wifi_start();
    esp_wifi_connect();
}

void start_webserver(void)
{
    httpd_handle_t server = NULL;
    httpd_config_t config = HTTPD_DEFAULT_CONFIG();
    
    httpd_uri_t led_on = {
        .uri = "/led/on",
        .method = HTTP_GET,
        .handler = led_on_handler,
    };
    
    httpd_uri_t led_off = {
        .uri = "/led/off",
        .method = HTTP_GET,
        .handler = led_off_handler,
    };
    
    httpd_start(&server, &config);
    httpd_register_uri_handler(server, &led_on);
    httpd_register_uri_handler(server, &led_off);
}
```

**Desafios:**
1. 🟢 **Fácil:** Adicionar endpoint para toggle LED (/led/toggle)
2. 🟡 **Médio:** Criar página HTML com botões visuais
3. 🔴 **Difícil:** Implementar controle de brilho PWM via slider web

---

## 🎯 Projeto Final: Monitor de Temperatura WiFi

**📊 Metadados do Projeto:**
- ⏱️ **Tempo estimado:** 20-25 horas
- 📊 **Dificuldade:** ⭐⭐⭐⭐ Intermediário-Avançado
- 🎯 **Habilidades integradas:** I2C, WiFi, HTTP, timers, displays, alertas

**Descrição:**
Sistema completo de monitoramento de temperatura com display local OLED e interface web para visualização remota, incluindo histórico e alertas.

**Componentes Necessários:**
- 1x Sensor de temperatura I2C (BME280, AHT20 ou DHT22 com adaptador I2C)
- 1x Display OLED 128x64 SSD1306
- 1x LED vermelho (alerta)
- 1x Resistor 220Ω
- Jumpers

**Funcionalidades Obrigatórias:**
1. ✅ Ler temperatura/umidade a cada 5 segundos
2. ✅ Exibir dados no OLED (temperatura, umidade, status WiFi)
3. ✅ Servidor web mostra leitura atual e histórico das últimas 20 leituras
4. ✅ LED de alerta acende se temperatura > 30°C
5. ✅ Endpoint API JSON com dados atuais

**Critérios de Avaliação:**
- [ ] Sensor I2C lê corretamente
- [ ] Display OLED exibe dados atualizados
- [ ] WiFi conecta e obtém IP
- [ ] Servidor web acessível no navegador
- [ ] API JSON retorna dados corretos
- [ ] LED alerta funciona conforme threshold
- [ ] Código organizado em funções/tasks

**Extensões Opcionais (🌟 Desafios Extras):**
1. 🟡 Adicionar gráfico SVG dinâmico na página web
2. 🟡 Salvar histórico em NVS (persiste após reboot)
3. 🔴 Implementar modo AP para configuração inicial (WiFi provisioning)
4. 🔴 Adicionar notificações push em alertas
5. 🔴 Criar dashboard com Chart.js para visualização profissional

---

## ⚠️ Problemas Comuns e Soluções

### Timer não dispara callback
**Sintoma:** LED não pisca ou callback nunca é chamado

**Soluções:**
- ✅ Verificar se `gptimer_enable()` e `gptimer_start()` foram chamados
- ✅ Confirmar resolução e alarm_count corretos
- ✅ Callback deve retornar `false` (ou `true` se precisar acordar task)
- ✅ Verificar se `auto_reload_on_alarm` está `true` para repetir

### ISR causa crash/reset
**Sintoma:** ESP32 reinicia quando interrupção dispara

**Soluções:**
- ✅ Marcar ISR com `IRAM_ATTR`
- ✅ Não usar `printf` dentro da ISR (use flags)
- ✅ Não chamar funções de delay ou malloc
- ✅ ISR deve ser MUITO rápida (< 1ms)
- ✅ Usar variáveis `volatile` para dados compartilhados

### I2C não encontra dispositivo
**Sintoma:** Erro "timeout" ou "no ACK"

**Soluções:**
- ✅ Verificar endereço I2C correto (usar i2c scanner)
- ✅ Confirmar pull-ups de 4.7kΩ em SDA e SCL
- ✅ Verificar alimentação do dispositivo (3.3V)
- ✅ Testar com velocidade menor (100kHz)
- ✅ Verificar conexões físicas (SDA/SCL não invertidos)

### Display OLED não mostra nada
**Sintoma:** Tela permanece apagada

**Soluções:**
- ✅ Verificar se biblioteca foi inicializada corretamente
- ✅ Confirmar endereço (0x3C ou 0x3D)
- ✅ Chamar função de "display()" ou "update()" após desenhar
- ✅ Resetar display via código
- ✅ Verificar contraste configurado

### WiFi não conecta
**Sintoma:** ESP32 não obtém IP

**Soluções:**
- ✅ Verificar SSID e senha corretos
- ✅ NVS deve ser inicializado ANTES de WiFi
- ✅ Aguardar evento `IP_EVENT_STA_GOT_IP`
- ✅ Verificar se roteador está em 2.4GHz (ESP32 não suporta 5GHz)
- ✅ Aumentar timeout de conexão

### HTTP server retorna erro 404
**Sintoma:** Página não encontrada ao acessar

**Soluções:**
- ✅ Verificar URI exata (case-sensitive: "/led/on" ≠ "/LED/ON")
- ✅ Confirmar que handler foi registrado
- ✅ Server deve estar iniciado antes de registrar URIs
- ✅ Verificar firewall/rede (ping no IP do ESP32)

### Leitura do sensor I2C retorna valores absurdos
**Sintoma:** Temperatura -40°C ou 85°C constante

**Soluções:**
- ✅ Aguardar inicialização do sensor (100-500ms)
- ✅ Ler datasheet para sequência correta de inicialização
- ✅ Verificar se sensor requer calibração
- ✅ Conferir fórmula de conversão (raw → temperatura)

---

## 🔗 Próximos Passos

**🎉 Parabéns por completar o Nível 2!**

Você agora domina:
- ✅ Hardware timers para temporização precisa
- ✅ Interrupções (ISR) para eventos assíncronos
- ✅ Comunicação I2C com sensores e displays
- ✅ WiFi Station mode e conexão a redes
- ✅ HTTP server e APIs REST
- ✅ Integração de múltiplos periféricos complexos
- ✅ FreeRTOS tasks para multitarefa

**Pré-requisitos atendidos para Nível 3:**
- ✅ Domínio de comunicação serial (I2C)
- ✅ Experiência com WiFi e servidores
- ✅ Confortável com multitasking
- ✅ Capacidade de integrar sistemas complexos

**Próximo Nível:**
🔼 **[Nível 3 - Avançado](../nivel-3-avancado/info-avancado.md)**

O que você vai aprender:
- FreeRTOS avançado (queues, semaphores, mutexes)
- Dual-core programming (taskAffinity)
- Bluetooth BLE (GATT, advertising)
- SPI e comunicação de alta velocidade
- OTA (Over-The-Air updates)
- Otimização de energia (deep sleep, light sleep)
- Segurança (HTTPS, encryption)

**Recomendações antes de avançar:**
1. 📝 Revisar conceitos de ISR e timers
2. 🛠️ Experimentar com diferentes sensores I2C
3. 📚 Ler sobre FreeRTOS: [FreeRTOS Guide](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/system/freertos.html)
4. 🔍 Estudar exemplos WiFi: [ESP-IDF WiFi Examples](https://github.com/espressif/esp-idf/tree/master/examples/wifi)

**Recursos de Referência:**
- 📖 [ESP32 WiFi Driver](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/network/esp_wifi.html)
- 📖 [ESP HTTP Server](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/protocols/esp_http_server.html)
- 📺 [Andreas Spiess - ESP32 Tutorials](https://www.youtube.com/@AndreasSpiess)
- 💻 [I2C Scanner Tool](https://github.com/espressif/esp-idf/tree/master/examples/peripherals/i2c/i2c_tools)

**Voltar:**
- 🏠 [README Principal ESP32](../../README.md)
- 📚 [Roadmap Geral](../../../../learn/roadmap_geral.md)
- 📝 [Nível 1 - Básico](../nivel-1-basico/info-basico.md)

---

**Última atualização:** 26/12/2025
