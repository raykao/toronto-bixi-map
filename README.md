
## run as daemon process with thin

### Start
$ thin -C config.yml -R config.ru start

### Multiple thin instances (2 in this example)
$ thin -s 2 -C config.yml -R config.ru start 

### Stop
$ thin stop