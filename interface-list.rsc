/interface list
add name=InterfacesInternas
add name=InterfacesExternas
add name=InterfacesExternasDeConfianza
##Agregado automático de todas las interfaces como Internas
/
:foreach if in=[/interface find] do={interface list member add list=InterfacesInternas interface=[/interface get $if name]}