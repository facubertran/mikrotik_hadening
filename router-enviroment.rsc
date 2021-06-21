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
:global redespublicas {"45.70.8.76"; "45.70.8.41"}
:global redesdeorigenpermitidas {"45.70.8.76"; "45.70.8.41"}
:global ipspermitidasebgp {"45.70.8.1"}
:global listablancaapi {"149.46.68.55"; "141.69.8.66"}
:global publicasdentrodelared {"45.70.8.76"}
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
:global socksii 1;
:global smbii 1;
:global l2tpii 1;
:global pptpii 1;
:global greii 1;
:global ipsecii 1;
:global webproxyii 1;
##----------Configuracion de servicios en interfaces externas------------##
##
#Habilita o deshabilita servicios en las interfaces externas
#Valor 1; habilitado, valor 0 deshabilitado
##
:global testvelocidadie 1;
:global ospfie 1;
:global bgpie 1;
:global dhcpie 1;
:global snmpie 1;
:global mndpie 1;
:global winboxie 1;
:global sshie 1;
:global httpie 1;
:global ntpie 1;
:global radiusie 1;
:global socksie 1;
:global smbie 1;
:global l2tpie 1;
:global pptpie 1;
:global greie 1;
:global ipsecie 1;
:global webproxyie 1;
##----------Configuracion de servicios en interfaces externas de confianza------------##
##
#Habilita o deshabilita servicios en las interfaces externas de confianza
#Valor 1; habilitado, valor 0 deshabilitado
##
:global testvelocidadiec 1;
:global ospfiec 1;
:global bgpiec 1;
:global dnsiec 1;
:global dhcpiec 1;
:global snmpiec 1;
:global mndpiec 1;
:global winboxiec 1;
:global sshiec 1;
:global httpiec 1;
:global ntpiec 1;
:global radiusiec 1;
:global socksiec 1;
:global smbiec 1;
:global l2tpiec 1;
:global pptpiec 1;
:global greiec 1;
:global ipseciec 1;
:global webproxyiec 1;
#
##--------------__Version 6.1 __-------------####
#
##----------Configuracion de redes o IPs de confianza------------##
:global bogons10 1;
:global bogons172 1;
:global bogons192 1;
:global bogons100 1;
##