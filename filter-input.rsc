#Variables globales a utilizar
:global portknoking;
#
:global testvelocidadii ; :global ospfii ; :global bgpii ; :global dnsii ; :global dhcpii ;
:global snmpii ; :global mndpii ; :global winboxii ; :global sshii ; :global httpii ;
:global ntpii ; :global radiusii ; :global socksii ; :global smbii ; :global l2tpii ;
:global pptpii ; :global greii ; :global ipsecii ; :global webproxyii ; :global apiii ;
#
:global testvelocidadie ; :global ospfie ; :global bgpie ; :global dhcpie ; :global snmpie ;
:global mndpie ; :global winboxie ; :global sshie ; :global httpie ; :global ntpie ; :global radiusie ;
:global socksie ; :global smbie ; :global l2tpie ; :global pptpie ; :global greie ; :global ipsecie ; :global webproxyie ;
:global apiie;
#
:global testvelocidadiec ; :global ospfiec ; :global bgpiec ; :global dnsiec ; :global dhcpiec ;
:global snmpiec ; :global mndpiec ; :global winboxiec ; :global sshiec ; :global httpiec ; :global ntpiec ; :global radiusiec ;
:global socksiec ; :global smbiec ; :global l2tpiec ; :global pptpiec ; :global greiec ; :global ipseciec ; :global webproxyiec ;
:global apiiec;
#
:global testvelocidadlb;:global bgplb;:global dnslb;:global snmplb;:global winboxlb;:global apilb;
:global sshlb;:global httplb;:global ntplb;:global radiuslb;:global sockslb;:global l2tplb;
:global pptplb;:global grelb;:global ipseclb;:global webproxylb;
#
:global testvelocidadln;:global bgpln;:global dnsln;:global snmpln;:global winboxln;:global apiln;
:global sshln;:global httpln;:global ntpln;:global radiusln;:global socksln;:global l2tpln;
:global pptpln;:global greln;:global ipsecln;:global webproxyln;
##Configuraicon
/ip firewall filter
add action=accept chain=input comment=DeshabilitarFirewal_Crenein disabled=no
add action=passthrough chain=input comment="Proteccion de Input - Crenein v6.3"
add action=jump chain=input comment=ReconocimientoParaAccesoPublico_Crenein dst-port=($portknoking->"port1") jump-target=ReconocimientoParaAccesoPublico_Crenein protocol=tcp
add action=jump chain=input comment=ReconocimientoParaAccesoPublico_Crenein dst-port=($portknoking->"port2") jump-target=ReconocimientoParaAccesoPublico_Crenein protocol=tcp
add action=add-src-to-address-list address-list=F_ReconocimientoParaAccesoPublico_Fase1 address-list-timeout=1m chain=ReconocimientoParaAccesoPublico_Crenein dst-port=($portknoking->"port1") \
    protocol=tcp
add action=add-src-to-address-list address-list=F_PermitidoPorReconocimientoParaAccesoPublico address-list-timeout=30m chain=ReconocimientoParaAccesoPublico_Crenein \
    dst-port=($portknoking->"port2") protocol=tcp src-address-list=F_ReconocimientoParaAccesoPublico_Crenein_Fase1
add action=return chain=ReconocimientoParaAccesoPublico_Crenein
##Test de velocidad
add action=jump chain=input comment=ProteccionTestVelocidadMikrotik_Crenein dst-port=2000 jump-target=ProteccionTestVelocidadMikrotik_Crenein protocol=tcp
add action=jump chain=input dst-port=2000 jump-target=ProteccionTestVelocidadMikrotik_Crenein protocol=udp
#Control de IPs
:if ([:pick $testvelocidadln] != "") do={
    /ip firewall filter add chain=ProteccionTestVelocidadMikrotik_Crenein src-address-list=F_ListaNegraTestVelocidad action=drop;
}
:if ([:pick $testvelocidadlb] != "") do={
    /ip firewall filter add chain=ProteccionTestVelocidadMikrotik_Crenein src-address-list=F_ListaBlancaTestVelocidad action=accept;
}
#Control de interfaces
:if ($testvelocidadii=1) do={
    /ip firewall filter add action=accept chain=ProteccionTestVelocidadMikrotik_Crenein in-interface-list=InterfacesInternas
}
:if ($testvelocidadie=1) do={
    /ip firewall filter add action=accept chain=ProteccionTestVelocidadMikrotik_Crenein in-interface-list=InterfacesExternas
}
:if ($testvelocidadiec=1) do={
    /ip firewall filter add action=accept chain=ProteccionTestVelocidadMikrotik_Crenein in-interface-list=InterfacesExternasDeConfianza
}
add action=drop chain=ProteccionTestVelocidadMikrotik_Crenein
##Proteccion general
add action=jump chain=input comment=ProteccionGeneralDeEntrada_Crenein jump-target=ProteccionGeneralDeEntrada_Crenein
add action=accept chain=ProteccionGeneralDeEntrada_Crenein src-address-list=F_PermitidoPorReconocimientoParaAccesoPublico_Crenein
add action=reject chain=ProteccionGeneralDeEntrada_Crenein reject-with=icmp-host-unreachable src-address-list=F_DeteccionEscaneoDePuertos
add action=return chain=ProteccionGeneralDeEntrada_Crenein connection-state=new limit=150,20:packet
##Proteccion tcp
add action=jump chain=input comment=ProteccionTCPGeneralDeEntrada_Crenein jump-target=ProteccionTCPGeneralDeEntrada_Crenein protocol=tcp
add action=drop chain=ProteccionTCPGeneralDeEntrada_Crenein connection-state=new protocol=tcp tcp-flags=!syn
add action=add-src-to-address-list address-list=F_DeteccionEscaneoDePuertos address-list-timeout=1w3d chain=ProteccionTCPGeneralDeEntrada_Crenein in-interface-list=\
    InterfacesExternas protocol=tcp psd=21,3s,3,1
add action=return chain=ProteccionTCPGeneralDeEntrada_Crenein
##Ping
add action=jump chain=input comment=ProteccionPING_Crenein icmp-options=0:0-255 jump-target=ProteccionPING_Crenein protocol=icmp
add action=jump chain=input icmp-options=8:0-255 jump-target=ProteccionPING_Crenein protocol=icmp
add action=accept chain=ProteccionPING_Crenein limit=80,5:packet packet-size=!128-65535
add action=drop chain=ProteccionPING_Crenein
##OSPF
add action=jump chain=input comment=ProteccionOSPF_Crenein jump-target=ProteccionOSPF_Crenein protocol=ospf
#Control de interfaces
:if ($ospfii=1) do={
    /ip firewall filter add action=accept chain=ProteccionOSPF_Crenein disabled=$a in-interface-list=InterfacesInternas
}
:if ($ospfie=1) do={
    /ip firewall filter add action=accept chain=ProteccionOSPF_Crenein disabled=$a in-interface-list=InterfacesExternas
}
:if ($ospfiec=1) do={
    /ip firewall filter add action=accept chain=ProteccionOSPF_Crenein disabled=$a in-interface-list=InterfacesExternasDeConfianza
}
add action=drop chain=ProteccionOSPF_Crenein
##BGP
add action=jump chain=input comment=ProteccionBGP_Crenein jump-target=ProteccionBGP_Crenein port=179 protocol=tcp
#Control de IPs
:if ([:pick $bgpln] != "") do={
    /ip firewall filter add chain=ProteccionBGP_Crenein src-address-list=F_ListaNegraBGP action=drop;
}
:if ([:pick $bgplb] != "") do={
    /ip firewall filter add chain=ProteccionBGP_Crenein src-address-list=F_ListaBlancaBGP action=accept;
}
#Control de interfaces
:if ($bgpii=1) do={
    /ip firewall filter add action=accept chain=ProteccionBGP_Crenein in-interface-list=InterfacesInternas
}
:if ($bgpie=1) do={
    /ip firewall filter add action=accept chain=ProteccionBGP_Crenein in-interface-list=InterfacesExternas
}
:if ($bgpiec=1) do={
    /ip firewall filter add action=accept chain=ProteccionBGP_Crenein in-interface-list=InterfacesExternasDeConfianza
}
add action=drop chain=ProteccionBGP_Crenein
##DNS
add action=jump chain=input comment=ProteccionDNS_Crenein jump-target=ProteccionDNS_Crenein port=53 protocol=udp
add action=jump chain=input jump-target=ProteccionDNS_Crenein port=53 protocol=tcp
#Control de IPs
:if ([:pick $dnsln] != "") do={
    /ip firewall filter add chain=ProteccionDNS_Crenein src-address-list=F_ListaNegraDNS action=drop;
}
:if ([:pick $dnslb] != "") do={
    /ip firewall filter add chain=ProteccionDNS_Crenein src-address-list=F_ListaBlancaDNS action=accept;
}
#Control de interfaces
:if ($dnsii=1) do={
    /ip firewall filter add action=accept chain=ProteccionDNS_Crenein in-interface-list=InterfacesInternas
}
:if ($dnsiec=1) do={
    /ip firewall filter add action=accept chain=ProteccionDNS_Crenein in-interface-list=InterfacesExternasDeConfianza
}
add action=accept chain=ProteccionDNS_Crenein in-interface-list=InterfacesExternas protocol=udp src-port=53
add action=drop chain=ProteccionDNS_Crenein
##SNMP
add action=jump chain=input comment=ProteccionSNMP_Crenein dst-port=161 jump-target=ProteccionSNMP_Crenein protocol=udp
#Control de IPs
:if ([:pick $snmpln] != "") do={
    /ip firewall filter add chain=ProteccionSNMP_Crenein src-address-list=F_ListaNegraSNMP action=drop;
}
:if ([:pick $snmplb] != "") do={
    /ip firewall filter add chain=ProteccionSNMP_Crenein src-address-list=F_ListaBlancaSNMP action=accept;
}
#Control de interfaces
:if ($snmpii=1) do={
    /ip firewall filter add action=accept chain=ProteccionSNMP_Crenein in-interface-list=InterfacesInternas
}
:if ($snmpie=1) do={
    /ip firewall filter add action=accept chain=ProteccionSNMP_Crenein in-interface-list=InterfacesExternas
}
:if ($snmpiec=1) do={
    /ip firewall filter add action=accept chain=ProteccionSNMP_Crenein in-interface-list=InterfacesExternasDeConfianza
}
add action=drop chain=ProteccionSNMP_Crenein
##DHCP
add action=jump chain=input comment=ProteccionDHCP_Crenein jump-target=ProteccionDHCP_Crenein port=67,68 protocol=udp
#Control de interfaces
:if ($dhcpii=1) do={
    /ip firewall filter add action=accept chain=ProteccionDHCP_Crenein in-interface-list=InterfacesInternas
}
:if ($dhcpie=1) do={
    /ip firewall filter add action=accept chain=ProteccionDHCP_Crenein in-interface-list=InterfacesExternas
}
:if ($dhcpiec=1) do={
    /ip firewall filter add action=accept chain=ProteccionDHCP_Crenein in-interface-list=InterfacesExternasDeConfianza
}
add action=drop chain=ProteccionDHCP_Crenein
##Winbox
add action=jump chain=input comment=ProteccionWinbox_Crenein dst-port=[/ip service get 6 port] jump-target=ProteccionWinbox_Crenein protocol=tcp
#Control de IPs
:if ([:pick $winboxln] != "") do={
    /ip firewall filter add chain=ProteccionWinbox_Crenein src-address-list=F_ListaNegraWinbox action=drop;
}
:if ([:pick $winboxlb] != "") do={
    /ip firewall filter add chain=ProteccionWinbox_Crenein src-address-list=F_ListaBlancaWinbox action=accept;
}
#Control de interfaces
:if ($winboxii=1) do={
    /ip firewall filter add action=accept chain=ProteccionWinbox_Crenein in-interface-list=InterfacesInternas
}
:if ($winboxie=1) do={
    /ip firewall filter add action=accept chain=ProteccionWinbox_Crenein in-interface-list=InterfacesExternas
}
:if ($winboxiec=1) do={
    /ip firewall filter add action=accept chain=ProteccionWinbox_Crenein in-interface-list=InterfacesExternasDeConfianza
}
add action=drop chain=ProteccionWinbox_Crenein
##API
:foreach apis in=[/ip service find name~"api"] do= {
    /ip firewall filter add action=jump chain=input comment=ProteccionAPIMikrotik_Crenein \
    dst-port=[/ip service get $apis port] jump-target=ProteccionAPIMikrotik_Crenein protocol=tcp
}
#Control de IPs
/ip firewall filter add chain=ProteccionAPIMikrotik_Crenein src-address-list=F_ListaNegraAPI action=drop;
:if ([:pick $apilb] != "") do={
    /ip firewall filter add chain=ProteccionAPIMikrotik_Crenein src-address-list=F_ListaBlancaAPI action=accept;
}
#Control de interfaces
:if ($apiii=1) do={
    /ip firewall filter add action=accept chain=ProteccionAPIMikrotik_Crenein in-interface-list=InterfacesInternas
}
:if ($apiie=1) do={
    /ip firewall filter add action=accept chain=ProteccionAPIMikrotik_Crenein in-interface-list=InterfacesExternas
}
:if ($apiiec=1) do={
    /ip firewall filter add action=accept chain=ProteccionAPIMikrotik_Crenein in-interface-list=InterfacesExternasDeConfianza
}
add action=drop chain=ProteccionAPIMikrotik_Crenein
##HTTP
:foreach www in=[/ip service find name~"www"] do= {
    /ip firewall filter add action=jump chain=input comment=ProteccionHTTP_Crenein \
    dst-port=[/ip service get $www port] jump-target=ProteccionHTTP_Crenein protocol=tcp
}
#Control de IPs
:if ([:pick $httpln] != "") do={
    /ip firewall filter add chain=ProteccionHTTP_Crenein src-address-list=F_ListaNegraHTTP action=drop;
}
:if ([:pick $httplb] != "") do={
    /ip firewall filter add chain=ProteccionHTTP_Crenein src-address-list=F_ListaBlancaHTTP action=accept;
}
#Control de interfaces
:if ($httpii=1) do={
    /ip firewall filter add action=accept chain=ProteccionHTTP_Crenein in-interface-list=InterfacesInternas
}
:if ($httpie=1) do={
    /ip firewall filter add action=accept chain=ProteccionHTTP_Crenein in-interface-list=InterfacesExternas
}
:if ($httpiec=1) do={
    /ip firewall filter add action=accept chain=ProteccionHTTP_Crenein in-interface-list=InterfacesExternasDeConfianza
}
add action=drop chain=ProteccionHTTP_Crenein
##SSH
add action=jump chain=input comment=ProteccionSSH_Crenein dst-port=[/ip service get 3 port] jump-target=ProteccionSSH_Crenein protocol=tcp
#Control de IPs
/ip firewall filter add chain=ProteccionHTTP_Crenein src-address-list=F_ListaNegraSSH action=drop;
:if ([:pick $sshlb] != "") do={
    /ip firewall filter add chain=ProteccionHTTP_Crenein src-address-list=F_ListaBlancaSSH action=accept;
}
#Control login fallidos
add action=add-src-to-address-list address-list=F_ListaNegraSSH address-list-timeout=1w3d chain=ProteccionSSH_Crenein connection-state=new src-address-list=\
    F_ProteccionSSH_Crenein_Intento3
add action=add-src-to-address-list address-list=F_ProteccionSSH_Crenein_Intento3 address-list-timeout=1m chain=ProteccionSSH_Crenein connection-state=new src-address-list=\
    F_ProteccionSSH_Crenein_Intento2
add action=add-src-to-address-list address-list=F_ProteccionSSH_Crenein_Intento2 address-list-timeout=1m chain=ProteccionSSH_Crenein connection-state=new src-address-list=\
    F_ProteccionSSH_Crenein_Intento1
add action=add-src-to-address-list address-list=F_ProteccionSSH_Crenein_Intento1 address-list-timeout=1m chain=ProteccionSSH_Crenein connection-state=new
#Control de interfaces
:if ($sshii=1) do={
    /ip firewall filter add action=accept chain=F_ProteccionSSH_Crenein in-interface-list=InterfacesInternas
}
:if ($sshie=1) do={
    /ip firewall filter add action=accept chain=F_ProteccionSSH_Crenein in-interface-list=InterfacesExternas
}
:if ($sshiec=1) do={
    /ip firewall filter add action=accept chain=F_ProteccionSSH_Crenein in-interface-list=InterfacesExternasDeConfianza
}
add action=drop chain=ProteccionSSH_Crenein

##NTP
add action=jump chain=input comment=ProteccionNTP_Crenein jump-target=ProteccionNTP_Crenein port=123 protocol=udp
#Control de IPs
:if ([:pick $ntpln] != "") do={
    /ip firewall filter add chain=ProteccionNTP_Crenein src-address-list=F_ListaNegraNTP action=drop;
}
:if ([:pick $ntplb] != "") do={
    /ip firewall filter add chain=ProteccionNTP_Crenein src-address-list=F_ListaBlancaNTP action=accept;
}
#Control de interfaces
:if ($ntpii=1) do={
    /ip firewall filter add action=accept chain=ProteccionNTP_Crenein in-interface-list=InterfacesInternas
}
:if ($ntpie=1) do={
    /ip firewall filter add action=accept chain=ProteccionNTP_Crenein in-interface-list=InterfacesExternas
}
:if ($ntpiec=1) do={
    /ip firewall filter add action=accept chain=ProteccionNTP_Crenein in-interface-list=InterfacesExternasDeConfianza
}
add action=drop chain=ProteccionNTP_Crenein
##RADIUS
add action=jump chain=input comment=ProteccionRADIUS_Crenein jump-target=ProteccionRADIUS_Crenein port=1812,1813 protocol=udp
#Control de IPs
:if ([:pick $radiusln] != "") do={
    /ip firewall filter add chain=ProteccionRADIUS_Crenein src-address-list=F_ListaNegraRADIUS action=drop;
}
:if ([:pick $radiuslb] != "") do={
    /ip firewall filter add chain=ProteccionRADIUS_Crenein src-address-list=F_ListaBlancaRADIUS action=accept;
}
#Control de interfaces
:if ($radiusii=1) do={
    /ip firewall filter add action=accept chain=ProteccionRADIUS_Crenein in-interface-list=InterfacesInternas
}
:if ($radiusie=1) do={
    /ip firewall filter add action=accept chain=ProteccionRADIUS_Crenein in-interface-list=InterfacesExternas
}
:if ($radiusiec=1) do={
    /ip firewall filter add action=accept chain=ProteccionRADIUS_Crenein in-interface-list=InterfacesExternasDeConfianza
}
add action=drop chain=ProteccionRADIUS_Crenein
##MNDP
add action=jump chain=input comment=ProteccionDescubrimientoMikrotik_Crenein jump-target=ProteccionDescubrimientoMikrotik_Crenein port=5678 protocol=udp
#Control de interfaces
:if ($mndpii=1) do={
    /ip firewall filter add action=accept chain=ProteccionDescubrimientoMikrotik_Crenein in-interface-list=InterfacesInternas
}
:if ($mndpie=1) do={
    /ip firewall filter add action=accept chain=ProteccionDescubrimientoMikrotik_Crenein in-interface-list=InterfacesExternas
}
:if ($mndpic=1) do={
    /ip firewall filter add action=accept chain=ProteccionDescubrimientoMikrotik_Crenein in-interface-list=InterfacesExternasDeConfianza
}
add action=drop chain=ProteccionDescubrimientoMikrotik_Crenein
##SOCKS
add action=jump chain=input comment=ProteccionSOCKS_Crenein dst-port=[/ip socks get port]  jump-target=ProteccionSOCKS_Crenein protocol=tcp
#Control de IPs
:if ([:pick $socksln] != "") do={
    /ip firewall filter add chain=ProteccionSOCKS_Crenein src-address-list=F_ListaNegraSOCKS action=drop;
}
:if ([:pick $sockslb] != "") do={
    /ip firewall filter add chain=ProteccionSOCKS_Crenein src-address-list=F_ListaBlancaSOCKS action=accept;
}
#Control de interfaces
:if ($socksii=1) do={
    /ip firewall filter add action=accept chain=ProteccionSOCKS_Crenein in-interface-list=InterfacesInternas
}
:if ($socksie=1) do={
    /ip firewall filter add action=accept chain=ProteccionSOCKS_Crenein in-interface-list=InterfacesExternas
}
:if ($socksiec=1) do={
    /ip firewall filter add action=accept chain=ProteccionSOCKS_Crenein in-interface-list=InterfacesExternasDeConfianza
}
add action=drop chain=ProteccionSOCKS_Crenein
##SMB
add action=jump chain=input comment=ProteccionSMB_Crenein dst-port=135-139,445 jump-target=ProteccionSMB_Crenein protocol=tcp
#Control de interfaces
:if ($smbii=1) do={
    /ip firewall filter add action=accept chain=ProteccionSMB_Crenein in-interface-list=InterfacesInternas
}
:if ($smbie=1) do={
    /ip firewall filter add action=accept chain=ProteccionSMB_Crenein in-interface-list=InterfacesExternas
}
:if ($smbic=1) do={
    /ip firewall filter add action=accept chain=ProteccionSMB_Crenein in-interface-list=InterfacesExternasDeConfianza
}
add action=drop chain=ProteccionSMB_Crenein
##PPTP
add action=jump chain=input comment=ProteccionPPTP_Crenein dst-port=1723 jump-target=ProteccionPPTP_Crenein protocol=tcp
#Control de IPs
:if ([:pick $pptpln] != "") do={
    /ip firewall filter add chain=ProteccionPPTP_Crenein src-address-list=F_ListaNegraPPTP action=drop;
}
:if ([:pick $pptplb] != "") do={
    /ip firewall filter add chain=ProteccionPPTP_Crenein src-address-list=F_ListaBlancaPPTP action=accept;
}
#Control de interfaces
:if ($pptpii=1) do={
    /ip firewall filter add action=accept chain=ProteccionPPTP_Crenein in-interface-list=InterfacesInternas
}
:if ($pptpie=1) do={
    /ip firewall filter add action=accept chain=ProteccionPPTP_Crenein in-interface-list=InterfacesExternas
}
:if ($pptpiec=1) do={
    /ip firewall filter add action=accept chain=ProteccionPPTP_Crenein in-interface-list=InterfacesExternasDeConfianza
}
add action=drop chain=ProteccionPPTP_Crenein
##GRE
add action=jump chain=input comment=ProteccionGRE_Crenein jump-target=ProteccionGRE_Crenein protocol=gre
#Control de IPs
:if ([:pick $greln] != "") do={
    /ip firewall filter add chain=ProteccionGRE_Crenein src-address-list=F_ListaNegraGRE action=drop;
}
:if ([:pick $grelb] != "") do={
    /ip firewall filter add chain=ProteccionGRE_Crenein src-address-list=F_ListaBlancaGRE action=accept;
}
#Control de interfaces
:if ($greii=1) do={
    /ip firewall filter add action=accept chain=ProteccionGRE_Crenein in-interface-list=InterfacesInternas
}
:if ($greie=1) do={
    /ip firewall filter add action=accept chain=ProteccionGRE_Crenein in-interface-list=InterfacesExternas
}
:if ($greiec=1) do={
    /ip firewall filter add action=accept chain=ProteccionGRE_Crenein in-interface-list=InterfacesExternasDeConfianza
}
add action=drop chain=ProteccionGRE_Crenein

##L2TP
add action=jump chain=input comment=ProteccionL2TP_Crenein dst-port=1701 jump-target=ProteccionL2TP_Crenein protocol=udp
#Control de IPs
:if ([:pick $l2tpln] != "") do={
    /ip firewall filter add chain=ProteccionL2TP_Crenein src-address-list=F_ListaNegraL2TP action=drop;
}
:if ([:pick $l2tplb] != "") do={
    /ip firewall filter add chain=ProteccionL2TP_Crenein src-address-list=F_ListaBlancaL2TP action=accept;
}
#Control de interfaces
:if ($l2tpii=1) do={
    /ip firewall filter add action=accept chain=ProteccionL2TP_Crenein in-interface-list=InterfacesInternas
}
:if ($l2tpie=1) do={
    /ip firewall filter add action=accept chain=ProteccionL2TP_Crenein in-interface-list=InterfacesExternas
}
:if ($l2tpiec=1) do={
    /ip firewall filter add action=accept chain=ProteccionL2TP_Crenein in-interface-list=InterfacesExternasDeConfianza
}
add action=drop chain=ProteccionL2TP_Crenein
##IPSec
add action=jump chain=input comment=ProteccionIPSEC_Crenein dst-port=500 jump-target=ProteccionIPSEC_Crenein protocol=udp
add action=jump chain=input jump-target=ProteccionIPSEC_Crenein protocol=ipsec-esp
add action=jump chain=input jump-target=ProteccionIPSEC_Crenein protocol=ipsec-ah
#Control de IPs
:if ([:pick $ipsecln] != "") do={
    /ip firewall filter add chain=ProteccionIPSEC_Crenein src-address-list=F_ListaNegraIPSEC action=drop;
}
:if ([:pick $ipseclb] != "") do={
    /ip firewall filter add chain=ProteccionIPSEC_Crenein src-address-list=F_ListaBlancaIPSEC action=accept;
}
#Control de interfaces
:if ($ipsecii=1) do={
    /ip firewall filter add action=accept chain=ProteccionIPSEC_Crenein in-interface-list=InterfacesInternas
}
:if ($ipsecie=1) do={
    /ip firewall filter add action=accept chain=ProteccionIPSEC_Crenein in-interface-list=InterfacesExternas
}
:if ($ipseciec=1) do={
    /ip firewall filter add action=accept chain=ProteccionIPSEC_Crenein in-interface-list=InterfacesExternasDeConfianza
}
add action=drop chain=ProteccionIPSEC_Crenein
##WebProxy
:foreach wbp in=[/ip proxy get port] do= {
    /ip firewall filter add action=jump chain=input comment=ProteccionWebProxy_Crenein \
    dst-port=$wbp jump-target=ProteccionWebProxy_Crenein protocol=tcp
}
#Control de IPs
:if ([:pick $webproxyln] != "") do={
    /ip firewall filter add chain=ProteccionWebProxy_Crenein src-address-list=F_ListaNegraWebProxy action=drop;
}
:if ([:pick $webproxylb] != "") do={
    /ip firewall filter add chain=ProteccionWebProxy_Crenein src-address-list=F_ListaBlancaWebProxy action=accept;
}
#Control de interfaces
:if ($webproxyii=1) do={
    /ip firewall filter add action=accept chain=ProteccionWebProxy_Crenein in-interface-list=InterfacesInternas
}
:if ($webproxyie=1) do={
    /ip firewall filter add action=accept chain=ProteccionWebProxy_Crenein in-interface-list=InterfacesExternas
}
:if ($webproxyiec=1) do={
    /ip firewall filter add action=accept chain=ProteccionWebProxy_Crenein in-interface-list=InterfacesExternasDeConfianza
}
add action=drop chain=ProteccionWebProxy_Crenein