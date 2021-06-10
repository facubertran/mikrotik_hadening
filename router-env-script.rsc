##Crea script con enviroment
:do {/system script remove CreneinEdgehardeningEnviroment} on-error={}
/system script
add name=CreneinEdgehardeningEnviroment owner=admin \
source=[/file get mikrotik-edge-hardening/router-enviroment.rsc content];