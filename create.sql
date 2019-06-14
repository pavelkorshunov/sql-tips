/*
 Удаление таблиц если существуют и создание новых
 Удаление не произойдет в данном случае из-за того что есть ограничение по внешнему ключу users_group_id
 В данном случае необходимо сначала удалять таблицу пользователей и только потом таблицу групп пользователей
 Если поменять порядок создания таблиц, то произойдет ошибка из-за того, что внешний ключ создаваться будет по несуществующему полю
 Я оставил так для того, чтобы показать, как создается внешний ключ при создании таблицы
*/
DROP TABLE IF EXISTS users_group;
CREATE TABLE users_group (
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    active ENUM('Y', 'N'),
    login VARCHAR(60) UNIQUE,
    email VARCHAR(60) UNIQUE,
    group_id INT UNSIGNED NOT NULL,
    name VARCHAR(150),
    gender CHAR(1),
    date_create DATETIME,
    CONSTRAINT users_group_id FOREIGN KEY (group_id) REFERENCES users_group (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNSIGNED NOT NULL,
    description TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Добавление новых значений в таблицу. Для добавления отдельных значений в таблицу есть UPDATE
INSERT INTO users_group (id, name) VALUES
(1, 'administrators'),
(2, 'other'),
(3, 'manager');

INSERT INTO users (id, login, active, email, group_id, name, gender, date_create) VALUES
(1, 'admin', 'Y', 'admin@mail.ru', 1, 'Lex', 'M', '2019-03-18 22:15:31'),
(2, 'pavel', 'Y', 'pavel@mail.ru', 2, 'Pavel', 'M', '2019-03-18 22:15:32'),
(3, 'ann', 'Y', 'ann@yandex.ru', 2, 'Ann', 'F', '2019-03-19 22:16:33'),
(4, 'bob', 'Y', 'bob@mail.ru', 2, 'Bob', 'M', '2019-03-19 22:16:33');

-- Добавление единичного значения
INSERT INTO orders (id, user_id, description) VALUE
(1, 4, 'Хочу купить велосипед и байк');

INSERT INTO orders (id, user_id, description) VALUES
(2, 3, 'Скороварка'),
(3, 3, 'Чайник'),
(4, 3, 'Ножницы'),
(5, 2, 'Компьютер');

-- Изменение существующих полей в созданной таблице
ALTER TABLE users MODIFY gender ENUM('M', 'F');

-- Если AFTER указывать, то автоматически добавит в конец, после последнего
ALTER TABLE users ADD sname VARCHAR(255) DEFAULT '' AFTER date_create;

-- Если необходимо создать ограничение по внешнему ключу, которое не создано при создании таблицы
ALTER TABLE orders
ADD CONSTRAINT orders_user_id FOREIGN KEY (user_id) REFERENCES users (id);

-- Если требуется убрать ограничение по внешнему ключу
-- ALTER TABLE orders
-- DROP FOREIGN KEY orders_user_id;

-- Добавление и изменение значений в существующей таблице
UPDATE users SET group_id = 1 WHERE id = 1;
UPDATE users SET group_id = 3 WHERE id = 2;
UPDATE users SET sname = 'Crack' WHERE id = 4;