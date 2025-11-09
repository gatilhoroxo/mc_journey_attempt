<div class="navbar">
  <a href="index.html">Início</a> |
  <a href="introducao.html">Introdução</a> |
  <a href="notas_tecnicas.html">Notas Técnicas</a> |
  <a href="referencias.html">Referências Úteis</a>
</div>

# Controle de Motor DC

<div class="navbar">
  <a href="../index.md">Início</a> |
  <a href="../projetos-simples/alguns_projetos.md">Projetos Simples</a> |
  <a href="../referencias.md">Referências</a>
</div>

---

## 🧠 Descrição

Este projeto demonstra o controle de velocidade e direção de um motor DC usando PWM e H-Bridge.

### Exemplo de código

```c
int IN1 = 9;
int IN2 = 8;
int ENA = 10;

void setup() {
  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);
  pinMode(ENA, OUTPUT);
}

void loop() {
  analogWrite(ENA, 200); // velocidade
  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW);
}
```

## 📈 Observação

Para segurança, adicione diodos de flyback e evite sobrecorrente.