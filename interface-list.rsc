:global interfacesexternas; :global interfacesexternasdeconfianza
/interface list
:do {add name=InterfacesInternas} on-error={:put "no se pudo crear el InterfaceList InterfacesInternas"}
:do {add name=InterfacesExternas} on-error={:put "no se pudo crear el InterfaceList InterfacesExternas"}
:do {add name=InterfacesExternasDeConfianza} on-error={:put "no se pudo crear el InterfaceList InterfacesExternasDeConfianza"}
##Agregado automático de todas las interfaces como Internas
/interface list member remove [/interface list member find]
/
:foreach ie in=$interfacesexternas do={/interface list member add list=InterfacesExternas interface=$ie}
:foreach iec in=$interfacesexternasdeconfianza do={/interface list member add list=InterfacesExternasDeConfianza interface=$iec}
:foreach ii in=[/interface find] do={:if ([:len [/interface list member find interface=[/interface get $ii name]]] = 0) do={\
/interface list member add list=InterfacesInternas interface=$ii}}