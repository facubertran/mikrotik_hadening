#Variables globales
:global redespublicas; :global publicasdentrodelared; :global redesdeorigenpermitidas;
#
:global testvelocidadlb;:global bgplb;:global dnslb;:global snmplb;:global winboxlb;:global apilb;
:global sshlb;:global httplb;:global ntplb;:global radiuslb;:global sockslb;:global l2tplb;
:global pptplb;:global grelb;:global ipseclb;:global webproxylb;
#
:global testvelocidadln;:global bgpln;:global dnsln;:global snmpln;:global winboxln;:global apiln;
:global sshln;:global httpln;:global ntpln;:global radiusln;:global socksln;:global l2tpln;
:global pptpln;:global greln;:global ipsecln;:global webproxyln;
##Menu address-list
/ip firewall address-list
##Redes que se permiten navegar
/ip firewall address-list remove [find list=F_OrigenesPermitidos]
:do {add address=10.0.0.0/8 list=F_OrigenesPermitidos} \
on-error={:put "INFO - El address-list address=10.0.0.0/8 list=F_OrigenesPermitidos ya existe o no se puede crear"}
:do {add address=172.16.0.0/12 list=F_OrigenesPermitidos}  \
on-error={:put "INFO - El address-list address=172.16.0.0/12 list=F_OrigenesPermitidos ya existe o no se puede crear"}
:do {add address=192.168.0.0/16 list=F_OrigenesPermitidos}  \
on-error={:put "INFO - El address-list address=192.168.0.0/16 list=F_OrigenesPermitidos ya existe o no se puede crear"}
:do {add address=100.64.0.0/10 list=F_OrigenesPermitidos}  \
on-error={:put "INFO - El address-list address=192.168.0.0/16 list=F_OrigenesPermitidos ya existe o no se puede crear"}
##Redes que se permiten navegar personalizadas
:foreach alpp in=$redesdeorigenpermitidas do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_OrigenesPermitidos \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_OrigenesPermitidos ya existe o no se puede crear"}}}
##Redes publicas propias
/ip firewall address-list remove [find list=FN_RedesPublicasPropias]
:foreach alpp in=$redespublicas do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=FN_RedesPublicasPropias \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=FN_RedesPublicasPropias ya existe o no se puede crear"}}}
:foreach alpp in=$redespublicas do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_OrigenesPermitidos \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_OrigenesPermitidos ya existe o no se puede crear"}}}
##Publicas dentro de la red a bloquear
/ip firewall address-list remove [find list=F_ProteccionPublicasDentroDeLaRed]
:foreach alpp in=$publicasdentrodelared do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ProteccionPublicasDentroDeLaRed \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ProteccionPublicasDentroDeLaRed ya existe o no se puede crear"}}}
##TestVelocidad
/ip firewall address-list remove [find list=F_ListaBlancaTestVelocidad]
:foreach alpp in=$testvelocidadlb do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaBlancaTestVelocidad \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaTestVelocidad ya existe o no se puede crear"}}}
#
/ip firewall address-list remove [find list=F_ListaNegraTestVelocidad]
:foreach alpp in=$testvelocidadln do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaNegraTestVelocidad \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaTestVelocidad ya existe o no se puede crear"}}}
##BGP
/ip firewall address-list remove [find list=F_ListaBlancaBGP]
:foreach alpp in=$bgplb do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaBlancaBGP \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaBGP ya existe o no se puede crear"}}}
#
/ip firewall address-list remove [find list=F_ListaNegraBGP]
:foreach alpp in=$bgpln do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaNegraBGP \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaBGP ya existe o no se puede crear"}}}
##DNS
/ip firewall address-list remove [find list=F_ListaBlancaDNS]
:foreach alpp in=$dnslb do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaBlancaDNS \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaDNS ya existe o no se puede crear"}}}
#
/ip firewall address-list remove [find list=F_ListaNegraDNS]
:foreach alpp in=$dnsln do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaNegraDNS \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaDNS ya existe o no se puede crear"}}}
##SNMP
/ip firewall address-list remove [find list=F_ListaBlancaSNMP]
:foreach alpp in=$snmplb do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaBlancaSNMP \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaSNMP ya existe o no se puede crear"}}}
#
/ip firewall address-list remove [find list=F_ListaNegraSNMP]
:foreach alpp in=$snmpln do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaNegraSNMP \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaSNMP ya existe o no se puede crear"}}}
##Winbox
/ip firewall address-list remove [find list=F_ListaBlancaWinbox]
:foreach alpp in=$winboxlb do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaBlancaWinbox \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaWinbox ya existe o no se puede crear"}}}
#
/ip firewall address-list remove [find list=F_ListaNegraWinbox]
:foreach alpp in=$winboxln do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaNegraWinbox \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaWinbox ya existe o no se puede crear"}}}
##API
/ip firewall address-list remove [find list=F_ListaBlancaAPI]
:foreach alpp in=$apilb do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaBlancaAPI \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaAPI ya existe o no se puede crear"}}}
#
/ip firewall address-list remove [find list=F_ListaNegraAPI]
:foreach alpp in=$apiln do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaNegraAPI \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaAPI ya existe o no se puede crear"}}}
##HTTP
/ip firewall address-list remove [find list=F_ListaBlancaHTTP]
:foreach alpp in=$httplb do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaBlancaHTTP \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaHTTP ya existe o no se puede crear"}}}
#
/ip firewall address-list remove [find list=F_ListaNegraHTTP]
:foreach alpp in=$httpln do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaNegraHTTP \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaHTTP ya existe o no se puede crear"}}}
##SSH
/ip firewall address-list remove [find list=F_ListaBlancaSSH]
:foreach alpp in=$sshlb do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaBlancaSSH \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaSSH ya existe o no se puede crear"}}}
#
/ip firewall address-list remove [find list=F_ListaNegraSSH]
:foreach alpp in=$sshln do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaNegraSSH \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaSSH ya existe o no se puede crear"}}}
##NTP
/ip firewall address-list remove [find list=F_ListaBlancaNTP]
:foreach alpp in=$ntplb do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaBlancaNTP \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaNTP ya existe o no se puede crear"}}}
#
/ip firewall address-list remove [find list=F_ListaNegraNTP]
:foreach alpp in=$ntpln do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaNegraNTP \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaNTP ya existe o no se puede crear"}}}
##RADIUS
/ip firewall address-list remove [find list=F_ListaBlancaRADIUS]
:foreach alpp in=$radiuslb do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaBlancaRADIUS \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaRADIUS ya existe o no se puede crear"}}}
#
/ip firewall address-list remove [find list=F_ListaNegraRADIUS]
:foreach alpp in=$radiusln do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaNegraRADIUS \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaRADIUS ya existe o no se puede crear"}}}
##SOCKS
/ip firewall address-list remove [find list=F_ListaBlancaSOCKS]
:foreach alpp in=$sockslb do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaBlancaSOCKS \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaSOCKS ya existe o no se puede crear"}}}
#
/ip firewall address-list remove [find list=F_ListaNegraSOCKS]
:foreach alpp in=$socksln do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaNegraSOCKS \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaSOCKS ya existe o no se puede crear"}}}
##L2TP
/ip firewall address-list remove [find list=F_ListaBlancaL2TP]
:foreach alpp in=$l2tplb do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaBlancaL2TP \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaL2TP ya existe o no se puede crear"}}}
#
/ip firewall address-list remove [find list=F_ListaNegraL2TP]
:foreach alpp in=$l2tpln do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaNegraL2TP \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaL2TP ya existe o no se puede crear"}}}
##PPTP
/ip firewall address-list remove [find list=F_ListaBlancaPPTP]
:foreach alpp in=$pptplb do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaBlancaPPTP \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaPPTP ya existe o no se puede crear"}}}
#
/ip firewall address-list remove [find list=F_ListaNegraPPTP]
:foreach alpp in=$pptpln do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaNegraPPTP \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaPPTP ya existe o no se puede crear"}}}
##GRE
/ip firewall address-list remove [find list=F_ListaBlancaGRE]
:foreach alpp in=$grelb do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaBlancaGRE \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaGRE ya existe o no se puede crear"}}}
#
/ip firewall address-list remove [find list=F_ListaNegraGRE]
:foreach alpp in=$greln do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaNegraGRE \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaGRE ya existe o no se puede crear"}}}
##IPSEC
/ip firewall address-list remove [find list=F_ListaBlancaIPSEC]
:foreach alpp in=$ipseclb do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaBlancaIPSEC \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaIPSEC ya existe o no se puede crear"}}}
#
/ip firewall address-list remove [find list=F_ListaNegraIPSEC]
:foreach alpp in=$ipsecln do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaNegraIPSEC \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaIPSEC ya existe o no se puede crear"}}}
##WebProxy
/ip firewall address-list remove [find list=F_ListaBlancaWebProxy]
:foreach alpp in=$webproxylb do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaBlancaWebProxy \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaBlancaWebProxy ya existe o no se puede crear"}}}
#
/ip firewall address-list remove [find list=F_ListaNegraWebProxy]
:foreach alpp in=$webproxyln do={:if ([:pick $alpp] != "") do={:do {/ip firewall address-list add list=F_ListaNegraWebProxy \
address=$alpp} on-error={:put "INFO - El address-list address=$alpp list=F_ListaNegraWebProxy ya existe o no se puede crear"}}}
