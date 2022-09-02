-- Таблица заказов
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    description TEXT
);

-- Таблица пользователей
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

INSERT INTO "orders" ("id", "user_id", "description") VALUES 
(1, 1, 'Носки'),
(2, 1, 'Яблоко'),
(3, 2, 'Яблоко');

INSERT INTO "users" ("id", "active", "login", "email", "name", "created_at", "updated_at") VALUES 
(1, 'Y', 'admin', 'admin@mail.ru', 'Admin', '2022-08-11 07:58:19', '2022-08-11 07:58:19'),
(2, 'Y', 'manager', 'manager@mail.ru', 'Manager', '2022-08-11 07:58:19', '2022-08-11 07:58:19');
