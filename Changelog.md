# Version 6.5 - 29/09/2021
* Internal interfaces excluir dinamicas
* Lista negra vpn siempre se crea
* Lista negra gral opcional, configurable en enviroment
* Esenario equipos privados despues del firewall, nueva lista de permitir x origenges
* Configuracion para habilitar o no scheduler api log
* Problemas al generar el script EdgeHardeningEnviroment_Crenein

# Version 6.4 - 19/07/2021
* Correccion port knoking

# Version 6.3 - 15/07/2021
* Ahora se pueden definir listas de IPs Blancas y Negras para cada servicio admás de las Interfaces Lists.
* Se optimizó la creacion de filters. Solo se crean las reglas que tengan alguna configuracón.
* Se incorporó la creación de un scheduler de reconocimiento de login fallido API. Este crea una lista de las IPs atacantes.
* Se agrego la red 100.64.0.0/10 como bogons configurable.
* Se corrigio un error al crear los filtros para web-proxy. Si el proxy tiene 2 puertos configurados, la regla se creaba erroneamente.