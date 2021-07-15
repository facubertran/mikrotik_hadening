#Filter
/ip firewall filter remove [find chain~"_Crenein"]
/ip firewall filter remove [find jump-target~"_Crenein"]
/ip firewall filter remove [find comment~"Crenein"]
#Address-List
/ip firewall address-list
remove [find dynamic=yes]
remove [find list=F_OrigenesPermitidos]
remove [find list=FN_RedesPublicasPropias]
remove [find list=F_OrigenesPermitidos]
remove [find list=F_ProteccionBGP_IPsPermitidas]
remove [find list=F_ListaBlancaAPIMikrotik]
remove [find list=F_ProteccionPublicasDentroDeLaRed]
remove [find list=F_ListaBlancaAPI]
remove [find list=F_ListaBlancaBGP]
remove [find list=F_ListaBlancaDNS]
remove [find list=F_ListaBlancaGRE]
remove [find list=F_ListaBlancaHTTP]
remove [find list=F_ListaBlancaIPSEC]
remove [find list=F_ListaBlancaL2TP]
remove [find list=F_ListaBlancaNTP]
remove [find list=F_ListaBlancaPPTP]
remove [find list=F_ListaBlancaRADIUS]
remove [find list=F_ListaBlancaSNMP]
remove [find list=F_ListaBlancaSOCKS]
remove [find list=F_ListaBlancaSSH]
remove [find list=F_ListaBlancaTestVelocidad]
remove [find list=F_ListaBlancaWebProxy]
remove [find list=F_ListaBlancaWinbox]
remove [find list=F_ListaNegraAPI]
remove [find list=F_ListaNegraBGP]
remove [find list=F_ListaNegraDNS]
remove [find list=F_ListaNegraGRE]
remove [find list=F_ListaNegraHTTP]
remove [find list=F_ListaNegraIPSEC]
remove [find list=F_ListaNegraL2TP]
remove [find list=F_ListaNegraNTP]
remove [find list=F_ListaNegraPPTP]
remove [find list=F_ListaNegraRADIUS]
remove [find list=F_ListaNegraSNMP]
remove [find list=F_ListaNegraSOCKS]
remove [find list=F_ListaNegraSSH]
remove [find list=F_ListaNegraTestVelocidad]
remove [find list=F_ListaNegraWebProxy]
remove [find list=F_ListaNegraWinbox]
#Interface-list-members
:do {/interface list member remove [find list=InterfacesExternas]} on-error {};
:do {/interface list member remove [find list=InterfacesExternasDeConfianza]} on-error {};
:do {/interface list member remove [find list=InterfacesInternas]} on-error {};
#Interface-list
:do {/interface list remove InterfacesExternas} on-error {};
:do {/interface list remove InterfacesExternasDeConfianza} on-error {};
:do {/interface list remove InterfacesInternas} on-error {};
#Routes
/ip route remove [find comment=Bogons]
#Scripts-Scheduler
:do {/system script remove EdgeHardeningInstall_Crenein} on-error {};
:do {/system script remove F_ListaNegraGeneral} on-error {};
:do {/system scheduler remove F_ListaNegraGeneral} on-error {};
#System
/ip settings
set tcp-syncookies=no