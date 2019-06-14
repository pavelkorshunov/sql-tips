-- Версия субд, пользователь, база данных
SELECT VERSION(), USER(), DATABASE();

-- Использование литералов и встроенных функций mysql в запросах select
SELECT id, login, name, 'Y', UPPER(sname) FROM users;

-- Использование ключевого слова IN. Аналогично WHERE id = 1 OR id = 2
SELECT id, login, email FROM users WHERE id IN (1, 2);

-- Декартово произведение
SELECT u.id, u.email, g.name FROM users u INNER JOIN users_group g ORDER BY u.id DESC;

-- Пример внутриннего соединения таблиц. Выбираем всех пользователей и их группу, к которой они принадлежат.
SELECT u.id, u.email, g.name FROM users u INNER JOIN users_group g ON u.group_id = g.id;

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