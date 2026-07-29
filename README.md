# People Analytics Platform

Plataforma analítica de RH para uma empresa SaaS fictícia em alto crescimento. Modelagem dimensional, ETL, indicadores executivos e storytelling em Power BI.

## O problema

Uma empresa de software dobrou de tamanho em dois anos. Contratou rápido, cresceu em várias frentes ao mesmo tempo — e agora está perdendo gente sem saber direito por quê.

O RH tem os dados: histórico de admissão, desligamento, cargo, área, salário, avaliação, absenteísmo. O que falta não é dado, é leitura — algo que transforme esse histórico em decisão.

É esse o problema que este projeto ataca.

## O que a diretoria precisa saber

Perguntas definidas a partir do que os dados sustentam — não do que seria bonito perguntar. Onde o dado não sustenta, isso está dito.

**Dimensionamento e custo**
- Quantas pessoas a empresa tem — e quanta capacidade de trabalho isso representa de fato?
- Qual o custo da folha por área, business unit e centro de custo?
- Como o headcount evoluiu ao longo dos 48 meses?
- Qual o ritmo de admissões por ano?

**Saída de gente**
- A curva de saída se concentra em algum momento da jornada?
- O turnover varia por área e por nível — ou essa variação é ruído?
- Quem foi promovido fica mais do que quem não foi?
- Quem está marcado como alto potencial sai menos?

**Desempenho e desenvolvimento**
- Como a performance se distribui entre as pessoas?
- Existe descompasso entre salário e performance dentro do mesmo nível?
- Qual a cobertura de treinamento na base?

**Engajamento e o indicador de risco**
- O `risk_of_exit_score` mede risco de fato, ou é outra coisa com outro nome?
- Quem tem score alto sai mais do que quem tem score baixo?
- O score se move nos meses que antecedem a saída?

**Ausências**
- Absenteísmo se concentra em alguma área?
- A taxa de negativa de pedidos varia entre times?

## Indicadores de RH cobertos

| Indicador | Coberto | Observação |
|---|---|---|
| Headcount | Sim | Inclui distinção entre cabeças e FTE |
| Turnover | Sim | Segmentado por tempo de casa, área e nível |
| Absenteísmo | Sim | Atestados e taxa de negativa de pedidos |
| Custos de pessoal | Sim | Folha por área, business unit e centro de custo |
| Planejamento orçamentário | Sim | Base de folha por centro de custo |
| Avaliação de Desempenho | Sim | Distribuição e cruzamento com remuneração |
| Treinamento e Desenvolvimento | Sim | Cobertura e distribuição |
| Clima e engajamento | Sim | Índice de engajamento e sua relação com o score de risco |
| Recrutamento e Seleção | Parcial | Apenas volume de admissões por período |
| Time to Hire | Não | Não calculável — ver Fora de escopo |

## Fora de escopo

**Time to Hire.** A base não tem data de abertura de vaga nem etapas de processo seletivo — só `hire_date`. Sem o marco inicial, o indicador não é calculável. Volume de admissões por período está coberto; tempo de contratação não.

**Movimentação lateral entre áreas.** `department`, `job_title` e `location` não mudam para nenhuma das 755 pessoas ao longo dos 48 meses. A simulação não gera mobilidade horizontal.

**Dimensões demográficas.** Existem na base, mas não entram em nenhuma análise deste projeto.

**Promoções via colunas dedicadas.** `promotion_count` está zerado e `last_promotion_date` está vazia em 100% das linhas. Promoção é analisada por variação de `job_level` entre snapshots — 176 das 755 pessoas têm progressão registrada por esse caminho.

## Dados

Três arquivos, não versionados neste repositório (ver `.gitignore`).

| Arquivo | Linhas | O que é |
|---|---|---|
| `employees_updated.csv` | 793 | Cadastro — uma linha por pessoa |
| `snapshots_updated.csv` | 18.360 | 48 fotos mensais, abr/21 a mar/25 |
| `leave_requests.csv` | 902 | Pedidos de ausência |

O `snapshots` é o coração do projeto: é dado em painel, permite olhar trajetória em vez de retrato único.

> **Nota sobre o `risk_of_exit_score`:** a coluna já vem pronta na base original, calculada por snapshot — cada pessoa tem um score diferente a cada mês. O projeto não constrói esse score: ele o **valida**, cruzando os valores dos meses anteriores com quem de fato saiu depois.

**Fonte:** [Sample HR Dataset — High-Growth SaaS Simulation](https://www.kaggle.com/datasets/vicako/sample-hr-dataset-highgrowth-saas-simulation) (Kaggle)

**Licença:** MIT — uso, cópia e redistribuição livres

**Natureza:** dados fictícios, sem pessoas reais

Para reproduzir: baixe os arquivos no Kaggle e coloque em `data/raw/`. O motivo de não versionar está documentado em `docs/decisoes.md`.

## Estrutura

```
data/raw/         dados originais, intocados
data/processed/   saída do ETL
etl/              transformações em Power Query (M)
dax/              medidas versionadas em texto
powerbi/          arquivos do relatório
docs/             documentação e decisões
assets/           imagens e capturas de tela
```

A separação entre `raw` e `processed` existe para manter rastreabilidade: dá para refazer o caminho de qualquer número até a origem.

## Stack

- **Power BI** — modelagem e visualização
- **Power Query (M)** — camada de transformação
- **DAX** — indicadores
- **Git / GitHub** — versionamento e gestão do projeto

## Como estou trabalhando

Scrumban: sprints de uma semana, fluxo contínuo, uma tarefa em andamento por vez. Cada item vira uma issue com critérios de aceite — só entra em *Done* depois de validado, porque executar e conferir são etapas diferentes.

O board é a fonte de verdade sobre o andamento; não replico status aqui para não manter duas versões da mesma informação.

📋 [Board do projeto](https://github.com/users/marciacostaz/projects/1/views/1)

*Processo simplificado por ser um projeto individual. Em time, a coluna "In Review" corresponderia à revisão de Pull Request.*

## Autoria

**Marcia Costa**
[LinkedIn](https://www.linkedin.com/in/marciacostasp/) • [GitHub](https://github.com/marciacostaz/people-analytics-platform)
