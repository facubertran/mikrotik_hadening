#Filter
/ip firewall filter remove [find chain~"_Crenein"]
/ip firewall filter remove [find jump-target~"_Crenein"]
/ip firewall filter remove [find comment~"Crenein"]
#Address-List
/ip firewall address-list
remove [find list=F_OrigenesPermitidos]
remove [find list=FN_RedesPublicasPropias]
remove [find list=F_OrigenesPermitidos]
remove [find list=F_ProteccionBGP_IPsPermitidas]
remove [find list=F_ListaBlancaAPIMikrotik]
remove [find list=F_ProteccionPublicasDentroDeLaRed]
#Interface-list-members
/interface list member
remove [find list=InterfacesExternas]
remove [find list=InterfacesExternasDeConfianza]
remove [find list=InterfacesInternas]
#Interface-list
/interface list
remove InterfacesExternas
remove InterfacesExternasDeConfianza
remove InterfacesInternas
#Routes
/ip route remove [find comment=Bogons]
#Scripts-Scheduler
/system script remove EdgeHardeningInstall_Crenein
/system script remove F_ListaNegraGeneral
/system scheduler remove F_ListaNegraGeneral
#System
/ip settings
set tcp-syncookies=no