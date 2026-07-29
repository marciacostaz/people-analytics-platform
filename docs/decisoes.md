# Decisões do projeto

## 28/07 — Dados fora do repositório
`data/` está no .gitignore. O dataset é fictício e a licença permitiria subir, mas dado real de RH não vai para repositório em
lugar nenhum, então eu quis manter a mesma regra aqui. 
Link de download está no README.

## 28/07 — Estrutura em camadas
raw / processed separados para manter rastreabilidade: dá para provar de onde veio cada número refazendo o caminho.

## 29/07 — O risk_of_exit_score não é um modelo de risco

Testei antes de usar. O score não é um indicador independente: ele é o engajamento
invertido e reescalado. A fórmula é praticamente `1 − (engagement_score / 100)`,
com R² de 0,97. A correlação com engajamento é −0,987.

E não antecipa desligamento. Comparei o score dos meses anteriores com quem
realmente saiu:

- AUC de 0,466, ou seja, abaixo de 0,5 — pior que moeda justa
- O decil de maior risco tem a menor taxa de saída (21,1%)
- Nos 6 meses antes da saída o score fica parado, não sobe

Decisão: o score entra no projeto como objeto de análise, não como métrica de
apoio à decisão. A pergunta deixa de ser "o score acertou" e passa a ser "esse
indicador é confiável".

## 29/07 — Só o tempo de casa se relaciona com desligamento

Testei todas as dimensões estruturais contra saída, com chi-quadrado:

| Dimensão | p-valor | Relação |
|---|---|---|
| Tempo de casa | 0,0006 | sim |
| Business unit | 0,0527 | no limite, não |
| Área | 0,1731 | não |
| Nível | 0,9395 | não |
| Alto potencial | 0,9159 | não |

A curva por tempo de casa é real: sobe até a faixa de 1 a 3 anos (33,5%) e cai
para 21,5% depois de 3 anos.

As demais dimensões vão aparecer no dashboard, porque a leitura por área e nível
é esperada em qualquer painel de RH. Mas ficam rotuladas como não significativas.
Mostrar variação sem sinal como se fosse achado é o erro que eu não quero cometer
neste projeto.

## 29/07 — Promoção volta ao escopo por outro caminho

`promotion_count` está zerado em 100% das linhas e `last_promotion_date` está
vazia em 100%. As duas colunas são inúteis.

Mas a variação de `job_level` entre snapshots funciona como proxy: 176 das 755
pessoas têm progressão de nível registrada.

O resultado bruto sugeria que promoção retém (21,0% de saída contra 31,1%). Não
sustenta. Promovidos têm em média 37,4 meses de base observada contra 20,3 dos
não promovidos — promoção exige tempo de casa, então o grupo já é feito de quem
sobreviveu mais. Controlando por faixa de tempo de casa, a diferença desaparece
(35,0% contra 36,0% na faixa de 25 a 36 meses).

Registro isso porque o número bonito foi descartado de propósito.

## 29/07 — high_potential_flag e succession_plan_status são a mesma coluna

Coincidem em 100% dos casos: as mesmas 90 pessoas marcadas nas duas. Não são dois
critérios independentes. A pergunta original ("alto potencial ou plano de
sucessão") é uma pergunta, não duas.

E o programa não está retendo: 31,1% de saída entre os marcados contra 32,3% no
resto (p = 0,92).

## 29/07 — Time to Hire não é calculável

A base tem `hire_date`, mas não tem data de abertura de vaga nem etapas de
processo seletivo. Sem o marco inicial não existe intervalo para medir.

Volume de admissões por período está coberto. Tempo de contratação fica fora, e
isso está declarado no README.

## 29/07 — Movimentação lateral não existe na base

`department`, `job_title` e `location` não mudam para nenhuma das 755 pessoas ao
longo dos 48 meses. A simulação não gera mobilidade horizontal. Fora de escopo.

## 29/07 — Dimensões demográficas ficam fora

A base tem `ethnicity`, `gender`, `disability_status`, `veteran_status` e
`pronouns`. Nenhuma entra em análise neste projeto. Não é o recorte da pergunta
de negócio e não vou usar dado sensível sem necessidade.

## 29/07 — Headcount e FTE não são a mesma coisa

Em março de 2025 são 538 pessoas e 495,7 FTE. Diferença de 42,3, ou 8,5%. A base
tem 143 pessoas a 80% e 66 a 50%.

Contar cabeças superestima capacidade. Os dois números vão aparecer juntos no
painel executivo.
