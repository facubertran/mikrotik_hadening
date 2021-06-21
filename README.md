## hardening de router de borde Mikrotik

##Comando de instalacion luego de subir archivos.

1. Subir carpeta a files dentro del RB
2. Ejecutar los siguientes comandos:
```
/system script remove preinstall
/system script add name=preinstall owner=admin \
source=[/file get mikrotik-edge-hardening/preinstall.rsc content]}
/system script run preinstall
/system script remove preinstall
```
3. Completar script de entorno "EdgeHardeningEnviroment_Crenein"
4. Ejecutar script de instalacion "EdgeHardeningInstall_Crenein"
```
/system script run EdgeHardeningInstall_Crenein
```