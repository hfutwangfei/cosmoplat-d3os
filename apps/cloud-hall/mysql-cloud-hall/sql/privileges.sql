use mysql;

select host, user from user;

create user IF NOT EXISTS d3os identified by 'd3os@cosmoplat';

grant all on `cloud_hall`.* to d3os@'%' identified by 'd3os@cosmoplat' with grant option;
GRANT all ON `cloud_hall`.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;
GRANT all ON `cloud_hall`.* TO 'root'@'127.0.0.1' IDENTIFIED BY '123456' WITH GRANT OPTION;

flush privileges;
