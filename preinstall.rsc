##Crea script de enviroment
:do {/system script remove EdgehardeningEnviroment_Crenein} on-error={}
/system script
add name=EdgehardeningEnviroment_Crenein owner=admin \
source=[/file get mikrotik-edge-hardening/router-enviroment.rsc content];

##Crea script de instalacion
:do {/system script remove EdgeHardeningInstall_Crenein} on-error={}
/system script
add name=EdgeHardeningInstall_Crenein owner=admin \
source=[/file get mikrotik-edge-hardening/install.rsc content];