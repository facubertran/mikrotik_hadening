#Variables globales
:global redespublicas;
:global ipspermitidasebgp;
:global listablancaapi;
:global publicasdentrodelared;
##Menu address-list
/ip firewall address-list
##Redes que se permiten navegar
:do {add address=10.0.0.0/8 list=F_OrigenesPermitidos} on-error={}
:do {add address=172.16.0.0/12 list=F_OrigenesPermitidos} on-error={}
:do {add address=192.168.0.0/16 list=F_OrigenesPermitidos} on-error={}
##Redes publicas propias
:foreach alpp in=$redespublicas do={:do {/ip firewall address-list add list=FN_RedesPublicasPropias \
address=$alpp} on-error={};
}
:foreach alpp in=$redespublicas do={:do {/ip firewall address-list add list=F_OrigenesPermitidos \
address=$alpp} on-error={};
}
##IPs permitidas para BGP externo
:foreach alpp in=$ipspermitidasebgp do={:do {/ip firewall address-list add list=F_ProteccionBGP_IPsPermitidas \
address=$alpp} on-error={};
}
##Lista blanca API Mikrotik
:foreach alpp in=$listablancaapi do={:do {/ip firewall address-list add list=F_ListaBlancaAPIMikrotik \
address=$alpp} on-error={};
}
##Publicas dentro de la red a bloquear
:foreach alpp in=$publicasdentrodelared do={:do {/ip firewall address-list add list=F_ProteccionPublicasDentroDeLaRed \
address=$alpp} on-error={};
}