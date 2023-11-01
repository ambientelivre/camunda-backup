## Script created by Marcos Churkin/marcos@ambientelivre.com.br and Pedro Kravetz


DESTDIR=/opt/backup    ## Destino onde será feito o backup
DATE_NOW=$(date +%y-%m-%d)     ## Nome setado para pasta
LOCATE_CAMUNDA=/opt/camunda    ## Local de instalação Camunda
DBENGINE=mysql                 ## Banco de dados para backup (postgres OU mariadb)
DOCKER_VOLUMES=camunda         ## Pasta dentro do local de instalação do Camunda onde os arquivos de configuração são instalados
DB_DOCKER="N"                  ## Define se o banco está no mesmo docker-compose, caso não esteja, é necessário installar o mysqldump ou pg_dump dependendo do banco

##Configuração Database Postgres
PGUSER=camunda
export PGPASSWORD=camunda
PGHOST=localhost
#PGPORT=5432
PGDATABASE=process-engine

##Configuração Database MariaDB/Mysql
DBUSER=camunda
DBPASS=camunda
DBHOST=localhost
#DBPORT=3306
DBDATABASE=process-engine



mkdir $DESTDIR/$DATE_NOW
cd $LOCATE_CAMUNDA

if [ $DB_DOCKER = "Y" ]
then
  if [ $DBENGINE = "mysql" ]
  then
    docker-compose exec mysql mysqldump -u$DBUSER -p$DBPASS $DBDATABASE > $DESTDIR/$DATE_NOW/$DBDATABASE'_'$DBENGINE.sql
  elif [ $DBENGINE = "postgres" ]
  then
    docker-compose exec postgres pg_dump --username $PGUSER $PGDATABASE > $DESTDIR/$DATE_NOW/postgresql.sql
  fi
elif [ $DB_DOCKER = "N" ]
  then
  if [ $DBENGINE = "mysql" ]
  then
    mysqldump -u$DBUSER -p$DBPASS $DBDATABASE > $DESTDIR/$DATE_NOW/$DBDATABASE'_'$DBENGINE.sql
  elif [ $DBENGINE = "postgres" ]
  then
    pg_dump --username $PGUSER -h $PGHOST -d $PGDATABASE > $DESTDIR/$DATE_NOW/postgresql.sql
  fi
fi

tar -pczvf $DESTDIR/$DATE_NOW/camundaVolumes.tar.gz $DOCKER_VOLUMES

##Localiza arquivos criados/modificados a mais de 365 dias e excluem
find $DESTDIR* -mtime +365 -exec rm -rf {} \;

