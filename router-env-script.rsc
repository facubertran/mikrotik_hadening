##Crea script con enviroment
:do {/system script remove CreneinEdgeHarderingEnviroment} on-error={}
/system script
add name=CreneinEdgeHarderingEnviroment owner=admin \
source=[/file get mikrotik-edge-hardering/router-enviroment.rsc content];