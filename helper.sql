DROP TABLE IF EXISTS users_group;
CREATE TABLE users_group (
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255)
) ENGINE InnoDB;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    login VARCHAR(60) UNIQUE,
    email VARCHAR(60) UNIQUE,
    group_id INT UNSIGNED NOT NULL,
    name VARCHAR(150),
    gender CHAR(1),
    date_create DATETIME,
    CONSTRAINT users_group_id FOREIGN KEY (group_id) REFERENCES users_group (id)
) ENGINE InnoDB;

INSERT INTO users_group (id, name)
VALUES (1, 'administrators'), (2, 'other'), (3, 'manager');

INSERT INTO users (id, login, email, group_id, name, gender, date_create)
VALUES (1, 'admin', 'admin@mail.ru', 1, 'Lex', 'M', '2019-03-18 22:15:31'), (2, 'pavel', 'pavel@mail.ru', 2, 'Pavel', 'M', '2019-03-18 22:15:32');

ALTER TABLE users MODIFY gender ENUM('M', 'F');
ALTER TABLE users ADD sname VARCHAR(255);

UPDATE users SET group_id = 1 WHERE id = 1;
UPDATE users SET group_id = 2 WHERE id = 2;