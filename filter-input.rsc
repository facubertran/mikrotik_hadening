#Variables globales a utilizar
:global portknoking;
:global creneinagent;
##Configuraicon
/ip firewall filter
add action=accept chain=input comment=DeshabilitarFirewal_Crenein disabled=no
add action=passthrough chain=input comment="Proteccion de Input - Crenein v6.0"
add action=jump chain=input comment=ReconocimientoParaAccesoPublico_Crenein dst-port=($portknoking->"port1") jump-target=ReconocimientoParaAccesoPublico_Crenein protocol=tcp
add action=jump chain=input comment=ReconocimientoParaAccesoPublico_Crenein dst-port=($portknoking->"port2") jump-target=ReconocimientoParaAccesoPublico_Crenein protocol=tcp
add action=add-src-to-address-list address-list=F_ReconocimientoParaAccesoPublico_Fase1 address-list-timeout=1m chain=ReconocimientoParaAccesoPublico_Crenein dst-port=($portknoking->"port1") \
    protocol=tcp
add action=add-src-to-address-list address-list=F_PermitidoPorReconocimientoParaAccesoPublico address-list-timeout=30m chain=ReconocimientoParaAccesoPublico_Crenein \
    dst-port=($portknoking->"port2") protocol=tcp src-address-list=F_ReconocimientoParaAccesoPublico_Crenein_Fase1
add action=return chain=ReconocimientoParaAccesoPublico_Crenein
add action=jump chain=input comment=ProteccionTestVelocidadMikrotik_Crenein dst-port=2000 jump-target=ProteccionTestVelocidadMikrotik_Crenein protocol=tcp
add action=jump chain=input dst-port=2000 jump-target=ProteccionTestVelocidadMikrotik_Crenein protocol=udp
add action=accept chain=ProteccionTestVelocidadMikrotik_Crenein disabled=yes in-interface-list=InterfacesInternas
add action=drop chain=ProteccionTestVelocidadMikrotik_Crenein
add action=jump chain=input comment=ProteccionGeneralDeEntrada_Crenein jump-target=ProteccionGeneralDeEntrada_Crenein
add action=accept chain=ProteccionGeneralDeEntrada_Crenein src-address-list=F_PermitidoPorReconocimientoParaAccesoPublico_Crenein
add action=reject chain=ProteccionGeneralDeEntrada_Crenein reject-with=icmp-host-unreachable src-address-list=F_DeteccionEscaneoDePuertos
add action=return chain=ProteccionGeneralDeEntrada_Crenein connection-state=new limit=150,20:packet
add action=jump chain=input comment=ProteccionTCPGeneralDeEntrada_Crenein jump-target=ProteccionTCPGeneralDeEntrada_Crenein protocol=tcp
add action=drop chain=ProteccionTCPGeneralDeEntrada_Crenein connection-state=new protocol=tcp tcp-flags=!syn
add action=add-src-to-address-list address-list=F_DeteccionEscaneoDePuertos address-list-timeout=1w3d chain=ProteccionTCPGeneralDeEntrada_Crenein in-interface-list=\
    InterfacesExternas protocol=tcp psd=21,3s,3,1
add action=return chain=ProteccionTCPGeneralDeEntrada_Crenein
add action=jump chain=input comment=ProteccionPING_Crenein icmp-options=0:0-255 jump-target=ProteccionPING_Crenein protocol=icmp
add action=jump chain=input icmp-options=8:0-255 jump-target=ProteccionPING_Crenein protocol=icmp
add action=accept chain=ProteccionPING_Crenein limit=80,5:packet packet-size=!128-65535
add action=drop chain=ProteccionPING_Crenein
add action=jump chain=input comment=ProteccionOSPF_Crenein jump-target=ProteccionOSPF_Crenein protocol=ospf
add action=accept chain=ProteccionOSPF_Crenein disabled=yes in-interface-list=InterfacesInternas
add action=drop chain=ProteccionOSPF_Crenein
add action=jump chain=input comment=ProteccionBGP_Crenein jump-target=ProteccionBGP_Crenein port=179 protocol=tcp
add action=accept chain=ProteccionBGP_Crenein src-address-list=F_ProteccionBGP_IPsPermitidas
add action=accept chain=ProteccionBGP_Crenein in-interface-list=InterfacesInternas
add action=drop chain=ProteccionBGP_Crenein
add action=jump chain=input comment=ProteccionDNS_Crenein jump-target=ProteccionDNS_Crenein port=53 protocol=udp
add action=jump chain=input jump-target=ProteccionDNS_Crenein port=53 protocol=tcp
add action=accept chain=ProteccionDNS_Crenein disabled=yes in-interface-list=InterfacesInternas
add action=accept chain=ProteccionDNS_Crenein in-interface-list=InterfacesExternas protocol=udp src-port=53
add action=drop chain=ProteccionDNS_Crenein
add action=jump chain=input comment=ProteccionSNMP_Crenein dst-port=161 jump-target=ProteccionSNMP_Crenein protocol=udp
add action=accept chain=ProteccionSNMP_Crenein in-interface-list=InterfacesInternas
add action=drop chain=ProteccionSNMP_Crenein
add action=jump chain=input comment=ProteccionDHCP_Crenein jump-target=ProteccionDHCP_Crenein port=67,68 protocol=udp
add action=accept chain=ProteccionDHCP_Crenein disabled=yes in-interface-list=InterfacesInternas
add action=drop chain=ProteccionDHCP_Crenein
add action=jump chain=input comment=ProteccionSSH_Crenein dst-port=[/ip service get 3 port] jump-target=ProteccionSSH_Crenein protocol=tcp
add action=accept chain=ProteccionSSH_Crenein comment=CreneinService src-address=$creneinagent
add action=drop chain=ProteccionSSH_Crenein src-address-list=F_ListaNegraSSH
add action=add-src-to-address-list address-list=F_ListaNegraSSH address-list-timeout=1w3d chain=ProteccionSSH_Crenein connection-state=new src-address-list=\
    F_ProteccionSSH_Crenein_Intento3
add action=add-src-to-address-list address-list=F_ProteccionSSH_Crenein_Intento3 address-list-timeout=1m chain=ProteccionSSH_Crenein connection-state=new src-address-list=\
    F_ProteccionSSH_Crenein_Intento2
add action=add-src-to-address-list address-list=F_ProteccionSSH_Crenein_Intento2 address-list-timeout=1m chain=ProteccionSSH_Crenein connection-state=new src-address-list=\
    F_ProteccionSSH_Crenein_Intento1
add action=add-src-to-address-list address-list=F_ProteccionSSH_Crenein_Intento1 address-list-timeout=1m chain=ProteccionSSH_Crenein connection-state=new
add action=accept chain=ProteccionSSH_Crenein
add action=drop chain=ProteccionSSH_Crenein
add action=jump chain=input comment=ProteccionWinbox_Crenein dst-port=[/ip service get 6 port] jump-target=ProteccionWinbox_Crenein protocol=tcp
add action=drop chain=ProteccionWinbox_Crenein src-address-list=F_ListaNegraWinBox
add action=accept chain=ProteccionWinbox_Crenein in-interface-list=InterfacesInternas
add action=accept chain=ProteccionWinbox_Crenein in-interface-list=InterfacesExternasDeConfianza
add action=accept chain=ProteccionWinbox_Crenein disabled=yes in-interface=all-ppp
add action=drop chain=ProteccionWinbox_Crenein
[:local a [/ip service get 5 port];[:local b [/ip service get 7 port]; :global apiserv ($a.",".$b)]]
add action=jump chain=input comment=ProteccionAPIMikrotik_Crenein dst-port=$apiserv jump-target=ProteccionAPIMikrotik_Crenein protocol=tcp
/system script environment remove [find name="apiserv"]
add action=drop chain=ProteccionAPIMikrotik_Crenein src-address-list=F_ListaNegraAPIMikrotik
add action=accept chain=ProteccionAPIMikrotik_Crenein src-address-list=F_ListaBlancaAPIMikrotik
add action=drop chain=ProteccionAPIMikrotik_Crenein
[:local a [/ip service get 2 port];[:local b [/ip service get 4 port]; :global wwwserv ($a.",".$b)]]
add action=jump chain=input comment=ProteccionHTTP_Crenein dst-port=$wwwserv jump-target=ProteccionHTTP_Crenein protocol=tcp
/system script environment remove [find name="wwwserv"]
add action=accept chain=ProteccionHTTP_Crenein disabled=yes in-interface-list=InterfacesInternas
add action=drop chain=ProteccionHTTP_Crenein
add action=jump chain=input comment=ProteccionNTP_Crenein jump-target=ProteccionNTP_Crenein port=123 protocol=udp
add action=accept chain=ProteccionNTP_Crenein in-interface-list=InterfacesInternas
add action=drop chain=ProteccionNTP_Crenein
add action=jump chain=input comment=ProteccionRADIUS_Crenein jump-target=ProteccionRADIUS_Crenein port=1812,1813 protocol=udp
add action=accept chain=ProteccionRADIUS_Crenein disabled=yes in-interface-list=InterfacesInternas
add action=drop chain=ProteccionRADIUS_Crenein
add action=jump chain=input comment=ProteccionDescubrimientoMikrotik_Crenein jump-target=ProteccionDescubrimientoMikrotik_Crenein port=5678 protocol=udp
add action=accept chain=ProteccionDescubrimientoMikrotik_Crenein in-interface-list=InterfacesInternas
add action=drop chain=ProteccionDescubrimientoMikrotik_Crenein
add action=jump chain=input comment=ProteccionSOCKS_Crenein dst-port=[/ip socks get port]  jump-target=ProteccionSOCKS_Crenein protocol=tcp
add action=accept chain=ProteccionSOCKS_Crenein in-interface-list=InterfacesExternasDeConfianza
add action=drop chain=ProteccionSOCKS_Crenein
add action=jump chain=input comment=ProteccionSMB_Crenein dst-port=135-139,445 jump-target=ProteccionSMB_Crenein protocol=tcp
add action=accept chain=ProteccionSMB_Crenein disabled=yes in-interface-list=InterfacesExternasDeConfianza
add action=drop chain=ProteccionSMB_Crenein
add action=jump chain=input comment=ProteccionPPTP_Crenein dst-port=1723 jump-target=ProteccionPPTP_Crenein protocol=tcp
add action=drop chain=ProteccionPPTP_Crenein src-address-list=F_ListaNegraVPN
add action=accept chain=ProteccionPPTP_Crenein in-interface-list=InterfacesExternas
add action=drop chain=ProteccionPPTP_Crenein
add action=jump chain=input comment=ProteccionGRE_Crenein jump-target=ProteccionGRE_Crenein protocol=gre
add action=drop chain=ProteccionGRE_Crenein src-address-list=F_ListaNegraVPN
add action=accept chain=ProteccionGRE_Crenein in-interface-list=InterfacesExternas
add action=drop chain=ProteccionGRE_Crenein
add action=jump chain=input comment=ProteccionL2TP_Crenein dst-port=1701 jump-target=ProteccionL2TP_Crenein protocol=udp
add action=drop chain=ProteccionL2TP_Crenein src-address-list=F_ListaNegraVPN
add action=accept chain=ProteccionL2TP_Crenein in-interface-list=InterfacesExternas
add action=drop chain=ProteccionL2TP_Crenein
add action=jump chain=input comment=ProteccionIPSEC_Crenein dst-port=500 jump-target=ProteccionIPSEC_Crenein protocol=udp
add action=jump chain=input jump-target=ProteccionIPSEC_Crenein protocol=ipsec-esp
add action=jump chain=input jump-target=ProteccionIPSEC_Crenein protocol=ipsec-ah
add action=drop chain=ProteccionIPSEC_Crenein src-address-list=F_ListaNegraVPN
add action=accept chain=ProteccionIPSEC_Crenein in-interface-list=InterfacesExternas
add action=drop chain=ProteccionIPSEC_Crenein
add action=jump chain=input comment=ProteccionWebProxy_Crenein dst-port=[/ip proxy get port] jump-target=ProteccionWebProxy_Crenein protocol=tcp
add action=accept chain=ProteccionWebProxy_Crenein disabled=yes in-interface-list=InterfacesInternas
add action=drop chain=ProteccionWebProxy_Crenein