##Redes Bogons
/ip firewall address-list
add address=0.0.0.0/8 list=F_Bogons
add address=10.0.0.0/8 list=F_Bogons
add address=100.64.0.0/10 list=F_Bogons
add address=127.0.0.0/8 list=F_Bogons
add address=169.254.0.0/16 list=F_Bogons
add address=172.16.0.0/12 list=F_Bogons
add address=192.0.0.0/24 list=F_Bogons
add address=192.0.2.0/24 list=F_Bogons
add address=192.168.0.0/16 list=F_Bogons
add address=198.18.0.0/15 list=F_Bogons
add address=198.51.100.0/24 list=F_Bogons
add address=203.0.113.0/24 list=F_Bogons
add address=224.0.0.0/3 list=F_Bogons
##Redes que se permiten navegar
add address=10.0.0.0/8 list=F_OrigenesReservadosPermitidos
add address=172.16.0.0/12 list=F_OrigenesReservadosPermitidos
add address=192.168.0.0/16 list=F_OrigenesReservadosPermitidos
##Redes publicas propias
add address=45.70.8.76 list=FN_RedesPublicasPropias