:do { /system script \
add name=EdgeHardeningEnviroment_Crenein owner=admin \
source=[/file get mikrotik-edge-hardening/router-enviroment.rsc content]} \
on-error={:put "WARNING - El script EdgeHardeningEnviroment_Crenein ya existe."}

:if ([/system script get EdgeHardeningEnviroment_Crenein source]~"__Version 6.1 __") do={} else={\
:put "\nWARNING - Existe una nueva version de Enviroment. Por favor reconstruya su script de enviroment a partir del archivo router-enviroment.rsc"} 

:do {/system script remove EdgeHardeningInstall_Crenein} \
on-error={:put "INFO - El script EdgeHardeningInstall_Crenein no se pudo eliminar porque no existe"}
/system script
add name=EdgeHardeningInstall_Crenein owner=admin \
source=[/file get mikrotik-edge-hardening/install.rsc content]