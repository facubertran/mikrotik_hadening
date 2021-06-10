#Variables globales a utilizar
:global portknoking;
:global creneinagent;
##Configuraicon
/ip firewall filter
add action=accept chain=input comment=DeshabilitarFirewal disabled=no
add action=passthrough chain=input comment="Proteccion de Input - Crenein"
add action=jump chain=input comment=ReconocimientoParaAccesoPublico dst-port=($portknoking->"port1") jump-target=ReconocimientoParaAccesoPublico protocol=tcp
add action=jump chain=input comment=ReconocimientoParaAccesoPublico dst-port=($portknoking->"port2") jump-target=ReconocimientoParaAccesoPublico protocol=tcp
add action=add-src-to-address-list address-list=F_ReconocimientoParaAccesoPublico_Fase1 address-list-timeout=1m chain=ReconocimientoParaAccesoPublico dst-port=($portknoking->"port1") \
    protocol=tcp
add action=add-src-to-address-list address-list=F_PermitidoPorReconocimientoParaAccesoPublico address-list-timeout=30m chain=ReconocimientoParaAccesoPublico \
    dst-port=($portknoking->"port2") protocol=tcp src-address-list=F_ReconocimientoParaAccesoPublico_Fase1
add action=return chain=ReconocimientoParaAccesoPublico
add action=jump chain=input comment=ProteccionTestVelocidadMikrotik dst-port=2000 jump-target=ProteccionTestVelocidadMikrotik protocol=tcp
add action=jump chain=input dst-port=2000 jump-target=ProteccionTestVelocidadMikrotik protocol=udp
add action=accept chain=ProteccionTestVelocidadMikrotik disabled=yes in-interface-list=InterfacesInternas
add action=drop chain=ProteccionTestVelocidadMikrotik
add action=jump chain=input comment=ProteccionGeneralDeEntrada jump-target=ProteccionGeneralDeEntrada
add action=accept chain=ProteccionGeneralDeEntrada src-address-list=F_PermitidoPorReconocimientoParaAccesoPublico
add action=reject chain=ProteccionGeneralDeEntrada reject-with=icmp-host-unreachable src-address-list=F_DeteccionEscaneoDePuertos
add action=return chain=ProteccionGeneralDeEntrada connection-state=new limit=150,20:packet
add action=jump chain=input comment=ProteccionTCPGeneralDeEntrada jump-target=ProteccionTCPGeneralDeEntrada protocol=tcp
add action=drop chain=ProteccionTCPGeneralDeEntrada connection-state=new protocol=tcp tcp-flags=!syn
add action=add-src-to-address-list address-list=F_DeteccionEscaneoDePuertos address-list-timeout=1w3d chain=ProteccionTCPGeneralDeEntrada in-interface-list=\
    InterfacesExternas protocol=tcp psd=21,3s,3,1
add action=return chain=ProteccionTCPGeneralDeEntrada
add action=jump chain=input comment=ProteccionPING icmp-options=0:0-255 jump-target=ProteccionPING protocol=icmp
add action=jump chain=input icmp-options=8:0-255 jump-target=ProteccionPING protocol=icmp
add action=accept chain=ProteccionPING limit=80,5:packet packet-size=!128-65535
add action=drop chain=ProteccionPING
add action=jump chain=input comment=ProteccionOSPF jump-target=ProteccionOSPF protocol=ospf
add action=accept chain=ProteccionOSPF disabled=yes in-interface-list=InterfacesInternas
add action=drop chain=ProteccionOSPF
add action=jump chain=input comment=ProteccionBGP jump-target=ProteccionBGP port=179 protocol=tcp
add action=accept chain=ProteccionBGP src-address-list=F_ProteccionBGP_IPsPermitidas
add action=accept chain=ProteccionBGP in-interface-list=InterfacesInternas
add action=drop chain=ProteccionBGP
add action=jump chain=input comment=ProteccionDNS jump-target=ProteccionDNS port=53 protocol=udp
add action=jump chain=input jump-target=ProteccionDNS port=53 protocol=tcp
add action=accept chain=ProteccionDNS disabled=yes in-interface-list=InterfacesInternas
add action=accept chain=ProteccionDNS in-interface-list=InterfacesExternas protocol=udp src-port=53
add action=drop chain=ProteccionDNS
add action=jump chain=input comment=ProteccionSNMP dst-port=161 jump-target=ProteccionSNMP protocol=udp
add action=accept chain=ProteccionSNMP in-interface-list=InterfacesInternas
add action=drop chain=ProteccionSNMP
add action=jump chain=input comment=ProteccionDHCP jump-target=ProteccionDHCP port=67,68 protocol=udp
add action=accept chain=ProteccionDHCP disabled=yes in-interface-list=InterfacesInternas
add action=drop chain=ProteccionDHCP
add action=jump chain=input comment=ProteccionSSH dst-port=[/ip service get 3 port] jump-target=ProteccionSSH protocol=tcp
add action=accept chain=ProteccionSSH comment=CreneinService src-address=$creneinagent
add action=drop chain=ProteccionSSH src-address-list=F_ListaNegraSSH
add action=add-src-to-address-list address-list=F_ListaNegraSSH address-list-timeout=1w3d chain=ProteccionSSH connection-state=new src-address-list=\
    F_ProteccionSSH_Intento3
add action=add-src-to-address-list address-list=F_ProteccionSSH_Intento3 address-list-timeout=1m chain=ProteccionSSH connection-state=new src-address-list=\
    F_ProteccionSSH_Intento2
add action=add-src-to-address-list address-list=F_ProteccionSSH_Intento2 address-list-timeout=1m chain=ProteccionSSH connection-state=new src-address-list=\
    F_ProteccionSSH_Intento1
add action=add-src-to-address-list address-list=F_ProteccionSSH_Intento1 address-list-timeout=1m chain=ProteccionSSH connection-state=new
add action=accept chain=ProteccionSSH
add action=drop chain=ProteccionSSH
add action=jump chain=input comment=ProteccionWinbox dst-port=[/ip service get 6 port] jump-target=ProteccionWinbox protocol=tcp
add action=drop chain=ProteccionWinbox src-address-list=F_ListaNegraWinBox
add action=accept chain=ProteccionWinbox in-interface-list=InterfacesInternas
add action=accept chain=ProteccionWinbox in-interface-list=InterfacesExternasDeConfianza
add action=accept chain=ProteccionWinbox disabled=yes in-interface=all-ppp
add action=drop chain=ProteccionWinbox
[:local a [/ip service get 5 port];[:local b [/ip service get 7 port]; :global apiserv ($a.",".$b)]]
add action=jump chain=input comment=ProteccionAPIMikrotik dst-port=$apiserv jump-target=ProteccionAPIMikrotik protocol=tcp
/system script environment remove [find name="apiserv"]
add action=drop chain=ProteccionAPIMikrotik src-address-list=F_ListaNegraAPIMikrotik
add action=accept chain=ProteccionAPIMikrotik src-address-list=F_ListaBlancaAPIMikrotik
add action=drop chain=ProteccionAPIMikrotik
[:local a [/ip service get 2 port];[:local b [/ip service get 4 port]; :global wwwserv ($a.",".$b)]]
add action=jump chain=input comment=ProteccionHTTP dst-port=$wwwserv jump-target=ProteccionHTTP protocol=tcp
/system script environment remove [find name="wwwserv"]
add action=accept chain=ProteccionHTTP disabled=yes in-interface-list=InterfacesInternas
add action=drop chain=ProteccionHTTP
add action=jump chain=input comment=ProteccionNTP jump-target=ProteccionNTP port=123 protocol=udp
add action=accept chain=ProteccionNTP in-interface-list=InterfacesInternas
add action=drop chain=ProteccionNTP
add action=jump chain=input comment=ProteccionRADIUS jump-target=ProteccionRADIUS port=1812,1813 protocol=udp
add action=accept chain=ProteccionRADIUS disabled=yes in-interface-list=InterfacesInternas
add action=drop chain=ProteccionRADIUS
add action=jump chain=input comment=ProteccionDescubrimientoMikrotik jump-target=ProteccionDescubrimientoMikrotik port=5678 protocol=udp
add action=accept chain=ProteccionDescubrimientoMikrotik in-interface-list=InterfacesInternas
add action=drop chain=ProteccionDescubrimientoMikrotik
add action=jump chain=input comment=ProteccionSOCKS dst-port=[/ip socks get port]  jump-target=ProteccionSOCKS protocol=tcp
add action=accept chain=ProteccionSOCKS in-interface-list=InterfacesExternasDeConfianza
add action=drop chain=ProteccionSOCKS
add action=jump chain=input comment=ProteccionSMB dst-port=135-139,445 jump-target=ProteccionSMB protocol=tcp
add action=accept chain=ProteccionSMB disabled=yes in-interface-list=InterfacesExternasDeConfianza
add action=drop chain=ProteccionSMB
add action=jump chain=input comment=ProteccionPPTP dst-port=1723 jump-target=ProteccionPPTP protocol=tcp
add action=drop chain=ProteccionPPTP src-address-list=F_ListaNegraVPN
add action=accept chain=ProteccionPPTP in-interface-list=InterfacesExternas
add action=drop chain=ProteccionPPTP
add action=jump chain=input comment=ProteccionGRE jump-target=ProteccionGRE protocol=gre
add action=drop chain=ProteccionGRE src-address-list=F_ListaNegraVPN
add action=accept chain=ProteccionGRE in-interface-list=InterfacesExternas
add action=drop chain=ProteccionGRE
add action=jump chain=input comment=ProteccionL2TP dst-port=1701 jump-target=ProteccionL2TP protocol=udp
add action=drop chain=ProteccionL2TP src-address-list=F_ListaNegraVPN
add action=accept chain=ProteccionL2TP in-interface-list=InterfacesExternas
add action=drop chain=ProteccionL2TP
add action=jump chain=input comment=ProteccionIPSEC dst-port=500 jump-target=ProteccionIPSEC protocol=udp
add action=jump chain=input jump-target=ProteccionIPSEC protocol=ipsec-esp
add action=jump chain=input jump-target=ProteccionIPSEC protocol=ipsec-ah
add action=drop chain=ProteccionIPSEC src-address-list=F_ListaNegraVPN
add action=accept chain=ProteccionIPSEC in-interface-list=InterfacesExternas
add action=drop chain=ProteccionIPSEC
add action=jump chain=input comment=ProteccionWebProxy dst-port=[/ip proxy get port] jump-target=ProteccionWebProxy protocol=tcp
add action=accept chain=ProteccionWebProxy disabled=yes in-interface-list=InterfacesInternas
add action=drop chain=ProteccionWebProxy