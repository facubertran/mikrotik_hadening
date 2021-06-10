/interface list
:do {add name=InterfacesInternas} on-error={}
:do {add name=InterfacesExternas} on-error={}
:do {add name=InterfacesExternasDeConfianza} on-error={}
##Agregado automático de todas las interfaces como Internas
/
:if ([:len [/interface/list/member/find list~"Interfaces"]] = 0) {\
:foreach if in=[/interface find] do=\
{interface list member add list=InterfacesInternas interface=[/interface get $if name]}}