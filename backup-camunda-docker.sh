## Script created by Marcos Churkin/marcos@ambientelivre.com.br


DESTDIR=/opt/camunda/backup    ##Destino onde será feito o backup
DATENOW=$(date +%d-%m-%y)      ##Nome setado para pasta
LOCATE_CAMUNDA=/opt/camunda    ##Local de instalação Camunda
WEB_INF=/opt/camunda/camunda/camunda-data/webapps/camunda/WEB-INF/lib ##Local reponsavel de armazenamento de JAR
DBENGINE=postgres              ## Banco de dados para backup (postgres OU mariadb)
BACKUP_INCREMENTAL=false        ## Ativa ou Desativa backup incremental (true OU false)

##Configuração Database Postgres
PGUSER=camunda
PGPASSWORD=camunda
PGHOST=localhost
#PGPORT=5432
PGDATABASE=process-engine

##Configuração Database MariaDB/Mysql
DBUSER=camunda
DBPASS=camunda
DBHOST=localhost
#DBPORT=3306
DBDATABASE=process-engine



mkdir $DESTDIR/$DATENOW
cd $LOCATE_CAMUNDA

if [ $DBENGINE = "mariadb" ]
then
  docker-compose exec mariadb mysqldump -u$DBUSER -p$DBPASS $DBDATABASE > $DESTDIR/$DATE_NOW/$DBDATABASE'_'$DBENGINE.sql
elif [ $DBENGINE = "postgres" ]
then
  docker-compose exec postgres pg_dump --username $PGUSER $PGDATABASE > $DESTDIR/$DATE_NOW/postgresql.sql
fi


if [ $BACKUP_INCREMENTAL = "false" ]
then
   tar -pczvf $DESTDIR/$DATENOW/WEB-INF_backup_full.tar.gz $WEB_INF
   cp $LOCATE_CAMUNDA/docker-compose.yml $DESTDIR/$DATENOW

#Script para realizar backup incremental
elif [ $BACKUP_INCREMENTAL = "true" ]
then
if [ -f $DESTDIR/ultimo_backup_completo.txt ]
then
  ULTIMO_BACKUP_COMPLETO=$(cat $DESTDIR/ultimo_backup_completo.txt)
else
  ULTIMO_BACKUP_COMPLETO="nunca"
fi

if [ $ULTIMO_BACKUP_COMPLETO = "nunca" ]
then
  tar -pczvf $DESTDIR/$DATENOW/WEB-INF_backup_full.tar.gz $WEB_INF

  #Cria arquivo para verificação de backup
  touch $DESTDIR/ultimo_backup_completo.txt
  echo  $DATENOW > $DESTDIR/ultimo_backup_completo.txt
else
  #Verifica ultima data de backup, e salva somente arquivos modificados após a data.
  tar -pczvf $DESTDIR/$DATENOW/WEB-INF_backup_incremental.tar.gz --newer=$ULTIMO_BACKUP_COMPLETO $WEB_INF
fi
fi
