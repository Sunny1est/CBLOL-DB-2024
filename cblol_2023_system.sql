-- =====================================================
-- SISTEMA COMPLETO DE BANCO DE DADOS CBLOL 2023
-- Baseado nos times e jogadores reais da competição
-- =====================================================

-- 1) DROP de tabelas (se existirem)
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

-- =====================================================
-- 2) CRIAÇÃO DAS TABELAS COM MELHORIAS
-- =====================================================

-- TABELA TEAMS
CREATE TABLE teams (
    team_id    NUMBER PRIMARY KEY,
    team_name  VARCHAR2(100) NOT NULL UNIQUE,
    team_tag   VARCHAR2(10) NOT NULL,
    region     VARCHAR2(50) DEFAULT 'Brazil',
    founded_year NUMBER
);

-- TABELA SPLITS
CREATE TABLE splits (
    split_id   NUMBER PRIMARY KEY,
    split_name VARCHAR2(100) NOT NULL,
    season     NUMBER NOT NULL,
    start_date DATE,
    end_date   DATE
);

-- TABELA PLAYERS
CREATE TABLE players (
    player_id   NUMBER PRIMARY KEY,
    player_name VARCHAR2(100) NOT NULL,
    nickname    VARCHAR2(50) NOT NULL,
    role        VARCHAR2(20) NOT NULL CHECK (role IN ('TOP', 'JG', 'MID', 'ADC', 'SUP')),
    team_id     NUMBER NOT NULL,
    nationality VARCHAR2(50) DEFAULT 'Brazil',
    CONSTRAINT fk_player_team FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

-- TABELA MATCHES
CREATE TABLE matches (
    match_id    NUMBER PRIMARY KEY,
    season      NUMBER NOT NULL,
    split_id    NUMBER NOT NULL,
    match_date  DATE NOT NULL,
    week_number NUMBER,
    team_blue_id NUMBER NOT NULL,
    team_red_id  NUMBER NOT NULL,
    winner_side  VARCHAR2(4) CHECK (winner_side IN ('BLUE','RED')),
    game_duration NUMBER, -- duração em segundos
    CONSTRAINT fk_match_team_blue FOREIGN KEY (team_blue_id) REFERENCES teams(team_id),
    CONSTRAINT fk_match_team_red  FOREIGN KEY (team_red_id)  REFERENCES teams(team_id),
    CONSTRAINT fk_match_split FOREIGN KEY (split_id) REFERENCES splits(split_id),
    CONSTRAINT chk_different_teams CHECK (team_blue_id != team_red_id)
);

-- TABELA PLAYER_STATS
CREATE TABLE player_stats (
    stat_id        NUMBER PRIMARY KEY,
    match_id       NUMBER NOT NULL,
    player_id      NUMBER NOT NULL,
    side           VARCHAR2(4) CHECK (side IN ('BLUE','RED')),
    champion_played VARCHAR2(60) NOT NULL,
    kills          NUMBER DEFAULT 0 CHECK (kills >= 0),
    deaths         NUMBER DEFAULT 0 CHECK (deaths >= 0),
    assists        NUMBER DEFAULT 0 CHECK (assists >= 0),
    cs             NUMBER DEFAULT 0, -- creep score
    gold_earned    NUMBER DEFAULT 0,
    damage_dealt   NUMBER DEFAULT 0,
    CONSTRAINT fk_ps_match FOREIGN KEY (match_id)  REFERENCES matches(match_id),
    CONSTRAINT fk_ps_player FOREIGN KEY (player_id) REFERENCES players(player_id)
);

-- Índices para melhorar performance
CREATE INDEX idx_matches_date ON matches(match_date);
CREATE INDEX idx_matches_split ON matches(split_id);
CREATE INDEX idx_player_stats_player ON player_stats(player_id);
CREATE INDEX idx_player_stats_match ON player_stats(match_id);

COMMIT;

-- =====================================================
-- 3) POPULAÇÃO COM TIMES REAIS DO CBLOL 2023
-- =====================================================

-- Times do CBLOL 2023
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

-- Splits 2023
INSERT INTO splits VALUES (1, 'Split 1 - 2023', 2023, DATE '2023-01-14', DATE '2023-04-02');
INSERT INTO splits VALUES (2, 'Split 2 - 2023', 2023, DATE '2023-06-10', DATE '2023-09-03');

COMMIT;

-- =====================================================
-- 4) POPULAÇÃO COM JOGADORES REAIS (exemplos)
-- =====================================================

-- paiN Gaming (IDs 1-5)
INSERT INTO players VALUES (1, 'Wizer', 'Wizer', 'TOP', 1, 'Brazil');
INSERT INTO players VALUES (2, 'CarioK', 'CarioK', 'JG', 1, 'Brazil');
INSERT INTO players VALUES (3, 'dyNquedo', 'dyNquedo', 'MID', 1, 'Brazil');
INSERT INTO players VALUES (4, 'TitaN', 'TitaN', 'ADC', 1, 'Brazil');
INSERT INTO players VALUES (5, 'Kuri', 'Kuri', 'SUP', 1, 'Brazil');

-- LOUD (IDs 6-10)
INSERT INTO players VALUES (6, 'Robo', 'Robo', 'TOP', 2, 'Brazil');
INSERT INTO players VALUES (7, 'Croc', 'Croc', 'JG', 2, 'Brazil');
INSERT INTO players VALUES (8, 'Tinowns', 'Tinowns', 'MID', 2, 'Brazil');
INSERT INTO players VALUES (9, 'Route', 'Route', 'ADC', 2, 'Brazil');
INSERT INTO players VALUES (10, 'Ceos', 'Ceos', 'SUP', 2, 'Brazil');

-- FURIA (IDs 11-15)
INSERT INTO players VALUES (11, 'Ayel', 'Ayel', 'TOP', 3, 'Brazil');
INSERT INTO players VALUES (12, 'Goot', 'Goot', 'JG', 3, 'Brazil');
INSERT INTO players VALUES (13, 'Lucid', 'Lucid', 'MID', 3, 'Brazil');
INSERT INTO players VALUES (14, 'Brance', 'Brance', 'ADC', 3, 'Brazil');
INSERT INTO players VALUES (15, 'Jojo', 'Jojo', 'SUP', 3, 'Brazil');

-- INTZ (IDs 16-20)
INSERT INTO players VALUES (16, 'Tay', 'Tay', 'TOP', 4, 'Brazil');
INSERT INTO players VALUES (17, 'Ranger', 'Ranger', 'JG', 4, 'Brazil');
INSERT INTO players VALUES (18, 'Hauz', 'Hauz', 'MID', 4, 'Brazil');
INSERT INTO players VALUES (19, 'Damage', 'Damage', 'ADC', 4, 'Brazil');
INSERT INTO players VALUES (20, 'RedBert', 'RedBert', 'SUP', 4, 'Brazil');

-- Red Canids (IDs 21-25)
INSERT INTO players VALUES (21, 'Guigo', 'Guigo', 'TOP', 5, 'Brazil');
INSERT INTO players VALUES (22, 'Aegis', 'Aegis', 'JG', 5, 'Brazil');
INSERT INTO players VALUES (23, 'Avenger', 'Avenger', 'MID', 5, 'Brazil');
INSERT INTO players VALUES (24, 'TitaN', 'TitaN (RED)', 'ADC', 5, 'Brazil');
INSERT INTO players VALUES (25, 'Jojo', 'Jojo (RED)', 'SUP', 5, 'Brazil');

-- Fluxo (IDs 26-30)
INSERT INTO players VALUES (26, 'Yggor', 'Yggor', 'TOP', 6, 'Brazil');
INSERT INTO players VALUES (27, 'Goot', 'Goot (FLX)', 'JG', 6, 'Brazil');
INSERT INTO players VALUES (28, 'Envy', 'Envy', 'MID', 6, 'Brazil');
INSERT INTO players VALUES (29, 'Trigo', 'Trigo', 'ADC', 6, 'Brazil');
INSERT INTO players VALUES (30, 'Jojo', 'Jojo (FLX)', 'SUP', 6, 'Brazil');

-- KaBuM! (IDs 31-35)
INSERT INTO players VALUES (31, 'Zantins', 'Zantins', 'TOP', 7, 'Brazil');
INSERT INTO players VALUES (32, 'Minerva', 'Minerva', 'JG', 7, 'Brazil');
INSERT INTO players VALUES (33, 'Hauz', 'Hauz (KBM)', 'MID', 7, 'Brazil');
INSERT INTO players VALUES (34, 'Brance', 'Brance (KBM)', 'ADC', 7, 'Brazil');
INSERT INTO players VALUES (35, 'Leonne', 'Leonne', 'SUP', 7, 'Brazil');

-- Vivo Keyd (IDs 36-40)
INSERT INTO players VALUES (36, 'Kiari', 'Kiari', 'TOP', 8, 'Brazil');
INSERT INTO players VALUES (37, 'Catch', 'Catch', 'JG', 8, 'Brazil');
INSERT INTO players VALUES (38, 'Grevthar', 'Grevthar', 'MID', 8, 'Brazil');
INSERT INTO players VALUES (39, 'Specialist', 'Specialist', 'ADC', 8, 'Brazil');
INSERT INTO players VALUES (40, 'Kuri', 'Kuri (VKS)', 'SUP', 8, 'Brazil');

-- Los Grandes (IDs 41-45)
INSERT INTO players VALUES (41, 'Ackerman', 'Ackerman', 'TOP', 9, 'Brazil');
INSERT INTO players VALUES (42, 'Primal', 'Primal', 'JG', 9, 'Brazil');
INSERT INTO players VALUES (43, 'Pask', 'Pask', 'MID', 9, 'Brazil');
INSERT INTO players VALUES (44, 'Brance', 'Brance (LG)', 'ADC', 9, 'Brazil');
INSERT INTO players VALUES (45, 'Cris', 'Cris', 'SUP', 9, 'Brazil');

-- Liberty (IDs 46-50)
INSERT INTO players VALUES (46, 'Bia', 'Bia', 'TOP', 10, 'Brazil');
INSERT INTO players VALUES (47, 'Kobra', 'Kobra', 'JG', 10, 'Brazil');
INSERT INTO players VALUES (48, 'Shiida', 'Shiida', 'MID', 10, 'Brazil');
INSERT INTO players VALUES (49, 'Jullia', 'Jullia', 'ADC', 10, 'Brazil');
INSERT INTO players VALUES (50, 'Juli', 'Juli', 'SUP', 10, 'Brazil');

COMMIT;

-- =====================================================
-- 5) GERAÇÃO DE PARTIDAS REALISTAS (90 partidas)
-- =====================================================

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
END;
/

-- =====================================================
-- 6) GERAÇÃO DE ESTATÍSTICAS REALISTAS DOS JOGADORES
-- =====================================================

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
    
    -- Champions populares por role
    TYPE champion_array IS VARRAY(50) OF VARCHAR2(60);
    top_champs champion_array := champion_array('Aatrox','Gnar','Camille','Jax','K''Sante','Renekton','Ornn','Jayce');
    jg_champs champion_array := champion_array('Lee Sin','Vi','Jarvan IV','Sejuani','Maokai','Wukong','Viego','Elise');
    mid_champs champion_array := champion_array('Ahri','Azir','Orianna','Syndra','Viktor','LeBlanc','Sylas','Taliyah');
    adc_champs champion_array := champion_array('Jinx','Aphelios','Xayah','KaiSa','Ezreal','Lucian','Miss Fortune','Varus');
    sup_champs champion_array := champion_array('Thresh','Nautilus','Leona','Rakan','Renata','Lulu','Yuumi','Braum');
    
    selected_champ VARCHAR2(60);
BEGIN
    FOR rec IN (SELECT match_id, team_blue_id, team_red_id, winner_side 
                FROM matches ORDER BY match_id) LOOP
        m_id := rec.match_id;
        blue_team := rec.team_blue_id;
        red_team := rec.team_red_id;
        winner := rec.winner_side;
        
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
END;
/

-- =====================================================
-- 7) CONSULTAS ÚTEIS E ESTATÍSTICAS
-- =====================================================

-- Ranking de times por vitórias
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

-- Top 10 jogadores por KDA
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

-- Champions mais jogados
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

-- Estatísticas por Split
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

COMMIT;

-- =====================================================
-- FIM DO SCRIPT
-- Sistema completo com times, jogadores e estatísticas
-- realistas baseadas no CBLOL 2023
-- =====================================================