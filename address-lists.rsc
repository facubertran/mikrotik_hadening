#Variables globales
:global redespublicas; :global ipspermitidasebgp; :global listablancaapi; :global publicasdentrodelared; :global redesdeorigenpermitidas
##Menu address-list
/ip firewall address-list
##Redes que se permiten navegar
/ip firewall address-list remove [find list=F_OrigenesPermitidos]
:do {add address=10.0.0.0/8 list=F_OrigenesPermitidos} \
on-error={:put "INFO - El address-list address=10.0.0.0/8 list=F_OrigenesPermitidos ya existe o no se puede crear"}
:do {add address=172.16.0.0/12 list=F_OrigenesPermitidos}  \
on-error={:put "INFO - El address-list address=172.16.0.0/12 list=F_OrigenesPermitidos ya existe o no se puede crear"}
:do {add address=192.168.0.0/16 list=F_OrigenesPermitidos}  \
on-error={:put "INFO - El address-list address=192.168.0.0/16 list=F_OrigenesPermitidos ya existe o no se puede crear"}
##Redes que se permiten navegar personalizadas
:foreach alpp in=$redesdeorigenpermitidas do={:if ([:len $alpp] > 2) do={:do {/ip firewall address-list add list=F_OrigenesPermitidos \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_OrigenesPermitidos ya existe o no se puede crear"}}}
##Redes publicas propias
/ip firewall address-list remove [find list=FN_RedesPublicasPropias]
:foreach alpp in=$redespublicas do={:if ([:len $alpp] > 2) do={:do {/ip firewall address-list add list=FN_RedesPublicasPropias \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=FN_RedesPublicasPropias ya existe o no se puede crear"}}}
:foreach alpp in=$redespublicas do={:if ([:len $alpp] > 2) do={:do {/ip firewall address-list add list=F_OrigenesPermitidos \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_OrigenesPermitidos ya existe o no se puede crear"}}}
##IPs permitidas para BGP externo
/ip firewall address-list remove [find list=F_ProteccionBGP_IPsPermitidas]
:foreach alpp in=$ipspermitidasebgp do={:if ([:len $alpp] > 2) do={:do {/ip firewall address-list add list=F_ProteccionBGP_IPsPermitidas \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ProteccionBGP_IPsPermitidas ya existe o no se puede crear"}}}
##Lista blanca API Mikrotik
/ip firewall address-list remove [find list=F_ListaBlancaAPIMikrotik]
:foreach alpp in=$listablancaapi do={:if ([:len $alpp] > 2) do={:do {/ip firewall address-list add list=F_ListaBlancaAPIMikrotik \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaAPIMikrotik ya existe o no se puede crear"}}}
##Publicas dentro de la red a bloquear
/ip firewall address-list remove [find list=F_ProteccionPublicasDentroDeLaRed]
:foreach alpp in=$publicasdentrodelared do={:if ([:len $alpp] > 2) do={:do {/ip firewall address-list add list=F_ProteccionPublicasDentroDeLaRed \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ProteccionPublicasDentroDeLaRed ya existe o no se puede crear"}}}