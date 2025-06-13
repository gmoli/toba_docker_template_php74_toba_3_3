# toba-docker-template

## Levantar el stack
```bash
docker compose up -d
```


## Ingresar al contenedor
```bash
docker exec -it toba_docker bash
```
## Instalar toba
### Opción 1 - Instalacion silenciosa
Se puede utilizar la instalación utilizando los parametros del archivo parameters.yml (pueden editar el archivo con "nano /usr/local/build/parameters.yml")
```bash
bin/toba instalacion_silenciosa instalar --archivo_configuracion /usr/local/build/parameters.yml
```
Luego cargar los proyectos
```bash
bin/toba proyecto cargar -p toba_editor -a 1 && bin/toba proyecto cargar -p toba_usuarios -a 1 && bin/toba proyecto cargar -p toba_referencia -a 1
```
Una vez completada la instalación crear link simbolico en apache:

```bash
ln -s /var/local/docker-data/toba_docker-instalacion/toba.conf /etc/apache2/conf.d/toba.conf
```

Hace falta reiniciar apache en el contenedor (se puede salir del contenedor con "exit" y luego reiniciar el contenedor "docker restart  toba_docker")

Navegar al editor : http://localhost:7008/toba_editor/3.3/

### Opción 2 - Instalacion tradicional
Instalación tradicional ingresando los parametros por pantalla

```bash
bin/toba instalacion instalar
```
Nota: en la instalación tradicional en referencia a la base de datos ingresar:
```bash
PostgreSQL - Ubicaci�n (ENTER utilizar� localhost): pg
PostgreSQL - Puerto (ENTER utilizar�: 5432): 5432
PostgreSQL - Usuario (ENTER utilizar� postgres): postgres
PostgreSQL - Clave  (ENTER para usar sin clave): postgres
```
Una vez completada la instalación crear link simbolico en apache:

```bash
ln -s /var/local/docker-data/toba_docker-instalacion/toba.conf /etc/apache2/conf.d/toba.conf
```


Hace falta reiniciar apache en el contenedor (se puede salir del contenedor con "exit" y luego reiniciar el contenedor "docker restart  toba_docker")

Navegar al editor : http://localhost:7008/toba_editor/3.3/


## Cargar proyecto

El directorio  "/var/local/docker-data/proyecto"  se encuentra montado,  se puede descargar el proyecto desde el contenedor (tiene el git instalado) o desde el SO anfitrión.
```bash
source entorno_toba.env
toba proyecto cargar -p proyecto_toba -d '/var/local/docker-data/proyecto/proyecto_toba'
```
Verificar permisos correspondientes en los directorios:

/var/local/docker-data/proyecto

/var/local/docker-data/toba_docker-instalacion

/usr/local/build/vendor/


## Base de datos
Acceso:  localhost:7432

## Bajar stack
```bash
docker compose down
```
## Configurar valores de php.ini web
Editar:
```bash
80-siu.ini
```

