-- 1. Справочник городов
CREATE TABLE city (
    city_id   SERIAL PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL
);

-- 2. Справочник видов спорта
CREATE TABLE sport (
    sport_id   SERIAL PRIMARY KEY,
    sport_name VARCHAR(100) NOT NULL UNIQUE,
    is_team    BOOLEAN NOT NULL DEFAULT FALSE
);

-- 3. Соревнования
CREATE TABLE competition (
    competition_id   SERIAL PRIMARY KEY,
    competition_name VARCHAR(200) NOT NULL,
    start_date       DATE NOT NULL,
    end_date         DATE,
    city_id          INT NOT NULL REFERENCES city(city_id),
    sport_id         INT NOT NULL REFERENCES sport(sport_id),
    CHECK (end_date IS NULL OR end_date >= start_date)
);

-- 4. Спортсмены
CREATE TABLE athlete (
    athlete_id SERIAL PRIMARY KEY,
    full_name  VARCHAR(200) NOT NULL,
    birth_date DATE NOT NULL,
    gender     CHAR(1) CHECK (gender IN ('M','F')),
    city_id    INT REFERENCES city(city_id)
);

-- 5. Команды
CREATE TABLE team (
    team_id   SERIAL PRIMARY KEY,
    team_name VARCHAR(200) NOT NULL,
    sport_id  INT REFERENCES sport(sport_id)
);

-- 6. Регистрация спортсмена на соревнование (M:N)
CREATE TABLE competition_athlete (
    competition_id    INT NOT NULL REFERENCES competition(competition_id),
    athlete_id        INT NOT NULL REFERENCES athlete(athlete_id),
    team_id           INT REFERENCES team(team_id),
    registration_date DATE NOT NULL DEFAULT CURRENT_DATE,
    PRIMARY KEY (competition_id, athlete_id)
);

-- 7. Результаты
CREATE TABLE result (
    result_id      SERIAL PRIMARY KEY,
    competition_id INT NOT NULL REFERENCES competition(competition_id),
    athlete_id     INT NOT NULL REFERENCES athlete(athlete_id),
    place          INT CHECK (place > 0),
    score          NUMERIC(10,2),
    UNIQUE (competition_id, athlete_id)
);