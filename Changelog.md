# Version 6.3 - 15/07/2021
* Ahora se pueden definir listas de IPs Blancas y Negras para cada servicio admás de las Interfaces Lists.
* Se optimizó la creacion de filters. Solo se crean las reglas que tengan alguna configuracón.
* Se incorporó la creación de un scheduler de reconocimiento de login fallido API. Este crea una lista de las IPs atacantes.
* Se agrego la red 100.64.0.0/10 como bogons configurable.
* Se corrigio un error al crear los filtros para web-proxy. Si el proxy tiene 2 puertos configurados, la regla se creaba erroneamente.

# Version 6.4 - 19/07/2021
* Correccion port knoking