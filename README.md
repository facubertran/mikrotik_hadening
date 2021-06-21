## hardening de router de borde Mikrotik

##Comando de instalacion luego de subir archivos.

1. Descargar archivos de github
2. Subir carpeta a files dentro del RB
3. Ejecutar los siguientes comandos:
```
/system script remove preinstall
/system script add name=preinstall owner=admin \
source=[/file get mikrotik-edge-hardening/preinstall.rsc content]}
/system script run preinstall
/system script remove preinstall
```
4. Completar script de entorno "EdgeHardeningEnviroment_Crenein"
5. Ejecutar script de instalacion "EdgeHardeningInstall_Crenein"
```
/system script run EdgeHardeningInstall_Crenein
```
6. Deshabilitar los accepts "DeshabilitarFirewal_Crenein" para encender el firewall. Son 2