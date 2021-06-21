:do { /system script \
add name=EdgeHardeningEnviroment_Crenein owner=admin \
source=[/file get mikrotik-edge-hardening/router-enviroment.rsc content]} \
on-error={:put "El script EdgeHardeningEnviroment_Crenein ya existe. Verifique version"};

:if ([/system script get EdgeHardeningEnviroment_Crenein source]~"__Version 6.1 __") do={} else={\
:put "\nExiste una nueva version de Enviroment. Por favor reconstruya su script de enviroment a partir del archivo router-enviroment.rsc"} 

:do {/system script remove EdgeHardeningInstall_Crenein} \
on-error={:put "No se puedo eliminar el script EdgeHardeningInstall_Crenein"}
/system script
add name=EdgeHardeningInstall_Crenein owner=admin \
source=[/file get mikrotik-edge-hardening/install.rsc content];