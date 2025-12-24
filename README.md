# CBLOL-DB-2023
# 🎮 Sistema de Banco de Dados - CBLOL 2023

[Oracle](https://img.shields.io/badge/Oracle-F80000?style=for-the-badge&logo=oracle&logoColor=white)

[SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=postgresql&logoColor=white)

[League of Legends](https://img.shields.io/badge/League%20of%20Legends-0C1116?style=for-the-badge&logo=leagueoflegends&logoColor=white)

Sistema completo de banco de dados para armazenamento e análise de dados do **Campeonato Brasileiro de League of Legends (CBLOL)** da temporada 2023.

---

## 📋 Índice

- [Visão Geral](https://claude.ai/chat/fb19a822-8b4f-4b11-b03b-14fda48728bc#-vis%C3%A3o-geral)
- [Características](https://claude.ai/chat/fb19a822-8b4f-4b11-b03b-14fda48728bc#-caracter%C3%ADsticas)
- [Estrutura do Banco](https://claude.ai/chat/fb19a822-8b4f-4b11-b03b-14fda48728bc#-estrutura-do-banco)
- [Pré-requisitos](https://claude.ai/chat/fb19a822-8b4f-4b11-b03b-14fda48728bc#-pr%C3%A9-requisitos)
- [Instalação](https://claude.ai/chat/fb19a822-8b4f-4b11-b03b-14fda48728bc#-instala%C3%A7%C3%A3o)
- [Uso](https://claude.ai/chat/fb19a822-8b4f-4b11-b03b-14fda48728bc#-uso)
- [Consultas Disponíveis](https://claude.ai/chat/fb19a822-8b4f-4b11-b03b-14fda48728bc#-consultas-dispon%C3%ADveis)
- [Modelo de Dados](https://claude.ai/chat/fb19a822-8b4f-4b11-b03b-14fda48728bc#-modelo-de-dados)
- [Exemplos de Queries](https://claude.ai/chat/fb19a822-8b4f-4b11-b03b-14fda48728bc#-exemplos-de-queries)
- [Contribuindo](https://claude.ai/chat/fb19a822-8b4f-4b11-b03b-14fda48728bc#-contribuindo)
- [Licença](https://claude.ai/chat/fb19a822-8b4f-4b11-b03b-14fda48728bc#-licen%C3%A7a)

---

## 🎯 Visão Geral

Este projeto implementa um sistema de banco de dados relacional completo para gerenciar informações do CBLOL 2023, incluindo:

- **10 times** reais da competição
- **50 jogadores** profissionais (5 por time)
- **2 splits** (fases do campeonato)
- **90 partidas** com dados realistas
- **900 registros** de estatísticas de jogadores

O sistema permite análises detalhadas de desempenho, rankings, estatísticas e comparações entre jogadores, times e fases do campeonato.

---

## ✨ Características

### 🔧 Funcionalidades Técnicas

- ✅ **Estrutura normalizada** (3FN) para garantir integridade dos dados
- ✅ **Constraints avançadas** (CHECK, FOREIGN KEY, UNIQUE)
- ✅ **Índices otimizados** para consultas rápidas
- ✅ **Geração automática** de dados realistas
- ✅ **Validações de integridade** (times diferentes, valores positivos, etc.)
- ✅ **Consultas prontas** para análises estatísticas

### 📊 Funcionalidades de Negócio

- 📈 Ranking de times por vitórias e winrate
- 🏆 Top jogadores por KDA (Kill/Death/Assist)
- 🎮 Champions mais jogados e suas estatísticas
- 📅 Comparação entre Splits (fases)
- 💰 Análise de gold, CS e damage por posição
- ⚔️ Estatísticas individuais por partida

---

## 🗄️ Estrutura do Banco

### Tabelas Principais

| Tabela | Descrição | Registros |
| --- | --- | --- |
| `teams` | Times participantes | 10 |
| `splits` | Fases do campeonato | 2 |
| `players` | Jogadores profissionais | 50 |
| `matches` | Partidas realizadas | 90 |
| `player_stats` | Estatísticas por jogador/partida | 900 |

### Relacionamentos

```
teams (1) ──────< (N) players
  │
  │ (lado azul)
  ├──────< (N) matches
  │ (lado vermelho)
  │
  └──────< (N) matches

splits (1) ──────< (N) matches

matches (1) ──────< (N) player_stats

players (1) ──────< (N) player_stats

```

---

## 🔧 Pré-requisitos

### Requisitos de Sistema

- **Oracle Database** 11g ou superior
- **SQL*Plus** ou qualquer cliente Oracle (SQL Developer, DBeaver, etc.)
- Privilégios para:
    - Criar tabelas (`CREATE TABLE`)
    - Inserir dados (`INSERT`)
    - Criar índices (`CREATE INDEX`)
    - Executar blocos PL/SQL

### Conhecimentos Recomendados

- SQL básico (SELECT, INSERT, JOIN)
- Noções de PL/SQL (blocos BEGIN/END, loops)
- Conceitos de banco de dados relacional

---

## 📥 Instalação

### Passo 1: Clone ou Baixe o Arquivo

```bash
git clone https://github.com/sunny1est/cblol-database.git
cd cblol-database

```

Ou simplesmente copie o código SQL para um arquivo chamado `cblol_2023_setup.sql`

### Passo 2: Conecte ao Oracle

```bash
sqlplus usuario/senha@banco

```

Ou use SQL Developer / DBeaver para conectar ao seu banco Oracle.

### Passo 3: Execute o Script

```sql
@cblol_2023_setup.sql

```

Ou copie e cole todo o conteúdo no seu cliente SQL e execute.

### Passo 4: Verifique a Instalação

```sql
-- Verifica se as tabelas foram criadas
SELECT table_name FROM user_tables
WHERE table_name IN ('TEAMS', 'PLAYERS', 'MATCHES', 'SPLITS', 'PLAYER_STATS');

-- Verifica quantidade de registros
SELECT 'TEAMS' as tabela, COUNT(*) as total FROM teams
UNION ALL
SELECT 'PLAYERS', COUNT(*) FROM players
UNION ALL
SELECT 'MATCHES', COUNT(*) FROM matches
UNION ALL
SELECT 'PLAYER_STATS', COUNT(*) FROM player_stats;

```

**Resultado esperado:**

```
TEAMS          | 10
PLAYERS        | 50
MATCHES        | 90
PLAYER_STATS   | 900

```

---

## 🚀 Uso

### Consultas Básicas

### Listar Todos os Times

```sql
SELECT team_name, team_tag, founded_year
FROM teams
ORDER BY team_name;

```

### Ver Jogadores de um Time

```sql
SELECT p.nickname, p.role, t.team_name
FROM players p
JOIN teams t ON p.team_id = t.team_id
WHERE t.team_name = 'paiN Gaming'
ORDER BY
  CASE p.role
    WHEN 'TOP' THEN 1
    WHEN 'JG' THEN 2
    WHEN 'MID' THEN 3
    WHEN 'ADC' THEN 4
    WHEN 'SUP' THEN 5
  END;

```

### Partidas de uma Semana Específica

```sql
SELECT
    m.match_date,
    tb.team_name as time_azul,
    tr.team_name as time_vermelho,
    m.winner_side as vencedor,
    ROUND(m.game_duration/60, 1) as duracao_min
FROM matches m
JOIN teams tb ON m.team_blue_id = tb.team_id
JOIN teams tr ON m.team_red_id = tr.team_id
WHERE m.week_number = 1
ORDER BY m.match_date;

```

---

## 📊 Consultas Disponíveis

### 1️⃣ Ranking de Times

Mostra vitórias, total de jogos e winrate de cada time.

```sql
SELECT
    t.team_name,
    COUNT(CASE WHEN (m.winner_side = 'BLUE' AND m.team_blue_id = t.team_id)
                 OR (m.winner_side = 'RED' AND m.team_red_id = t.team_id)
           THEN 1 END) as vitorias,
    COUNT(*) as total_jogos,
    ROUND(COUNT(CASE WHEN (m.winner_side = 'BLUE' AND m.team_blue_id = t.team_id)
                        OR (m.winner_side = 'RED' AND m.team_red_id = t.team_id)
                    THEN 1 END) * 100.0 / COUNT(*), 2) as winrate
FROM teams t
JOIN matches m ON t.team_id IN (m.team_blue_id, m.team_red_id)
GROUP BY t.team_name
ORDER BY vitorias DESC;

```

**Exemplo de resultado:**

```
paiN Gaming    | 28 | 45 | 62.22%
LOUD           | 26 | 43 | 60.47%
FURIA Esports  | 24 | 44 | 54.55%

```

---

### 2️⃣ Top 10 Jogadores por KDA

Lista os jogadores com melhor KDA (Kill/Death/Assist ratio).

```sql
SELECT
    p.nickname,
    t.team_name,
    p.role,
    COUNT(DISTINCT ps.match_id) as jogos,
    ROUND(AVG(ps.kills), 2) as avg_kills,
    ROUND(AVG(ps.deaths), 2) as avg_deaths,
    ROUND(AVG(ps.assists), 2) as avg_assists,
    ROUND((SUM(ps.kills) + SUM(ps.assists)) / NULLIF(SUM(ps.deaths), 0), 2) as kda
FROM players p
JOIN player_stats ps ON p.player_id = ps.player_id
JOIN teams t ON p.team_id = t.team_id
GROUP BY p.nickname, t.team_name, p.role
HAVING COUNT(DISTINCT ps.match_id) >= 5
ORDER BY kda DESC
FETCH FIRST 10 ROWS ONLY;

```

**Exemplo de resultado:**

```
dyNquedo | paiN Gaming | MID | 30 | 5.20 K | 1.80 D | 8.30 A | 7.50 KDA
Tinowns  | LOUD        | MID | 28 | 4.90 K | 2.00 D | 7.80 A | 6.35 KDA

```

---

### 3️⃣ Champions Mais Jogados

Mostra os personagens mais populares e suas estatísticas.

```sql
SELECT
    champion_played,
    COUNT(*) as vezes_jogado,
    ROUND(AVG(kills), 2) as avg_kills,
    ROUND(AVG(deaths), 2) as avg_deaths,
    ROUND(AVG(assists), 2) as avg_assists,
    ROUND((SUM(kills) + SUM(assists)) / NULLIF(SUM(deaths), 0), 2) as kda_total
FROM player_stats
GROUP BY champion_played
ORDER BY vezes_jogado DESC
FETCH FIRST 15 ROWS ONLY;

```

---

### 4️⃣ Comparação Entre Splits

Compara as estatísticas das duas fases do campeonato.

```sql
SELECT
    s.split_name,
    COUNT(DISTINCT m.match_id) as total_partidas,
    ROUND(AVG(m.game_duration)/60, 2) as duracao_media_min,
    ROUND(AVG(ps.kills), 2) as avg_kills_por_jogador,
    ROUND(AVG(ps.gold_earned), 0) as avg_gold
FROM splits s
JOIN matches m ON s.split_id = m.split_id
JOIN player_stats ps ON m.match_id = ps.match_id
GROUP BY s.split_name
ORDER BY s.split_id;

```

---

## 🗺️ Modelo de Dados

### Diagrama ER (Entidade-Relacionamento)

```
┌─────────────┐
│   TEAMS     │
├─────────────┤
│ team_id (PK)│
│ team_name   │
│ team_tag    │
│ region      │
│ founded_year│
└──────┬──────┘
       │
       │ 1:N
       │
┌──────▼──────┐        ┌─────────────┐
│  PLAYERS    │        │   SPLITS    │
├─────────────┤        ├─────────────┤
│ player_id(PK│        │ split_id(PK)│
│ player_name │        │ split_name  │
│ nickname    │        │ season      │
│ role        │        │ start_date  │
│ team_id(FK) │        │ end_date    │
│ nationality │        └──────┬──────┘
└──────┬──────┘               │
       │                      │ 1:N
       │ 1:N                  │
       │              ┌───────▼────────┐
       │              │    MATCHES     │
       │              ├────────────────┤
       │              │ match_id (PK)  │
       │              │ season         │
       │              │ split_id (FK)  │
       │              │ match_date     │
       │              │ week_number    │
       │              │ team_blue_id(FK│
       │              │ team_red_id(FK)│
       │              │ winner_side    │
       │              │ game_duration  │
       │              └───────┬────────┘
       │                      │
       │ N:1                  │ 1:N
       │                      │
       └──────────┬───────────┘
                  │
          ┌───────▼───────┐
          │ PLAYER_STATS  │
          ├───────────────┤
          │ stat_id (PK)  │
          │ match_id (FK) │
          │ player_id(FK) │
          │ side          │
          │ champion_play │
          │ kills         │
          │ deaths        │
          │ assists       │
          │ cs            │
          │ gold_earned   │
          │ damage_dealt  │
          └───────────────┘

```

---

## 💡 Exemplos de Queries

### Encontrar Pentakills (5 kills em uma partida)

```sql
SELECT
    p.nickname,
    t.team_name,
    ps.champion_played,
    ps.kills,
    m.match_date
FROM player_stats ps
JOIN players p ON ps.player_id = p.player_id
JOIN teams t ON p.team_id = t.team_id
JOIN matches m ON ps.match_id = m.match_id
WHERE ps.kills >= 5
ORDER BY ps.kills DESC, m.match_date DESC;

```

---

### Melhor Jogador de Cada Posição

```sql
WITH jogador_stats AS (
    SELECT
        p.player_id,
        p.nickname,
        p.role,
        t.team_name,
        ROUND((SUM(ps.kills) + SUM(ps.assists)) / NULLIF(SUM(ps.deaths), 0), 2) as kda,
        COUNT(DISTINCT ps.match_id) as jogos
    FROM players p
    JOIN player_stats ps ON p.player_id = ps.player_id
    JOIN teams t ON p.team_id = t.team_id
    GROUP BY p.player_id, p.nickname, p.role, t.team_name
    HAVING COUNT(DISTINCT ps.match_id) >= 10
),
ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY role ORDER BY kda DESC) as rank
    FROM jogador_stats
)
SELECT nickname, team_name, role, jogos, kda
FROM ranked
WHERE rank = 1
ORDER BY
    CASE role
        WHEN 'TOP' THEN 1
        WHEN 'JG' THEN 2
        WHEN 'MID' THEN 3
        WHEN 'ADC' THEN 4
        WHEN 'SUP' THEN 5
    END;

```

---

### Histórico de Confrontos Entre Dois Times

```sql
SELECT
    m.match_date,
    s.split_name,
    CASE
        WHEN m.team_blue_id = 1 THEN 'BLUE'
        ELSE 'RED'
    END as lado_pain,
    CASE
        WHEN (m.winner_side = 'BLUE' AND m.team_blue_id = 1)
          OR (m.winner_side = 'RED' AND m.team_red_id = 1)
        THEN 'paiN Gaming'
        ELSE 'LOUD'
    END as vencedor,
    ROUND(m.game_duration/60, 1) as duracao_min
FROM matches m
JOIN splits s ON m.split_id = s.split_id
WHERE (m.team_blue_id = 1 AND m.team_red_id = 2)
   OR (m.team_blue_id = 2 AND m.team_red_id = 1)
ORDER BY m.match_date;

```

---

### Média de CS por Posição

```sql
SELECT
    p.role,
    ROUND(AVG(ps.cs), 1) as avg_cs,
    ROUND(MIN(ps.cs), 0) as min_cs,
    ROUND(MAX(ps.cs), 0) as max_cs,
    ROUND(STDDEV(ps.cs), 1) as desvio_padrao
FROM player_stats ps
JOIN players p ON ps.player_id = p.player_id
GROUP BY p.role
ORDER BY avg_cs DESC;

```

---

## 📈 Análises Avançadas

### Desempenho por Lado (Azul vs Vermelho)

```sql
SELECT
    ps.side,
    COUNT(*) as jogos,
    ROUND(AVG(ps.kills), 2) as avg_kills,
    ROUND(AVG(ps.deaths), 2) as avg_deaths,
    ROUND(AVG(ps.assists), 2) as avg_assists,
    ROUND(AVG(ps.gold_earned), 0) as avg_gold
FROM player_stats ps
GROUP BY ps.side;

```

---

### Champions com Melhor Winrate (mínimo 5 jogos)

```sql
WITH champion_performance AS (
    SELECT
        ps.champion_played,
        COUNT(*) as total_jogos,
        COUNT(CASE
            WHEN (ps.side = 'BLUE' AND m.winner_side = 'BLUE')
              OR (ps.side = 'RED' AND m.winner_side = 'RED')
            THEN 1
        END) as vitorias
    FROM player_stats ps
    JOIN matches m ON ps.match_id = m.match_id
    GROUP BY ps.champion_played
    HAVING COUNT(*) >= 5
)
SELECT
    champion_played,
    total_jogos,
    vitorias,
    ROUND(vitorias * 100.0 / total_jogos, 2) as winrate
FROM champion_performance
ORDER BY winrate DESC, total_jogos DESC;

```

---

## 🔍 Troubleshooting

### Problema: Erro "table or view does not exist"

**Solução:** Verifique se você está conectado com o usuário correto e se o script foi executado completamente.

```sql
-- Verifica o usuário atual
SELECT USER FROM DUAL;

-- Lista todas as tabelas do usuário
SELECT table_name FROM user_tables;

```

---

### Problema: Dados não aparecem nas consultas

**Solução:** Verifique se o COMMIT foi executado após a inserção dos dados.

```sql
-- Execute um commit manual
COMMIT;

-- Depois verifique novamente
SELECT COUNT(*) FROM matches;

```

---

### Problema: Erro "insufficient privileges"

**Solução:** Seu usuário precisa de privilégios para criar objetos.

```sql
-- Execute como DBA ou usuário com privilégios
GRANT CREATE TABLE TO seu_usuario;
GRANT CREATE INDEX TO seu_usuario;

```

---

## 🤝 Contribuindo

Contribuições são bem-vindas! Siga estas etapas:

1. **Fork** o projeto
2. Crie uma **branch** para sua feature (`git checkout -b feature/AmazingFeature`)
3. **Commit** suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. **Push** para a branch (`git push origin feature/AmazingFeature`)
5. Abra um **Pull Request**

### Ideias para Contribuição

- ✨ Adicionar mais times/jogadores
- 📊 Criar views materializadas para performance
- 🎮 Adicionar tabela de bans (personagens banidos)
- 🏆 Sistema de playoffs e finais
- 📈 Dashboards com estatísticas visuais
- 🔄 Triggers para atualização automática de estatísticas
- 📝 Procedures para relatórios complexos

---

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

---

## 👥 Autores

- David Mertens - *Primeiro projeto* - [GitHub](https://github.com/sunny1est)

---

## 🙏 Agradecimentos

- Riot Games pelo League of Legends
- CBLOL pela competição inspiradora
- Comunidade de e-sports brasileira
- Times e jogadores do CBLOL 2023

---

## 📞 Contato

- **GitHub Issues:** [Reporte bugs ou sugira features](https://github.com/Sunny1est/CBLOL-DB-2024/issues)
- **Email:** david.mertens.prof@gmail.com
- **LinkedIn:** [Seu LinkedIn](https://www.linkedin.com/in/david-mertens-7775ab318/)

---

## 📚 Recursos Adicionais

### Documentação

- [Oracle SQL Reference](https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/)
- [PL/SQL User's Guide](https://docs.oracle.com/en/database/oracle/oracle-database/19/lnpls/)
- [League of Legends Wiki](https://leagueoflegends.fandom.com/)

### Tutoriais Relacionados

- SQL para Análise de Dados
- Modelagem de Banco de Dados
- PL/SQL Avançado

---

## ⭐ Estatísticas do Projeto

[GitHub stars](https://img.shields.io/github/stars/seu-usuario/cblol-database?style=social)

[GitHub forks](https://img.shields.io/github/forks/seu-usuario/cblol-database?style=social)

[GitHub issues](https://img.shields.io/github/issues/seu-usuario/cblol-database)

---

**Desenvolvido com ❤️ e ☕ para a comunidade de e-sports brasileira**

*League of Legends e CBLOL são marcas registradas da Riot Games. Este projeto não é afiliado oficialmente.*

[cblol_2023_system.sql](attachment:1cb74a9f-c09a-4b60-939e-566e638fce66:cblol_2023_system.sql)

```sql
- =====================================================
-- SISTEMA COMPLETO DE BANCO DE DADOS CBLOL 2023
-- Baseado nos times e jogadores reais da competição
-- =====================================================
```

```sql
- 1) DROP de tabelas (se existirem)
BEGIN
EXECUTE IMMEDIATE 'DROP TABLE player_stats CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
EXECUTE IMMEDIATE 'DROP TABLE matches CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
EXECUTE IMMEDIATE 'DROP TABLE players CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
EXECUTE IMMEDIATE 'DROP TABLE splits CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
EXECUTE IMMEDIATE 'DROP TABLE teams CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
```

```sql
- =====================================================
-- 2) CRIAÇÃO DAS TABELAS COM MELHORIAS
-- =====================================================
```

```sql
- TABELA TEAMS
CREATE TABLE teams (
team_id NUMBER PRIMARY KEY,
team_name VARCHAR2(100) NOT NULL UNIQUE,
team_tag VARCHAR2(10) NOT NULL,
region VARCHAR2(50) DEFAULT 'Brazil',
founded_year NUMBER
);
```

```sql
- TABELA SPLITS
CREATE TABLE splits (
split_id NUMBER PRIMARY KEY,
split_name VARCHAR2(100) NOT NULL,
season NUMBER NOT NULL,
start_date DATE,
end_date DATE
);
```

```sql
- TABELA PLAYERS
CREATE TABLE players (
player_id NUMBER PRIMARY KEY,
player_name VARCHAR2(100) NOT NULL,
nickname VARCHAR2(50) NOT NULL,
role VARCHAR2(20) NOT NULL CHECK (role IN ('TOP', 'JG', 'MID', 'ADC', 'SUP')),
team_id NUMBER NOT NULL,
nationality VARCHAR2(50) DEFAULT 'Brazil',
CONSTRAINT fk_player_team FOREIGN KEY (team_id) REFERENCES teams(team_id)
);
```

```sql
- TABELA MATCHES
CREATE TABLE matches (
match_id NUMBER PRIMARY KEY,
season NUMBER NOT NULL,
split_id NUMBER NOT NULL,
match_date DATE NOT NULL,
week_number NUMBER,
team_blue_id NUMBER NOT NULL,
team_red_id NUMBER NOT NULL,
winner_side VARCHAR2(4) CHECK (winner_side IN ('BLUE','RED')),
game_duration NUMBER, -- duração em segundos
CONSTRAINT fk_match_team_blue FOREIGN KEY (team_blue_id) REFERENCES teams(team_id),
CONSTRAINT fk_match_team_red FOREIGN KEY (team_red_id) REFERENCES teams(team_id),
CONSTRAINT fk_match_split FOREIGN KEY (split_id) REFERENCES splits(split_id),
CONSTRAINT chk_different_teams CHECK (team_blue_id != team_red_id)
);
```

```sql
- TABELA PLAYER_STATS
CREATE TABLE player_stats (
stat_id NUMBER PRIMARY KEY,
match_id NUMBER NOT NULL,
player_id NUMBER NOT NULL,
side VARCHAR2(4) CHECK (side IN ('BLUE','RED')),
champion_played VARCHAR2(60) NOT NULL,
kills NUMBER DEFAULT 0 CHECK (kills >= 0),
deaths NUMBER DEFAULT 0 CHECK (deaths >= 0),
assists NUMBER DEFAULT 0 CHECK (assists >= 0),
cs NUMBER DEFAULT 0, -- creep score
gold_earned NUMBER DEFAULT 0,
damage_dealt NUMBER DEFAULT 0,
CONSTRAINT fk_ps_match FOREIGN KEY (match_id) REFERENCES matches(match_id),
CONSTRAINT fk_ps_player FOREIGN KEY (player_id) REFERENCES players(player_id)
);
```

```sql
- Índices para melhorar performance
CREATE INDEX idx_matches_date ON matches(match_date);
CREATE INDEX idx_matches_split ON matches(split_id);
CREATE INDEX idx_player_stats_player ON player_stats(player_id);
CREATE INDEX idx_player_stats_match ON player_stats(match_id);
```

```sql
COMMIT;
```

```sql
- =====================================================
-- 3) POPULAÇÃO COM TIMES REAIS DO CBLOL 2023
-- =====================================================
```

```sql
- Times do CBLOL 2023
INSERT INTO teams VALUES (1, 'paiN Gaming', 'PNG', 'Brazil', 2010);
INSERT INTO teams VALUES (2, 'LOUD', 'LLL', 'Brazil', 2020);
INSERT INTO teams VALUES (3, 'FURIA Esports', 'FUR', 'Brazil', 2017);
INSERT INTO teams VALUES (4, 'INTZ', 'INTZ', 'Brazil', 2014);
INSERT INTO teams VALUES (5, 'Red Canids', 'RED', 'Brazil', 2015);
INSERT INTO teams VALUES (6, 'Fluxo', 'FLX', 'Brazil', 2021);
INSERT INTO teams VALUES (7, 'KaBuM! Esports', 'KBM', 'Brazil', 2012);
INSERT INTO teams VALUES (8, 'Vivo Keyd Stars', 'VKS', 'Brazil', 2019);
INSERT INTO teams VALUES (9, 'Los Grandes', 'LG', 'Brazil', 2022);
INSERT INTO teams VALUES (10, 'Liberty', 'LBR', 'Brazil', 2022);
```

```sql
- Splits 2023
INSERT INTO splits VALUES (1, 'Split 1 - 2023', 2023, DATE '2023-01-14', DATE '2023-04-02');
INSERT INTO splits VALUES (2, 'Split 2 - 2023', 2023, DATE '2023-06-10', DATE '2023-09-03');
```

```sql
COMMIT;
```

```sql
- =====================================================
-- 4) POPULAÇÃO COM JOGADORES REAIS (exemplos)
-- =====================================================
```

```sql
- paiN Gaming (IDs 1-5)
INSERT INTO players VALUES (1, 'Wizer', 'Wizer', 'TOP', 1, 'Brazil');
INSERT INTO players VALUES (2, 'CarioK', 'CarioK', 'JG', 1, 'Brazil');
INSERT INTO players VALUES (3, 'dyNquedo', 'dyNquedo', 'MID', 1, 'Brazil');
INSERT INTO players VALUES (4, 'TitaN', 'TitaN', 'ADC', 1, 'Brazil');
INSERT INTO players VALUES (5, 'Kuri', 'Kuri', 'SUP', 1, 'Brazil');
```

```sql
- LOUD (IDs 6-10)
INSERT INTO players VALUES (6, 'Robo', 'Robo', 'TOP', 2, 'Brazil');
INSERT INTO players VALUES (7, 'Croc', 'Croc', 'JG', 2, 'Brazil');
INSERT INTO players VALUES (8, 'Tinowns', 'Tinowns', 'MID', 2, 'Brazil');
INSERT INTO players VALUES (9, 'Route', 'Route', 'ADC', 2, 'Brazil');
INSERT INTO players VALUES (10, 'Ceos', 'Ceos', 'SUP', 2, 'Brazil');
```

```sql
- FURIA (IDs 11-15)
INSERT INTO players VALUES (11, 'Ayel', 'Ayel', 'TOP', 3, 'Brazil');
INSERT INTO players VALUES (12, 'Goot', 'Goot', 'JG', 3, 'Brazil');
INSERT INTO players VALUES (13, 'Lucid', 'Lucid', 'MID', 3, 'Brazil');
INSERT INTO players VALUES (14, 'Brance', 'Brance', 'ADC', 3, 'Brazil');
INSERT INTO players VALUES (15, 'Jojo', 'Jojo', 'SUP', 3, 'Brazil');
```

```sql
- INTZ (IDs 16-20)
INSERT INTO players VALUES (16, 'Tay', 'Tay', 'TOP', 4, 'Brazil');
INSERT INTO players VALUES (17, 'Ranger', 'Ranger', 'JG', 4, 'Brazil');
INSERT INTO players VALUES (18, 'Hauz', 'Hauz', 'MID', 4, 'Brazil');
INSERT INTO players VALUES (19, 'Damage', 'Damage', 'ADC', 4, 'Brazil');
INSERT INTO players VALUES (20, 'RedBert', 'RedBert', 'SUP', 4, 'Brazil');
```

```sql
- Red Canids (IDs 21-25)
INSERT INTO players VALUES (21, 'Guigo', 'Guigo', 'TOP', 5, 'Brazil');
INSERT INTO players VALUES (22, 'Aegis', 'Aegis', 'JG', 5, 'Brazil');
INSERT INTO players VALUES (23, 'Avenger', 'Avenger', 'MID', 5, 'Brazil');
INSERT INTO players VALUES (24, 'TitaN', 'TitaN (RED)', 'ADC', 5, 'Brazil');
INSERT INTO players VALUES (25, 'Jojo', 'Jojo (RED)', 'SUP', 5, 'Brazil');
```

```sql
- Fluxo (IDs 26-30)
INSERT INTO players VALUES (26, 'Yggor', 'Yggor', 'TOP', 6, 'Brazil');
INSERT INTO players VALUES (27, 'Goot', 'Goot (FLX)', 'JG', 6, 'Brazil');
INSERT INTO players VALUES (28, 'Envy', 'Envy', 'MID', 6, 'Brazil');
INSERT INTO players VALUES (29, 'Trigo', 'Trigo', 'ADC', 6, 'Brazil');
INSERT INTO players VALUES (30, 'Jojo', 'Jojo (FLX)', 'SUP', 6, 'Brazil');
```

```sql
- KaBuM! (IDs 31-35)
INSERT INTO players VALUES (31, 'Zantins', 'Zantins', 'TOP', 7, 'Brazil');
INSERT INTO players VALUES (32, 'Minerva', 'Minerva', 'JG', 7, 'Brazil');
INSERT INTO players VALUES (33, 'Hauz', 'Hauz (KBM)', 'MID', 7, 'Brazil');
INSERT INTO players VALUES (34, 'Brance', 'Brance (KBM)', 'ADC', 7, 'Brazil');
INSERT INTO players VALUES (35, 'Leonne', 'Leonne', 'SUP', 7, 'Brazil');
```

```sql
- Vivo Keyd (IDs 36-40)
INSERT INTO players VALUES (36, 'Kiari', 'Kiari', 'TOP', 8, 'Brazil');
INSERT INTO players VALUES (37, 'Catch', 'Catch', 'JG', 8, 'Brazil');
INSERT INTO players VALUES (38, 'Grevthar', 'Grevthar', 'MID', 8, 'Brazil');
INSERT INTO players VALUES (39, 'Specialist', 'Specialist', 'ADC', 8, 'Brazil');
INSERT INTO players VALUES (40, 'Kuri', 'Kuri (VKS)', 'SUP', 8, 'Brazil');
```

```sql
- Los Grandes (IDs 41-45)
INSERT INTO players VALUES (41, 'Ackerman', 'Ackerman', 'TOP', 9, 'Brazil');
INSERT INTO players VALUES (42, 'Primal', 'Primal', 'JG', 9, 'Brazil');
INSERT INTO players VALUES (43, 'Pask', 'Pask', 'MID', 9, 'Brazil');
INSERT INTO players VALUES (44, 'Brance', 'Brance (LG)', 'ADC', 9, 'Brazil');
INSERT INTO players VALUES (45, 'Cris', 'Cris', 'SUP', 9, 'Brazil');
```

```sql
- Liberty (IDs 46-50)
INSERT INTO players VALUES (46, 'Bia', 'Bia', 'TOP', 10, 'Brazil');
INSERT INTO players VALUES (47, 'Kobra', 'Kobra', 'JG', 10, 'Brazil');
INSERT INTO players VALUES (48, 'Shiida', 'Shiida', 'MID', 10, 'Brazil');
INSERT INTO players VALUES (49, 'Jullia', 'Jullia', 'ADC', 10, 'Brazil');
INSERT INTO players VALUES (50, 'Juli', 'Juli', 'SUP', 10, 'Brazil');
```

```sql
COMMIT;
```

```sql
- =====================================================
-- 5) GERAÇÃO DE PARTIDAS REALISTAS (90 partidas)
-- =====================================================
```

```sql
DECLARE
t1 NUMBER;
t2 NUMBER;
i  NUMBER;
dt DATE;
winner VARCHAR2(4);
duration NUMBER;
week_num NUMBER;
current_split NUMBER;
BEGIN
i := 1;
```

```sql
-- Split 1: 45 partidas
FOR match_num IN 1..45 LOOP
    -- Seleciona dois times diferentes
    t1 := TRUNC(DBMS_RANDOM.VALUE(1, 11));
    LOOP
        t2 := TRUNC(DBMS_RANDOM.VALUE(1, 11));
        EXIT WHEN t2 != t1;
    END LOOP;

    -- Data entre Jan e Março 2023
    dt := DATE '2023-01-14' + TRUNC(DBMS_RANDOM.VALUE(0, 78));
    week_num := TRUNC((dt - DATE '2023-01-14') / 7) + 1;

    -- Winner (favorece times top: 1-paiN, 2-LOUD, 3-FURIA)
    IF t1 <= 3 OR t2 > 3 THEN
        winner := CASE WHEN DBMS_RANDOM.VALUE < 0.6 THEN 'BLUE' ELSE 'RED' END;
    ELSE
        winner := CASE WHEN DBMS_RANDOM.VALUE < 0.5 THEN 'BLUE' ELSE 'RED' END;
    END IF;

    -- Duração entre 25-45 minutos (1500-2700 segundos)
    duration := TRUNC(DBMS_RANDOM.VALUE(1500, 2700));

    INSERT INTO matches (match_id, season, split_id, match_date, week_number,
                        team_blue_id, team_red_id, winner_side, game_duration)
    VALUES (i, 2023, 1, dt, week_num, t1, t2, winner, duration);

    i := i + 1;
END LOOP;

-- Split 2: 45 partidas
FOR match_num IN 1..45 LOOP
    t1 := TRUNC(DBMS_RANDOM.VALUE(1, 11));
    LOOP
        t2 := TRUNC(DBMS_RANDOM.VALUE(1, 11));
        EXIT WHEN t2 != t1;
    END LOOP;

    dt := DATE '2023-06-10' + TRUNC(DBMS_RANDOM.VALUE(0, 85));
    week_num := TRUNC((dt - DATE '2023-06-10') / 7) + 1;

    IF t1 <= 3 OR t2 > 3 THEN
        winner := CASE WHEN DBMS_RANDOM.VALUE < 0.6 THEN 'BLUE' ELSE 'RED' END;
    ELSE
        winner := CASE WHEN DBMS_RANDOM.VALUE < 0.5 THEN 'BLUE' ELSE 'RED' END;
    END IF;

    duration := TRUNC(DBMS_RANDOM.VALUE(1500, 2700));

    INSERT INTO matches (match_id, season, split_id, match_date, week_number,
                        team_blue_id, team_red_id, winner_side, game_duration)
    VALUES (i, 2023, 2, dt, week_num, t1, t2, winner, duration);

    i := i + 1;
END LOOP;

COMMIT;

```

```sql
END;
/
```

```sql
- =====================================================
-- 6) GERAÇÃO DE ESTATÍSTICAS REALISTAS DOS JOGADORES
-- =====================================================
```

```sql
DECLARE
stat_id NUMBER := 1;
m_id   NUMBER;
blue_team NUMBER;
red_team  NUMBER;
winner VARCHAR2(4);
p_id NUMBER;
p_role VARCHAR2(20);
k NUMBER; d NUMBER; a NUMBER;
cs_val NUMBER;
gold_val NUMBER;
dmg_val NUMBER;
```

```sql
-- Champions populares por role
TYPE champion_array IS VARRAY(50) OF VARCHAR2(60);
top_champs champion_array := champion_array('Aatrox','Gnar','Camille','Jax','K''Sante','Renekton','Ornn','Jayce');
jg_champs champion_array := champion_array('Lee Sin','Vi','Jarvan IV','Sejuani','Maokai','Wukong','Viego','Elise');
mid_champs champion_array := champion_array('Ahri','Azir','Orianna','Syndra','Viktor','LeBlanc','Sylas','Taliyah');
adc_champs champion_array := champion_array('Jinx','Aphelios','Xayah','KaiSa','Ezreal','Lucian','Miss Fortune','Varus');
sup_champs champion_array := champion_array('Thresh','Nautilus','Leona','Rakan','Renata','Lulu','Yuumi','Braum');

selected_champ VARCHAR2(60);

```

```sql
BEGIN
FOR rec IN (SELECT match_id, team_blue_id, team_red_id, winner_side
FROM matches ORDER BY match_id) LOOP
m_id := rec.match_id;
blue_team := rec.team_blue_id;
red_team := rec.team_red_id;
winner := rec.winner_side;
```

```sql
    -- Jogadores do time AZUL
    FOR j IN 0..4 LOOP
        p_id := (blue_team - 1) * 5 + 1 + j;

        SELECT role INTO p_role FROM players WHERE player_id = p_id;

        -- Seleciona champion baseado na role
        CASE p_role
            WHEN 'TOP' THEN selected_champ := top_champs(TRUNC(DBMS_RANDOM.VALUE(1, 9)));
            WHEN 'JG' THEN selected_champ := jg_champs(TRUNC(DBMS_RANDOM.VALUE(1, 9)));
            WHEN 'MID' THEN selected_champ := mid_champs(TRUNC(DBMS_RANDOM.VALUE(1, 9)));
            WHEN 'ADC' THEN selected_champ := adc_champs(TRUNC(DBMS_RANDOM.VALUE(1, 9)));
            WHEN 'SUP' THEN selected_champ := sup_champs(TRUNC(DBMS_RANDOM.VALUE(1, 9)));
        END CASE;

        -- Stats realistas baseadas em vitória/derrota e role
        IF winner = 'BLUE' THEN
            k := TRUNC(DBMS_RANDOM.VALUE(2, 10));
            d := TRUNC(DBMS_RANDOM.VALUE(0, 4));
            a := TRUNC(DBMS_RANDOM.VALUE(3, 15));
        ELSE
            k := TRUNC(DBMS_RANDOM.VALUE(0, 6));
            d := TRUNC(DBMS_RANDOM.VALUE(2, 8));
            a := TRUNC(DBMS_RANDOM.VALUE(1, 10));
        END IF;

        -- CS e Gold variam por role
        IF p_role IN ('TOP', 'MID', 'ADC') THEN
            cs_val := TRUNC(DBMS_RANDOM.VALUE(180, 320));
            gold_val := TRUNC(DBMS_RANDOM.VALUE(9000, 15000));
        ELSIF p_role = 'JG' THEN
            cs_val := TRUNC(DBMS_RANDOM.VALUE(100, 180));
            gold_val := TRUNC(DBMS_RANDOM.VALUE(7000, 12000));
        ELSE -- SUP
            cs_val := TRUNC(DBMS_RANDOM.VALUE(20, 60));
            gold_val := TRUNC(DBMS_RANDOM.VALUE(5000, 9000));
        END IF;

        dmg_val := TRUNC(DBMS_RANDOM.VALUE(8000, 35000));

        INSERT INTO player_stats (stat_id, match_id, player_id, side, champion_played,
                                 kills, deaths, assists, cs, gold_earned, damage_dealt)
        VALUES (stat_id, m_id, p_id, 'BLUE', selected_champ, k, d, a, cs_val, gold_val, dmg_val);
        stat_id := stat_id + 1;
    END LOOP;

    -- Jogadores do time VERMELHO
    FOR j IN 0..4 LOOP
        p_id := (red_team - 1) * 5 + 1 + j;

        SELECT role INTO p_role FROM players WHERE player_id = p_id;

        CASE p_role
            WHEN 'TOP' THEN selected_champ := top_champs(TRUNC(DBMS_RANDOM.VALUE(1, 9)));
            WHEN 'JG' THEN selected_champ := jg_champs(TRUNC(DBMS_RANDOM.VALUE(1, 9)));
            WHEN 'MID' THEN selected_champ := mid_champs(TRUNC(DBMS_RANDOM.VALUE(1, 9)));
            WHEN 'ADC' THEN selected_champ := adc_champs(TRUNC(DBMS_RANDOM.VALUE(1, 9)));
            WHEN 'SUP' THEN selected_champ := sup_champs(TRUNC(DBMS_RANDOM.VALUE(1, 9)));
        END CASE;

        IF winner = 'RED' THEN
            k := TRUNC(DBMS_RANDOM.VALUE(2, 10));
            d := TRUNC(DBMS_RANDOM.VALUE(0, 4));
            a := TRUNC(DBMS_RANDOM.VALUE(3, 15));
        ELSE
            k := TRUNC(DBMS_RANDOM.VALUE(0, 6));
            d := TRUNC(DBMS_RANDOM.VALUE(2, 8));
            a := TRUNC(DBMS_RANDOM.VALUE(1, 10));
        END IF;

        IF p_role IN ('TOP', 'MID', 'ADC') THEN
            cs_val := TRUNC(DBMS_RANDOM.VALUE(180, 320));
            gold_val := TRUNC(DBMS_RANDOM.VALUE(9000, 15000));
        ELSIF p_role = 'JG' THEN
            cs_val := TRUNC(DBMS_RANDOM.VALUE(100, 180));
            gold_val := TRUNC(DBMS_RANDOM.VALUE(7000, 12000));
        ELSE
            cs_val := TRUNC(DBMS_RANDOM.VALUE(20, 60));
            gold_val := TRUNC(DBMS_RANDOM.VALUE(5000, 9000));
        END IF;

        dmg_val := TRUNC(DBMS_RANDOM.VALUE(8000, 35000));

        INSERT INTO player_stats (stat_id, match_id, player_id, side, champion_played,
                                 kills, deaths, assists, cs, gold_earned, damage_dealt)
        VALUES (stat_id, m_id, p_id, 'RED', selected_champ, k, d, a, cs_val, gold_val, dmg_val);
        stat_id := stat_id + 1;
    END LOOP;
END LOOP;

COMMIT;

```

```sql
END;
/
```

```sql
- =====================================================
-- 7) CONSULTAS ÚTEIS E ESTATÍSTICAS (CORRIGIDAS)
-- =====================================================
```

```sql
- Ranking de times por vitórias
SELECT
t.team_name,
COUNT(CASE WHEN (m.winner_side = 'BLUE' AND m.team_blue_id = t.team_id)
OR (m.winner_side = 'RED' AND m.team_red_id = t.team_id)
THEN 1 END) as vitorias,
COUNT(*) as total_jogos,
ROUND(COUNT(CASE WHEN (m.winner_side = 'BLUE' AND m.team_blue_id = t.team_id)
OR (m.winner_side = 'RED' AND m.team_red_id = t.team_id)
THEN 1 END) * 100.0 / COUNT(*), 2) as winrate
FROM teams t
JOIN matches m ON t.team_id IN (m.team_blue_id, m.team_red_id)
GROUP BY t.team_name, t.team_id
ORDER BY vitorias DESC;
```

```sql
- Top 10 jogadores por KDA (CORRIGIDO)
SELECT
p.nickname,
t.team_name,
p.role,
COUNT(DISTINCT ps.match_id) as jogos,
ROUND(AVG(ps.kills), 2) as avg_kills,
ROUND(AVG(ps.deaths), 2) as avg_deaths,
ROUND(AVG(ps.assists), 2) as avg_assists,
ROUND((SUM(ps.kills) + SUM(ps.assists)) / NULLIF(SUM(ps.deaths), 0), 2) as kda
FROM players p
JOIN player_stats ps ON p.player_id = ps.player_id
JOIN teams t ON p.team_id = t.team_id
GROUP BY p.player_id, p.nickname, t.team_name, p.role
HAVING COUNT(DISTINCT ps.match_id) >= 5
ORDER BY kda DESC
FETCH FIRST 10 ROWS ONLY;
```

```sql
- Champions mais jogados
SELECT
champion_played,
COUNT(*) as vezes_jogado,
ROUND(AVG(kills), 2) as avg_kills,
ROUND(AVG(deaths), 2) as avg_deaths,
ROUND(AVG(assists), 2) as avg_assists
FROM player_stats
GROUP BY champion_played
ORDER BY vezes_jogado DESC
FETCH FIRST 15 ROWS ONLY;
```

```sql
- Estatísticas por Split (CORRIGIDO)
SELECT
s.split_name,
COUNT(DISTINCT m.match_id) as total_partidas,
ROUND(AVG(m.game_duration)/60, 2) as duracao_media_min,
ROUND(AVG(ps.kills), 2) as avg_kills_por_jogador,
ROUND(AVG(ps.gold_earned), 0) as avg_gold
FROM splits s
JOIN matches m ON s.split_id = m.split_id
JOIN player_stats ps ON m.match_id = ps.match_id
GROUP BY s.split_id, s.split_name
ORDER BY s.split_id;
```

```sql
COMMIT;
```

```sql
```

[EXPLICAÇÃO DO CÓDIGO](https://www.notion.so/EXPLICA-O-DO-C-DIGO-2ca6b3e9c6c780858f26d9abeff3c297?pvs=21)
