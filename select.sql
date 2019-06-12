-- Использование литералов и встроенных функций mysql в запросах select
SELECT id, login, name, 'Y', UPPER(sname) FROM users;