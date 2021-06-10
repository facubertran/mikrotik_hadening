##Instalacion de RSCs
:put "Import Router Enviroment"
/import mikrotik-edge-hardening/router-enviroment.rsc
:put "Import Router Enviroment Script"
/import mikrotik-edge-hardening/router-env-script.rsc
:put "Import Interface-List"
/import mikrotik-edge-hardening/interface-list.rsc
:put "Import Address-Lists"
/import mikrotik-edge-hardening/address-lists.rsc
:put "Import Filter-Forward"
/import mikrotik-edge-hardening/filter-forward.rsc
:put "Import Filter-Input"
/import mikrotik-edge-hardening/filter-input.rsc
:if ([pick [/system resource get version] 0 1] = "6") do={
:put "Import Routes v6"
/import mikrotik-edge-hardening/routes-v6.rsc
}
:if ([pick [/system resource get version] 0 1] = "7") do={
:put "Import Routes v7"
/import mikrotik-edge-hardening/routes-v7.rsc
}
:put "Import Scripts"
/import mikrotik-edge-hardening/script-scheduler.rsc
:put "Import System"
/import mikrotik-edge-hardening/system.rsc
:put "Import Install hardening"