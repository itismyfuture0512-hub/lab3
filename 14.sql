-- ============================================
-- ХАБЫ (Hubs)
-- ============================================

CREATE TABLE hub_city (
    city_hk        CHAR(32) PRIMARY KEY,           -- MD5 от бизнес-ключа
    city_bk        VARCHAR(100) NOT NULL UNIQUE,   -- бизнес-ключ (название)
    load_date      TIMESTAMP NOT NULL DEFAULT NOW(),
    record_source  VARCHAR(100) NOT NULL DEFAULT 'manual'
);

CREATE TABLE hub_sport (
    sport_hk       CHAR(32) PRIMARY KEY,
    sport_bk       VARCHAR(100) NOT NULL UNIQUE,
    load_date      TIMESTAMP NOT NULL DEFAULT NOW(),
    record_source  VARCHAR(100) NOT NULL DEFAULT 'manual'
);

CREATE TABLE hub_competition (
    competition_hk CHAR(32) PRIMARY KEY,
    competition_bk VARCHAR(200) NOT NULL UNIQUE,
    load_date      TIMESTAMP NOT NULL DEFAULT NOW(),
    record_source  VARCHAR(100) NOT NULL DEFAULT 'manual'
);

CREATE TABLE hub_athlete (
    athlete_hk     CHAR(32) PRIMARY KEY,
    athlete_bk     VARCHAR(50) NOT NULL UNIQUE,
    load_date      TIMESTAMP NOT NULL DEFAULT NOW(),
    record_source  VARCHAR(100) NOT NULL DEFAULT 'manual'
);

CREATE TABLE hub_team (
    team_hk        CHAR(32) PRIMARY KEY,
    team_bk        VARCHAR(200) NOT NULL UNIQUE,
    load_date      TIMESTAMP NOT NULL DEFAULT NOW(),
    record_source  VARCHAR(100) NOT NULL DEFAULT 'manual'
);

-- ============================================
-- ЛИНКИ (Links)
-- ============================================

CREATE TABLE link_competition_city_sport (
    link_hk         CHAR(32) PRIMARY KEY,
    competition_hk  CHAR(32) NOT NULL REFERENCES hub_competition(competition_hk),
    city_hk         CHAR(32) NOT NULL REFERENCES hub_city(city_hk),
    sport_hk        CHAR(32) NOT NULL REFERENCES hub_sport(sport_hk),
    load_date       TIMESTAMP NOT NULL DEFAULT NOW(),
    record_source   VARCHAR(100) NOT NULL DEFAULT 'manual'
);

CREATE TABLE link_athlete_city (
    link_hk         CHAR(32) PRIMARY KEY,
    athlete_hk      CHAR(32) NOT NULL REFERENCES hub_athlete(athlete_hk),
    city_hk         CHAR(32) NOT NULL REFERENCES hub_city(city_hk),
    load_date       TIMESTAMP NOT NULL DEFAULT NOW(),
    record_source   VARCHAR(100) NOT NULL DEFAULT 'manual'
);

CREATE TABLE link_team_sport (
    link_hk         CHAR(32) PRIMARY KEY,
    team_hk         CHAR(32) NOT NULL REFERENCES hub_team(team_hk),
    sport_hk        CHAR(32) NOT NULL REFERENCES hub_sport(sport_hk),
    load_date       TIMESTAMP NOT NULL DEFAULT NOW(),
    record_source   VARCHAR(100) NOT NULL DEFAULT 'manual'
);

CREATE TABLE link_registration (
    link_hk         CHAR(32) PRIMARY KEY,
    competition_hk  CHAR(32) NOT NULL REFERENCES hub_competition(competition_hk),
    athlete_hk      CHAR(32) NOT NULL REFERENCES hub_athlete(athlete_hk),
    team_hk         CHAR(32) REFERENCES hub_team(team_hk),
    load_date       TIMESTAMP NOT NULL DEFAULT NOW(),
    record_source   VARCHAR(100) NOT NULL DEFAULT 'manual'
);

-- ============================================
-- САТЕЛЛИТЫ (Satellites)
-- ============================================

CREATE TABLE sat_city_details (
    city_hk        CHAR(32) NOT NULL REFERENCES hub_city(city_hk),
    load_date      TIMESTAMP NOT NULL DEFAULT NOW(),
    city_name      VARCHAR(100) NOT NULL,
    record_source  VARCHAR(100) NOT NULL DEFAULT 'manual',
    PRIMARY KEY (city_hk, load_date)
);

CREATE TABLE sat_competition_details (
    competition_hk   CHAR(32) NOT NULL REFERENCES hub_competition(competition_hk),
    load_date        TIMESTAMP NOT NULL DEFAULT NOW(),
    competition_name VARCHAR(200) NOT NULL,
    start_date       DATE NOT NULL,
    end_date         DATE,
    record_source    VARCHAR(100) NOT NULL DEFAULT 'manual',
    PRIMARY KEY (competition_hk, load_date)
);

CREATE TABLE sat_athlete_details (
    athlete_hk     CHAR(32) NOT NULL REFERENCES hub_athlete(athlete_hk),
    load_date      TIMESTAMP NOT NULL DEFAULT NOW(),
    full_name      VARCHAR(200) NOT NULL,
    birth_date     DATE NOT NULL,
    gender         CHAR(1) CHECK (gender IN ('M','F')),
    record_source  VARCHAR(100) NOT NULL DEFAULT 'manual',
    PRIMARY KEY (athlete_hk, load_date)
);

CREATE TABLE sat_team_details (
    team_hk        CHAR(32) NOT NULL REFERENCES hub_team(team_hk),
    load_date      TIMESTAMP NOT NULL DEFAULT NOW(),
    team_name      VARCHAR(200) NOT NULL,
    record_source  VARCHAR(100) NOT NULL DEFAULT 'manual',
    PRIMARY KEY (team_hk, load_date)
);

CREATE TABLE sat_registration_details (
    link_hk           CHAR(32) NOT NULL REFERENCES link_registration(link_hk),
    load_date         TIMESTAMP NOT NULL DEFAULT NOW(),
    registration_date DATE NOT NULL,
    place             INT CHECK (place > 0),
    score             NUMERIC(10,2),
    record_source     VARCHAR(100) NOT NULL DEFAULT 'manual',
    PRIMARY KEY (link_hk, load_date)
);