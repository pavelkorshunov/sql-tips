-- Коммит транзакции COMMIT
START TRANSACTION;
    UPDATE accounts SET balance = balance + 100 WHERE user_id = 1;
COMMIT;

-- Отмена транзакции ROLLBACK
START TRANSACTION;
    UPDATE accounts SET balance = balance + 200 WHERE user_id = 2;
ROLLBACK;

-- Отмена до SAVEPOINT и затем фиксируем изменения которые были до SAVEPOINT
START TRANSACTION;
    UPDATE accounts SET balance = balance + 100 WHERE user_id = 1;
    UPDATE accounts SET balance = balance + 200 WHERE user_id = 2;
SAVEPOINT balance_point;
    UPDATE accounts SET balance = balance - 50 WHERE user_id = 1;
ROLLBACK TO balance_point;
COMMIT;

-- Отлючить режим автоматической фиксации
-- SET AUTOCOMMIT=0