# MiniGale

Script para aposta automática na Stake.com

A estratégia "Mini Gale" foi desenvolvida para ser utilizada no jogo DICE do site Stake.com utilizando o DiceBot. Esta estratégia adota uma abordagem sistemática para apostas, com o objetivo de maximizar os retornos potenciais e gerenciar efetivamente o risco.

## Parâmetros Chave da Estratégia

### Estrutura de Apostas

**Aposta Inicial**: A estratégia começa com uma aposta inicial equivalente a 0,0003% do seu saldo inicial.

**Aposta Progressiva:** Após cada derrota, o tamanho da aposta aumenta em 10% da aposta inicial, enquanto após cada vitória, o tamanho da aposta diminui em 9,7% da próxima aposta, alternando dessa forma.

**Meta de Lucro:** O principal objetivo é alcançar um lucro equivalente a 0,0004% da aposta inicial.
**Moeda:** A moeda uasada para esta estratégia é o USDT, devido à sua precisão com 8 casas decimais, permitindo um gerenciamento preciso do saldo.


## Probabilidade de Vitória
**Probabilidade de Vitória:** 
A estratégia opera com uma probabilidade fixa de vitória definida em 50%. Como resultado, vitórias e derrotas se alternarão regularmente.

## Gerenciamento de Risco
**Stop Loss**: Para mitigar o risco, um limite de perda é definido em 30% do seu saldo inicial, garantindo que você esteja arriscando apenas 70% do seu saldo inicial.

## Opções de Customização
Se você deseja personalizar esta estratégia ou adaptá-la às suas preferências, as seguintes variáveis podem ser ajustadas:

**banking:** Saldo inicial

**percentageBank:** Porcentagem do saldo usada como aposta base

**percentage:** Porcentagem de meta de lucro

**META_Stop_percentage:** Divide a meta de lucro em segmentos e reseta a semente a cada meta atingida

**stopLoss_Percentage:** Pare de apostar quando o saldo atingir 30% da banca inicial

**chance:** Probabilidade de vitória, definida em 50%

**baseChance:** Probabilidade base de vitória

**percentageLoss:** Aumenta o tamanho da aposta em 10% após uma derrota

**percentageWin:** Diminui o tamanho da aposta em -9,7% após uma vitória

**coinvalue:** Valor da moeda em Real ($$) para 1 USDT 

**pause_META:** Uma pausa de 30 segundos após atingir a meta de lucro

Esteja ciente de que os resultados podem variar com base na sequência de vitórias e derrotas. Recomenda-se práticas de jogo responsáveis e é essencial estabelecer e seguir limites de apostas.

# Pré-requisitos
- [DiceBot](https://github.com/GamblingWonder/Dicebot/releases/download/4.2.10.11/DiceBot.4.2.10.11.zip)
- [Script](https://github.com/GedelQ/MiniGale/archive/refs/heads/main.zip)
