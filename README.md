<h1>Backup Camunda</h1>
Script desenvolvido para facilitar processo de backup do software Camunda, o script atualmente recupera dados do banco de dados (Postgres/MariaDB/Mysql), e também recupera os arquivos customizados adicionados pelo usuário.

<h2>Informações importantes</h2>
Atualmente, temos a opção de script para as versões docker do camunda. Considerando isso, não é uma boa prática colocar baixar as pastas do container e colocar elas no volumes no docker-compose, pq qualquer atualização de versão do camunda ocasionará problemas. O recomendado é pegar arquivo por arquivo e adicionar no docker-compose.yml.

<h2>Pré-requisitos</h2>
Antes de executar o script, certifique-se de que você tenha instalado o Docker em sua máquina e que o ambiente "Camunda Run" ou "Camunda Tomcat" nas versões docker estejam configurados, assim como o banco de dados Mysql/Postgres.

<h2>Como utilizar o script</h2>

- Altere as variáveis de acordo com o seu ambiente (usuários, pastas, senhas, etc).

- Agora, você pode executar o script de backup usando o seguinte comando:
```
./backup-camunda-docker.sh
```
