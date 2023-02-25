# Practica_IOS_Avanzado
Practica realizada en el Módulo de IOS Avanzado, en la que recibo datos de la api de Dragon ball y muestro una table view con los heroes, que pueden ser filtrados con un searchBar y un mapa con sus localizaciones, además de un login de inicio. La aplicacion trabaja con CoreData y KeyChain. Explico un poco el flujo de la aplicación:

- La aplicacion muestra Pantalla de Login ( si no hay token guardado en keyChain )
- Una vez se accede con usuario y contraseña compruebo si hay datos guardados en coreData, si no los hay hago una llamada a la api y guardo en core data los datos. Si ya hay datos en core data directamente los coje de ahí

[![IMG-5440.jpg](https://i.postimg.cc/ZKy1m81S/IMG-5440.jpg)](https://postimg.cc/zV8dSgzt) [![IMG-5441.png](https://i.postimg.cc/MGtL5djy/IMG-5441.png)](https://postimg.cc/yJgnYhjd)

- Tambien he implementado un SearchBar para filtrar los heroes segun voy escribiendo
- Implementacion de un MapView con las localizaciones de cada uno de los heroes, añadiendo anotaciones y CallOuts

[![IMG-5442.png](https://i.postimg.cc/zGC6bJz2/IMG-5442.png)](https://postimg.cc/DSzBR3b1)
[![IMG-5444.png](https://i.postimg.cc/MTFF2H5H/IMG-5444.png)](https://postimg.cc/G8vQvcZn)

- He implementado tambien en la vista principal un boton que borra los datos de CoreData, al arrastrar hacia abajo se volverá a hacer otra llamada a la api para guardar de nuevo los datos borrados.
- Boton de Logout

[![IMG-5448.png](https://i.postimg.cc/htWNtJB7/IMG-5448.png)](https://postimg.cc/0bnVtyr8) [![IMG-5449.png](https://i.postimg.cc/8CT3Lqsp/IMG-5449.png)](https://postimg.cc/gxBNWtvQ)





