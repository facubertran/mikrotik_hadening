##Crea script de enviroment
:do { /system script \
add name=EdgeHardeningEnviroment_Crenein owner=admin \
source=[/file get mikrotik-edge-hardening/router-enviroment.rsc content]} \
on-error={:put "No se puedo crear el script EdgeHardeningEnviroment_Crenein"};

##Crea script de instalacion
:do {/system script remove EdgeHardeningInstall_Crenein} \
on-error={:put "No se puedo eliminar el script EdgeHardeningInstall_Crenein"}
/system script
add name=EdgeHardeningInstall_Crenein owner=admin \
source=[/file get mikrotik-edge-hardening/install.rsc content];