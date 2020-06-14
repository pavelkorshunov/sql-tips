# SQL подсказки субд PostgreSQL
Подключение: <b>sudo -u postgres psql</b><br>
Просмотр списка баз данных пользователя: <b>\l</b><br>
Переключение на нужную базу данных: <b>\connect dbname</b><br>
Просмотр списка таблиц: <b>\d</b><br>
Для импорта можно использовать команду <b>psql -U posgres -d helper -f create.sql</b>, где helper - имя базы данных.<br>
Либо <b>sudo -u postgres psql -d helper -f create.sql</b>, если работаем не из под пользователя <b>postgres</b>.
