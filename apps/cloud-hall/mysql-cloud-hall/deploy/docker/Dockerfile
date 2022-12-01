FROM mysql:5.7

ENV mysql_allow_empty_password yes

COPY hack/setup.sh /opt/setup.sh

COPY sql/*.sql /mysql/sql/
COPY sql/my.cnf /etc/mysql/conf.d/docker.cnf

COPY jar/* /opt/

CMD ["sh", "/opt/setup.sh"]
