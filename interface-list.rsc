:global interfacesexternas; :global interfacesexternasdeconfianza
/interface list
:do {add name=InterfacesInternas} on-error={:put "no se pudo crear el InterfaceList InterfacesInternas"}
:do {add name=InterfacesExternas} on-error={:put "no se pudo crear el InterfaceList InterfacesExternas"}
:do {add name=InterfacesExternasDeConfianza} on-error={:put "no se pudo crear el InterfaceList InterfacesExternasDeConfianza"}
##Agregado automático de todas las interfaces como Internas
/interface list member remove [/interface list member find]
/
:foreach if in=[/interface find] do={\
interface list member add list=InterfacesInternas interface=[/interface get $if name]}}
:foreach ifext in=$interfacesexternas do={\
[/interface list member set list=InterfacesExternas \
[/interface list member find interface=$ifext]]}