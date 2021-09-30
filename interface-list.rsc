:global interfacesexternas; :global interfacesexternasdeconfianza
/interface list
:do {add name=InterfacesInternas} on-error={:put "INFO -  El InterfaceList InterfacesInternas ya existe"}
:do {add name=InterfacesExternas} on-error={:put "INFO - El InterfaceList InterfacesExternas ya existe"}
:do {add name=InterfacesExternasDeConfianza} on-error={:put "INFO - El InterfaceList InterfacesExternasDeConfianza ya existe"}
##Agregado automático de todas las interfaces como Internas
/interface list member remove [/interface list member find]
/
:foreach ie in=$interfacesexternas do={:if ([:len $ie] > 2) do={/interface list member add list=InterfacesExternas interface=$ie}}
:foreach iec in=$interfacesexternasdeconfianza do={:if ([:len $iec] > 2) do={/interface list member add list=InterfacesExternasDeConfianza interface=$iec}}
:foreach ii in=[/interface find dynamic!=yes] do={:if ([:len [/interface list member find interface=[/interface get $ii name]]] = 0) do={\
/interface list member add list=InterfacesInternas interface=$ii}}