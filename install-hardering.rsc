##Instalacion de RSCs
:put "Import Router Enviroment"
/import mikrotik-edge-hardering/router-enviroment.rsc
:put "Import Router Enviroment Script"
/import mikrotik-edge-hardering/router-env-script.rsc
:put "Import Interface-List"
/import mikrotik-edge-hardering/interface-list.rsc
:put "Import Address-Lists"
/import mikrotik-edge-hardering/address-lists.rsc
:put "Import Filter-Forward"
/import mikrotik-edge-hardering/filter-forward.rsc
:put "Import Filter-Input"
/import mikrotik-edge-hardering/filter-input.rsc
:if ([pick [/system resource get version] 0 1] = "6") do={
:put "Import Routes v6"
/import mikrotik-edge-hardering/routes-v6.rsc
}
:if ([pick [/system resource get version] 0 1] = "7") do={
:put "Import Routes v7"
/import mikrotik-edge-hardering/routes-v7.rsc
}
:put "Import Scripts"
/import mikrotik-edge-hardering/script-scheduler.rsc
:put "Import System"
/import mikrotik-edge-hardering/system.rsc
:put "Import Install Hardering"