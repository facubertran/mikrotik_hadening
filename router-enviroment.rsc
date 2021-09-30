##-----------__Version 6.5 __-------------####
##
#Registra los puertos para port-knoking
##
##----------Configuracion de redes o IPs de confianza------------##
:global portknoking {port1="1"; port2="2"};
##
##--------Configuracion login failure API------##
:global loginfailureapi 0; #-- 1 habilitado 0 deshabilitado
##--------Configuracion de reconocimiento de login fallido api------##
:global intentosfallidos 3;
##--------Configuracion lista negra general------##
:global listanegragral 0; #-- 1 habilitado 0 deshabilitado
##----------Configuracion de redes o IPs de confianza------------##
#Registra las redes o IPs de confianza
##----------Configuracion listas generales------------##
:global redespublicas {""}
:global redesdeorigenpermitidas {""}
:global origenespermitidosnewnodnat {""}; #-Permite conexiones del exterior a redes privadas
:global publicasdentrodelared {""}
##----------Configuracion bogons------------##
#Crea o no bogons de redes privadas y CGNAT
:global bogons10 1;
:global bogons172 1;
:global bogons192 1;
:global bogons100 1;
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
:global smtp 0;
##----------Configuracion de servicios------------##
##
#Habilita o deshabilita servicios en las interfaces. Valor 1; habilitado, valor 0 deshabilitado.
#Crea listas blancas y negras para control por IP. Si la lista esta vacia la regla no se activa.
##
#TestVelocidad
:global testvelocidadln {""}; #Lista Negra
:global testvelocidadlb {""}; #Lista Blanca
:global testvelocidadii 1; #Interfaces Internas
:global testvelocidadie 0; #Interfaces Externas
:global testvelocidadiec 0; #Interfaces ExternasDeConfianza
#OSPF
:global ospfii 1; #Interfaces Internas
:global ospfie 0; #Interfaces Externas
:global ospfiec 0; #Interfaces ExternasDeConfianza
#BGP
:global bgpln {""};
:global bgplb {""};
:global bgpii 1;
:global bgpie 0;
:global bgpiec 1;
#DNS
:global dnsln {""};
:global dnslb {""};
:global dnsii 1;
:global dnsiec 0;
#DCHP
:global dhcpii 1;
:global dhcpie 1;
:global dhcpiec 0;
#SNMP
:global snmpln {""};
:global snmplb {""};
:global snmpii 1;
:global snmpie 0;
:global snmpiec 0;
#MNDP
:global mndpii 1;
:global mndpie 0;
:global mndpiec 0;
#Winbox
:global winboxln {""};
:global winboxlb {""};
:global winboxii 1;
:global winboxie 0;
:global winboxiec 1;
#API
:global apiln {""};
:global apilb {""};
:global apiii 0;
:global apiie 0;
:global apiiec 0;
#SSH
:global sshln {""};
:global sshlb {"10.0.0.0/8"};
:global sshii 1;
:global sshie 1;
:global sshiec 1;
#HTTP
:global httpln {""};
:global httplb {""};
:global httpii 1;
:global httpie 0;
:global httpiec 0;
#NTP
:global ntpln {""};
:global ntplb {""};
:global ntpii 1;
:global ntpie 0;
:global ntpiec 0;
#RADIUS
:global radiusln {""};
:global radiuslb {""};
:global radiusii 0;
:global radiusie 0;
:global radiusiec 0;
#SOCKS
:global socksln {""};
:global sockslb {""};
:global socksii 0;
:global socksie 0;
:global socksiec 0;
#SMB
:global smbii 0;
:global smbie 0;
:global smbiec 0;
#L2TP
:global l2tpln {""};
:global l2tplb {""};
:global l2tpii 0;
:global l2tpie 1;
:global l2tpiec 0;
#PPTP
:global pptpln {""};
:global pptplb {""};
:global pptpii 0;
:global pptpie 1;
:global pptpiec 0;
#GRE
:global greln {""};
:global grelb {""};
:global greii 0;
:global greie 1;
:global greiec 0;
#IPSEC
:global ipsecln {""};
:global ipseclb {""};
:global ipsecii 0;
:global ipsecie 1;
:global ipseciec 0;
#WebProxy
:global webproxyln {""};
:global webproxylb {""};
:global webproxyii 0;
:global webproxyie 0;
:global webproxyiec 0;
