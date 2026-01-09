#include "driver/gpio.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

#define LED_PIN GPIO_NUM_2  // LED interno

void app_main(void)
{
    // Configurar pino como saída
    gpio_reset_pin(LED_PIN);
    gpio_set_direction(LED_PIN, GPIO_MODE_OUTPUT);
    
    while(1) {
        gpio_set_level(LED_PIN, 1);  // Liga
        vTaskDelay(1000 / portTICK_PERIOD_MS);
        gpio_set_level(LED_PIN, 0);  // Desliga
        vTaskDelay(1000 / portTICK_PERIOD_MS);
    }
}