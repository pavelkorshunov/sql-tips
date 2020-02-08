-- Версия субд, пользователь, база данных
SELECT VERSION(), USER(), DATABASE();

-- Использование литералов и встроенных функций mysql в запросах select
SELECT id, login, name, 'Y', UPPER(sname) FROM users;

-- Использование ключевого слова IN. Аналогично WHERE id = 1 OR id = 2
SELECT id, login, email FROM users WHERE id IN (1, 2);

-- Использование GROUP BY. Выбираем id всех пользователей, которые делали заказ
SELECT user_id FROM orders GROUP BY user_id;

-- То же самое: "Выбираем id всех пользователей, которые делали заказ", только с помощью ключевого слова DISTINCT
SELECT DISTINCT user_id FROM orders ORDER BY user_id;

-- Чтобы подсчитать какое количество заказов сделал пользователь с одним id
SELECT user_id, COUNT(*) how_many FROM orders GROUP BY user_id;

-- Выбираем всех пользователей у которых количество заказов больше 1 с помощью HAVING
SELECT user_id, COUNT(*) how_many FROM orders GROUP BY user_id HAVING COUNT(*) > 1;

-- Используем ограничение на выборку не более 3 пользователей
SELECT * FROM users LIMIT 3;

-- Подсчитаем количество заказов сделанное в каждом месяце 2019 года
SELECT MONTH(date_create) month, COUNT(*) count FROM orders WHERE date_create BETWEEN '2019-01-01' AND '2019-12-31' GROUP BY month;

-- Подсчитаем количество заказов сделанное 2019-06
SELECT COUNT(*) count FROM orders WHERE date_create BETWEEN '2019-06-01' AND '2019-06-30';

-- Декартово произведение
SELECT u.id, u.email, g.name FROM users u INNER JOIN users_group g ORDER BY u.id DESC;

-- Пример внутриннего соединения таблиц. Выбираем всех пользователей и их группу, к которой они принадлежат.
SELECT u.id, u.email, g.name FROM users u INNER JOIN users_group g ON u.group_id = g.id;

-- Множества (более подробно можно ознакомиться в книге Алана Бьюли "Изучаем SQL", глава 6)
/* При применении операций с множествами к реальным таблицам необходимо соблюдать такие правила:
1. В обеих таблицах должно быть одинаковое число столбцов.
2. Типы данных столбцов двух таблиц должны быть одинаковыми (или сервер должен уметь преобразовывать один тип в другой).
В нашем случае пример ознакомительного характера, поскольку данные берутся из одной таблицы*/

-- Объединить все
SELECT id, name FROM users UNION ALL SELECT id, login FROM users ORDER BY id;

-- Объединить
SELECT id, name FROM users UNION SELECT id, login FROM users ORDER BY id;

-- Подзапросы
/* Подзапрос всегда заключен в круглые скобки и обычно выполняется до содержащего выражения
Как и любой другой запрос, подзапрос возвращает таблицу, которая может состоять из:
1. Одной строки с одним столбцом
2. Нескольких строк с одним столбцом
3. Нескольких строк и столбцов */

-- Пример простого подзапроса
SELECT id, login, email FROM users WHERE id = (SELECT MAX(id) FROM users);
/* Подзапрос возвращает одну строку и один столбец. Это позволяет использовать его как одно из выражений в условии равенства
(если бы подзапрос возвращал две или более строк, он мог бы сравниваться с чем-то, но не мог бы быть равным чему-то;)*/

-- Пример подзапроса с ключевым словом IN. Выбираем всех пользователей, которые делали заказ
SELECT id, email, name FROM users WHERE id IN(SELECT user_id FROM orders);

-- Пример подзапроса с ключевым словом NOT IN. Выбираем всех пользователей, которые не делали заказов
SELECT id, email, name FROM users WHERE id NOT IN(SELECT user_id FROM orders);