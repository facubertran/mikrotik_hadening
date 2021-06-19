:global interfacesexternas; :global interfacesexternasdeconfianza
/interface list
:do {add name=InterfacesInternas} on-error={:put "no se pudo crear el InterfaceList InterfacesInternas"}
:do {add name=InterfacesExternas} on-error={:put "no se pudo crear el InterfaceList InterfacesExternas"}
:do {add name=InterfacesExternasDeConfianza} on-error={:put "no se pudo crear el InterfaceList InterfacesExternasDeConfianza"}
##Agregado automático de todas las interfaces como Internas
/
:if ([:len [/interface list member find list~"Interfaces"]] = 0) do={\
:foreach if in=[/interface find] do=\
{interface list member add list=InterfacesInternas interface=[/interface get $if name]}}