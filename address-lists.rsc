#Variables globales
:global redespublicas;
:global ipspermitidasebgp;
:global listablancaapi;
:global publicasdentrodelared;
##Menu address-list
/ip firewall address-list
##Redes que se permiten navegar
:do {add address=10.0.0.0/8 list=F_OrigenesPermitidos} \
on-error={:put "No se pudo crear el address-list address=10.0.0.0/8 list=F_OrigenesPermitidos"}
:do {add address=172.16.0.0/12 list=F_OrigenesPermitidos}  \
on-error={:put "No se pudo crear el address-list address=172.16.0.0/12 list=F_OrigenesPermitidos"}
:do {add address=192.168.0.0/16 list=F_OrigenesPermitidos}  \
on-error={:put "No se pudo crear el address-list address=192.168.0.0/16 list=F_OrigenesPermitidos"}
##Redes publicas propias
:foreach alpp in=$redespublicas do={:do {/ip firewall address-list add list=FN_RedesPublicasPropias \
address=$alpp} on-error={:put "No se pudo crear el address-list address=$alpp list=FN_RedesPublicasPropias"};
}
:foreach alpp in=$redespublicas do={:do {/ip firewall address-list add list=F_OrigenesPermitidos \
address=$alpp} on-error={:put "No se pudo crear el address-list address=$alpp list=F_OrigenesPermitidos"};
}
##IPs permitidas para BGP externo
:foreach alpp in=$ipspermitidasebgp do={:do {/ip firewall address-list add list=F_ProteccionBGP_IPsPermitidas \
address=$alpp} on-error={:put "No se pudo crear el address-list address=$alpp list=F_ProteccionBGP_IPsPermitidas"};
}
##Lista blanca API Mikrotik
:foreach alpp in=$listablancaapi do={:do {/ip firewall address-list add list=F_ListaBlancaAPIMikrotik \
address=$alpp} on-error={:put "No se pudo crear el address-list address=$alpp list=F_ListaBlancaAPIMikrotik"};
}
##Publicas dentro de la red a bloquear
:foreach alpp in=$publicasdentrodelared do={:do {/ip firewall address-list add list=F_ProteccionPublicasDentroDeLaRed \
address=$alpp} on-error={:put "No se pudo crear el address-list address=$alpp list=F_ProteccionPublicasDentroDeLaRed"};
}