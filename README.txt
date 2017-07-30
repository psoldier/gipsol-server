REQUISITOS

1- Instalar MongoDb https://docs.mongodb.com/v3.4/tutorial/install-mongodb-on-ubuntu/

2- Instalar ruby (preferiblemente con un manejador de versiones)
  a) https://rvm.io/rvm/install#basic-install

3- Clonar el proyecto
  ~$ git clone git@github.com:psoldier/gipsol-server.git

4- Instalar gemas necesarias
  ~$ cd gipsol-server
  ~$ gem install bundler
  ~$ bundle install
(Es posible que al ingresar se necesite previamente instalar la versión de ruby. En este caso hay que seguir las instrucciones que RVM indica por consola)

CORRER EL PROYECTO

1- Levantar la BD
  ~$ sudo service mongod start

2- Correr el proyecto
  ~$ rackup
o en modo development para que tome los cambios automáticamente
  ~$ rerun rackup