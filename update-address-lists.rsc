#Disable firewall
/ip firewall filter enable [find comment="DeshabilitarFirewal"]
#Variables globales
:global redespublicas;
:global ipspermitidasebgp;
:global listablancaapi;
:global publicasdentrodelared;
##Menu address-list
/ip firewall address-list
##Remove old address-list
remove [find list=F_OrigenesPermitidos]
remove [find list=FN_RedesPublicasPropias]
remove [find list=F_OrigenesPermitidos]
remove [find list=F_ProteccionBGP_IPsPermitidas]
remove [find list=F_ListaBlancaAPIMikrotik]
##Redes que se permiten navegar
add address=10.0.0.0/8 list=F_OrigenesPermitidos
add address=172.16.0.0/12 list=F_OrigenesPermitidos
add address=192.168.0.0/16 list=F_OrigenesPermitidos
##Redes publicas propias
:foreach alpp in=$redespublicas do={/ip firewall address-list add list=FN_RedesPublicasPropias \
address=$alpp;
}
:foreach alpp in=$redespublicas do={/ip firewall address-list add list=F_OrigenesPermitidos \
address=$alpp;
}
##IPs permitidas para BGP externo
:foreach alpp in=$ipspermitidasebgp do={/ip firewall address-list add list=F_ProteccionBGP_IPsPermitidas \
address=$alpp;
}
##Lista blanca API Mikrotik
:foreach alpp in=$listablancaapi do={/ip firewall address-list add list=F_ListaBlancaAPIMikrotik \
address=$alpp;
}
##Publicas dentro de la red a bloquear
:foreach alpp in=$publicasdentrodelared do={/ip firewall address-list add list=F_ProteccionPublicasDentroDeLaRed \
address=$alpp;
}
#Enable firewall
/ip firewall filter disable [find comment="DeshabilitarFirewal"]