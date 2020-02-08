/*
 Удаление таблиц если существуют и создание новых
 Удаление уже существующих таблиц не произойдет в данном случае из-за того что есть ограничение по внешнему ключу account_user_id
 В данном случае необходимо сначала удалять таблицу accounts и только потом таблицу users.
 Если поменять порядок создания таблиц, то произойдет ошибка при попытке добавления таблиц в пустую базу данных из-за того, что внешний ключ создаваться будет по несуществующему полю
 Я оставил так для того, чтобы показать, как создается внешний ключ при создании таблицы
*/
-- Таблица заказов
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNSIGNED NOT NULL,
    description TEXT,
    date_create DATETIME DEFAULT NOW()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Таблица пользователей
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
    date_update DATETIME
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Таблица групп пользователей
DROP TABLE IF EXISTS users_group;
CREATE TABLE users_group (
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Таблица аккаунтов пользователей
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNSIGNED NOT NULL,
    balance DECIMAL(10, 2),
    date_update DATETIME,
    CONSTRAINT account_user_id FOREIGN KEY (user_id) REFERENCES users (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Добавление новых значений в таблицу. Для добавления отдельных значений в таблицу есть UPDATE
INSERT INTO users_group (id, name) VALUES
(1, 'administrators'),
(2, 'other'),
(3, 'manager');

-- Триггеры (они же хранимые процедуры).
-- Удаление триггера
DROP TRIGGER IF EXISTS insert_accounts;

/*
 Заполняем таблицу accounts данными таблицы users. Триггер вставляется до вставки в таблицу users.
 В противном случае триггер начнет работать после вставки всех значений в таблицу users.
*/
DELIMITER $$
CREATE TRIGGER insert_accounts AFTER INSERT ON users
FOR EACH ROW
    BEGIN
        INSERT INTO accounts(user_id, balance) VALUES (NEW.id, 0.00);
    END $$
DELIMITER ;

-- Добавление новых значений в таблицу users
INSERT INTO users (id, login, active, email, group_id, name, gender, date_create, date_update) VALUES
(1, 'admin', 'Y', 'admin@mail.ru', 1, 'Lex', 'M', '2019-03-18 22:15:31', NOW()),
(2, 'pavel', 'Y', 'pavel@mail.ru', 2, 'Pavel', 'M', '2019-03-18 22:15:32', NOW()),
(3, 'ann', 'Y', 'ann@yandex.ru', 2, 'Ann', 'F', '2019-03-19 22:16:33', NOW()),
(4, 'bob', 'Y', 'bob@mail.ru', 2, 'Bob', 'M', '2019-03-19 22:16:33', NOW());

-- Добавление единичного значения
INSERT INTO orders (id, user_id, description) VALUE
(1, 4, 'Хочу купить велосипед и байк');

-- Добавление множественных значений
INSERT INTO orders (id, user_id, description, date_create) VALUES
(2, 3, 'Скороварка', '2020-04-05 22:15:18'),
(3, 3, 'Чайник', '2019-05-05 10:15:18'),
(4, 3, 'Ножницы', '2019-06-05 12:15:18'),
(5, 4, 'Сапоги', '2019-07-05 12:16:18'),
(6, 2, 'Компьютер', '2019-06-05 23:15:18');

-- Изменение существующих полей в созданной таблице
ALTER TABLE users MODIFY gender ENUM('M', 'F');

-- Если AFTER указывать, то автоматически добавит в конец, после последнего
ALTER TABLE users ADD sname VARCHAR(255) DEFAULT '' AFTER name;

-- Если необходимо создать ограничение по внешнему ключу, которое не создано при создании таблицы
ALTER TABLE orders
ADD CONSTRAINT orders_user_id FOREIGN KEY (user_id) REFERENCES users (id);

ALTER TABLE users
ADD CONSTRAINT users_group_id FOREIGN KEY (group_id) REFERENCES users_group (id);

-- Если требуется убрать ограничение по внешнему ключу
ALTER TABLE orders
DROP FOREIGN KEY orders_user_id;

-- Возвращаем ограничение в таблицу orders. Удаление выше делал для примера
ALTER TABLE orders
ADD CONSTRAINT orders_user_id FOREIGN KEY (user_id) REFERENCES users (id);

-- Добавление и изменение значений в существующей таблице
UPDATE users SET group_id = 1 WHERE id = 1;
UPDATE users SET group_id = 3 WHERE id = 2;

-- Триггер на изменение времени последнего редактирования записи в таблице users
DROP TRIGGER IF EXISTS update_user;

-- DELIMITER может быть разным
DELIMITER ||
CREATE TRIGGER update_user AFTER UPDATE ON users
FOR EACH ROW
    BEGIN
        UPDATE accounts SET date_update = NOW() WHERE user_id = OLD.id;
    END ||
DELIMITER ;

-- Сработает триггер на обновление в таблицу users
UPDATE users SET sname = 'Crack' WHERE id = 4;

-- Триггер на удаление записи из таблицы accounts, при удалении записи из таблицы users.
DROP TRIGGER IF EXISTS delete_account;

DELIMITER $$
CREATE TRIGGER delete_account BEFORE DELETE ON users
FOR EACH ROW
    BEGIN
        DELETE FROM accounts WHERE user_id = OLD.id;
    END $$
DELIMITER ;