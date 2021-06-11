##Instalacion de RSCs
:put "Setting Enviroment";
/system script run EdgeHardeningEnviroment_Crenein;
:put "Import Interface-List";
/import mikrotik-edge-hardening/interface-list.rsc
:put "Import Address-Lists";
/import mikrotik-edge-hardening/address-lists.rsc
:put "Purge Filter";
/ip firewall filter remove [find chain~"_Crenein"]
/ip firewall filter remove [find jump-target~"_Crenein"]
/ip firewall filter remove [find comment~"Crenein"]
:put "Import Filter-Forward";
/import mikrotik-edge-hardening/filter-forward.rsc
:put "Import Filter-Input";
/import mikrotik-edge-hardening/filter-input.rsc
:if ([pick [/system resource get version] 0 1] = "6") do={
:put "Import Routes v6";
/import mikrotik-edge-hardening/routes-v6.rsc
}
:if ([pick [/system resource get version] 0 1] = "7") do={
:put "Import Routes v7";
/import mikrotik-edge-hardening/routes-v7.rsc
}
:put "Import Scripts";
/import mikrotik-edge-hardening/script-scheduler.rsc
:put "Import System";
/import mikrotik-edge-hardening/system.rsc
:put "Import Install hardening";