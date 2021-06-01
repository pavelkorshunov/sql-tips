-- Таблица заказов
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    description TEXT
);

DROP TABLE IF EXISTS users;
DROP TYPE IF EXISTS active;
CREATE TYPE active AS ENUM('Y', 'N');
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    active active,
    login character varying(255) UNIQUE,
    email character varying(255) UNIQUE,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);