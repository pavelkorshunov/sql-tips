-- Задача 1. Выбрать всех пользователей и их заказы
SELECT * FROM users u INNER JOIN orders o ON u.id = o.user_id;

-- Задача 2. Выбрать login из таблицы users сгруппировать по нему и вывести количество заказов для каждого пользователя 
-- Результат должен быть следующим:
-- login   total
-----------------
-- admin     2
-- manager   1
SELECT "login", COUNT(o.user_id) AS total FROM users u INNER JOIN orders o ON u.id = o.user_id GROUP BY login;
