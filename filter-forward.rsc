:global smtp;
/ip firewall filter
add action=accept chain=forward comment=DeshabilitarFirewal_Crenein disabled=no
add action=passthrough chain=forward comment="Proteccion de Forward - Crenein v6.0"
add action=jump chain=forward comment=ProteccionPublicasDentroDeLaRed_Crenein \
    dst-address-list=F_ProteccionPublicasDentroDeLaRed jump-target=\
    ProteccionPublicasDentroDeLaRed_Crenein
add action=accept chain=ProteccionPublicasDentroDeLaRed_Crenein disabled=yes
add action=drop chain=ProteccionPublicasDentroDeLaRed_Crenein
add action=jump chain=forward comment=ProteccionForwardEntrada_Crenein \
    in-interface-list=InterfacesExternas jump-target=ProteccionForwardEntrada_Crenein
add action=drop chain=ProteccionForwardEntrada_Crenein src-address-list=\
    F_ListaNegraGeneral
add action=accept chain=ProteccionForwardEntrada_Crenein connection-state=\
    established,related,new dst-address-list=FN_RedesPublicasPropias
add action=accept chain=ProteccionForwardEntrada_Crenein connection-state=\
    established,related
add action=drop chain=ProteccionForwardEntrada_Crenein connection-nat-state=!dstnat \
    connection-state=new
add action=drop chain=ProteccionForwardEntrada_Crenein connection-state=invalid \
    protocol=tcp
add action=drop chain=ProteccionForwardEntrada_Crenein connection-state=invalid
add action=jump chain=forward comment=ProteccionSMTP_Crenein dst-port=\
    25,110,465,587,995,143,993 jump-target=ProteccionSMTP_Crenein protocol=tcp
add action=drop chain=ProteccionSMTP_Crenein src-address-list=F_ListaNegraSMTP
add action=accept chain=ProteccionSMTP_Crenein src-address-list=F_ListaBlancaSMTP
:if ($smtp = 1) do={add action=drop chain=ProteccionSMTP_Crenein disabled=no} \
else={add action=drop chain=ProteccionSMTP_Crenein disabled=yes}
add action=jump chain=forward comment=ProteccionForwardSalida_Crenein jump-target=\
    ProteccionForwardSalida_Crenein out-interface-list=InterfacesExternas
add action=drop chain=ProteccionForwardSalida_Crenein src-address-list=\
    !F_OrigenesPermitidos
add action=drop chain=ProteccionForwardSalida_Crenein dst-address-list=\
    F_ListaNegraGeneral
add action=accept chain=ProteccionForwardSalida_Crenein connection-state=\
    established,related,new src-address-list=FN_RedesPublicasPropias
add action=accept chain=ProteccionForwardSalida_Crenein connection-state=\
    established,related
add action=drop chain=ProteccionForwardSalida_Crenein connection-state=invalid \
    protocol=tcp
add action=drop chain=ProteccionForwardSalida_Crenein connection-state=invalid
