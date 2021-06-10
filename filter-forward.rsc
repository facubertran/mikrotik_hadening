/ip firewall filter
add action=accept chain=forward comment=DeshabilitarFirewal disabled=no
add action=passthrough chain=forward comment="Proteccion de Forward - Crenein v6.0"
add action=jump chain=forward comment=ProteccionPublicasDentroDeLaRed \
    dst-address-list=F_ProteccionPublicasDentroDeLaRed jump-target=\
    ProteccionPublicasDentroDeLaRed
add action=accept chain=ProteccionPublicasDentroDeLaRed disabled=yes
add action=drop chain=ProteccionPublicasDentroDeLaRed
add action=jump chain=forward comment=ProteccionForwardEntrada \
    in-interface-list=InterfacesExternas jump-target=ProteccionForwardEntrada
add action=drop chain=ProteccionForwardEntrada src-address-list=\
    F_ListaNegraGeneral
add action=accept chain=ProteccionForwardEntrada connection-state=\
    established,related,new dst-address-list=FN_RedesPublicasPropias
add action=accept chain=ProteccionForwardEntrada connection-state=\
    established,related
add action=drop chain=ProteccionForwardEntrada connection-nat-state=!dstnat \
    connection-state=new
add action=drop chain=ProteccionForwardEntrada connection-state=invalid \
    protocol=tcp
add action=drop chain=ProteccionForwardEntrada connection-state=invalid
add action=jump chain=forward comment=ProteccionSMTP dst-port=\
    25,110,465,587,995,143,993 jump-target=ProteccionSMTP protocol=tcp
add action=drop chain=ProteccionSMTP src-address-list=F_ListaNegraSMTP
add action=accept chain=ProteccionSMTP src-address-list=F_ListaBlancaSMTP
add action=drop chain=ProteccionSMTP disabled=yes
add action=jump chain=forward comment=ProteccionForwardSalida jump-target=\
    ProteccionForwardSalida out-interface-list=InterfacesExternas
add action=drop chain=ProteccionForwardSalida src-address-list=\
    !F_OrigenesPermitidos
add action=drop chain=ProteccionForwardSalida dst-address-list=\
    F_ListaNegraGeneral
add action=accept chain=ProteccionForwardSalida connection-state=\
    established,related,new src-address-list=FN_RedesPublicasPropias
add action=accept chain=ProteccionForwardSalida connection-state=\
    established,related
add action=drop chain=ProteccionForwardSalida connection-state=invalid \
    protocol=tcp
add action=drop chain=ProteccionForwardSalida connection-state=invalid
