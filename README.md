# People Analytics Platform

Plataforma analítica de RH para uma empresa SaaS fictícia em alto
crescimento. Modelagem dimensional, ETL, indicadores executivos e
storytelling em Power BI.

---

## O problema

Uma empresa de software dobrou de tamanho em dois anos. Contratou
rápido, cresceu em várias frentes ao mesmo tempo — e agora está
perdendo gente sem saber direito por quê.

O RH tem os dados. Tem histórico de admissão, desligamento, cargo,
área, salário, avaliação, absenteísmo. O que não tem é uma leitura
que transforme isso em decisão.

É esse o problema que este projeto ataca: não é falta de dado, é
falta de resposta.

## O que a diretoria precisa saber

Perguntas definidas a partir do que os dados sustentam — não do que
seria bonito perguntar.

**Sobre saída de gente**
- Qual o turnover por área, nível e tempo de casa?
- A curva de saída se concentra em algum momento da jornada?
- Quem sai é quem estava marcado como alto potencial ou plano de
  sucessão?

**Sobre antecipação**
- O `risk_of_exit_score` acertou? Quem saiu tinha score alto nos
  meses anteriores?
- Engajamento e performance caem antes do desligamento, ou a saída
  é abrupta?
- Quanto tempo de antecedência o dado dá?

**Sobre custo e estrutura**
- Qual o custo da folha por área e business unit?
- Existe descompasso entre salário e performance dentro do mesmo
  nível?
- Como o headcount evoluiu ao longo dos 48 meses?

**Sobre ausências**
- Absenteísmo (Sick) se concentra em alguma área ou perfil?
- Taxa de negativa de pedidos varia entre times?

**Fora de escopo**
Promoções não são analisáveis: `promotion_count` está zerado para
toda a base. Se surgir necessidade, o caminho é rastrear mudança de
`job_level` entre snapshots.

## Dados

Três arquivos, não versionados neste repositório (ver `.gitignore`).

| Arquivo | Linhas | O que é |
|---|---|---|
| `employees_updated.csv` | 793 | Cadastro — uma linha por pessoa |
| `snapshots_updated.csv` | 18.360 | 48 fotos mensais, abr/21 a mar/25 |
| `leave_requests.csv` | 902 | Pedidos de ausência |

O `snapshots` é o coração do projeto: é dado em painel, permite
olhar trajetória em vez de retrato único.

**Fonte:** Sample HR Dataset — High Growth SaaS Simulation (Kaggle)
**Licença:** MIT — permite uso, cópia e redistribuição livre
**Natureza:** dados fictícios, sem pessoas reais

Para reproduzir: baixe os arquivos no Kaggle e coloque em `data/raw/`.
O motivo de não versionar está em [`docs/decisoes.md`](docs/decisoes.md).

## Estrutura
A separação entre `raw` e `processed` existe para manter
rastreabilidade: dá para refazer o caminho de qualquer número até
a origem.

## Stack

- **Power BI** — modelagem e visualização
- **Power Query (M)** — camada de transformação
- **DAX** — indicadores
- **Git / GitHub** — versionamento e gestão do projeto

## Como estou trabalhando

Scrumban: sprints de uma semana, fluxo contínuo, uma tarefa em
andamento por vez.

Cada item vira uma issue com critérios de aceite. Só entra em
`Done` depois de validado — executar e conferir são etapas
diferentes.

📋 [Board do projeto](https://github.com/users/marciacostaz/projects/1)

> Processo simplificado por ser um projeto individual. Em time, a
> coluna `In Review` corresponderia à revisão de Pull Request.

## Status

**Sprint 0 — concluída.** Repositório, estrutura, board e
documentação inicial.

**Sprint 1 — próxima.** Exploração dos dados e validação das
perguntas de negócio.

---

Marcia Costa
