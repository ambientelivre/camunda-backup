## Script created by Marcos Churkin/marcos@ambientelivre.com.br

CAMUNDA_DIR="/opt/camunda/camunda"
DATA_DIR="$CAMUNDA_DIR/camunda-data"

mkdir -p "$DATA_DIR/lib"
chmod 755 "$CAMUNDA_DIR"

mkdir -p "$DATA_DIR/conf"
chmod 755 "$CAMUNDA_DIR"

mkdir -p "$DATA_DIR/webapps"
chmod 755 "CAMUNDA_DIR"

docker cp camunda_camunda_1:/camunda/lib/. "$DATA_DIR/lib"
docker cp camunda_camunda_1:/camunda/webapps/. "$DATA_DIR/webapps"
docker cp camunda_camunda_1:/camunda/conf/. "$DATA_DIR/conf"
