##-----------__Version 6.0 __-------------####
##
#Registra los puertos para port-knoking
##
##----------Configuracion de redes o IPs de confianza------------##
:global portknoking {port1="1"; port2="2"};
##
#Crea o no bogons de redes privadas y CGNAT
##
#Registra las redes o IPs de confianza
##
##----------Configuracion de redes o IPs de confianza------------##
:global creneinagent "10.0.0.0/8";
:global redespublicas {"45.98.68.5"}
:global redesdeorigenpermitidas {"45.98.68.5"}
:global ipspermitidasebgp {"45.70.8.1"}
:global listablancaapi {"149.46.68.55"; "141.69.8.66"}
:global publicasdentrodelared {"45.98.68.5"}
##----------Configuracion de interfaces------------##
##
#Registra el esquema de interfaces que requieras
##
:global interfacesexternas {""}
:global interfacesexternasdeconfianza {""}
##----------Configuracion de SMTP------------##
##
#Valor 1; habilitado, valor 0 deshabilitado
##
:global smtp 1;
##----------Configuracion de servicios en interfaces internas------------##
##
#Habilita o deshabilita servicios en las interfaces internas
#Valor 1; habilitado, valor 0 deshabilitado
##
:global testvelocidadii 1;
:global ospfii 1;
:global bgpii 1;
:global dnsii 1;
:global dhcpii 1;
:global snmpii 1;
:global mndpii 1;
:global winboxii 1;
:global sshii 1;
:global httpii 1;
:global ntpii 1;
:global radiusii 1;
:global socksii 0;
:global smbii 0;
:global l2tpii 0;
:global pptpii 0;
:global greii 0;
:global ipsecii 0;
:global webproxyii 0;
##----------Configuracion de servicios en interfaces externas------------##
##
#Habilita o deshabilita servicios en las interfaces externas
#Valor 1; habilitado, valor 0 deshabilitado
##
:global testvelocidadie 0;
:global ospfie 0;
:global bgpie 1;
:global dhcpie 1;
:global snmpie 0;
:global mndpie 0;
:global winboxie 1;
:global sshie 1;
:global httpie 1;
:global ntpie 0;
:global radiusie 0;
:global socksie 0;
:global smbie 0;
:global l2tpie 1;
:global pptpie 1;
:global greie 1;
:global ipsecie 1;
:global webproxyie 0;
##----------Configuracion de servicios en interfaces externas de confianza------------##
##
#Habilita o deshabilita servicios en las interfaces externas de confianza
#Valor 1; habilitado, valor 0 deshabilitado
##
:global testvelocidadiec 0;
:global ospfiec 0;
:global bgpiec 1;
:global dnsiec 0;
:global dhcpiec 0;
:global snmpiec 0;
:global mndpiec 0;
:global winboxiec 1;
:global sshiec 1;
:global httpiec 1;
:global ntpiec 0;
:global radiusiec 0;
:global socksiec 0;
:global smbiec 0;
:global l2tpiec 0;
:global pptpiec 0;
:global greiec 0;
:global ipseciec 0;
:global webproxyiec 0;
#
##--------------__Version 6.1 __-------------####
#
##----------Configuracion de redes o IPs de confianza------------##
:global bogons10 1;
:global bogons172 1;
:global bogons192 1;
:global bogons100 1;
##