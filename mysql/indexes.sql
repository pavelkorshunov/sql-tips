-- Индексы
ALTER TABLE users ADD INDEX user_name (name);

-- Удаление индекса
ALTER TABLE users DROP INDEX user_name;

-- Посмотреть индексы таблицы
SHOW INDEX FROM users;

-- Составные индексы
ALTER TABLE users ADD INDEX user_name (name, sname);