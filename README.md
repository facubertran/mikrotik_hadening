# Hardening de router de borde Mikrotik
#### Esta configuracion fue desarrollada desde 0 por Facundo Bertran para Crenein SAS.
#### Su uso es libre y muestra la capacidad de control de routers Mikrotik.
#### Si desea asesoria técnica para su ISP o red empresarial puede comunicarse via whatsapp a+5493725409044

## Procedimiento de instalación.

1. Descargar archivos de github
2. Renombre la carpeta que contiene los archivos rsc como "mikrotik-edge-hardening"
3. Subir carpeta a files dentro del RB
4. Ejecutar los siguientes comandos:
```
/system script remove preinstall
/system script add name=preinstall owner=admin \
source=[/file get mikrotik-edge-hardening/preinstall.rsc content]}
/system script run preinstall
/system script remove preinstall
```
5. Completar script de entorno "EdgeHardeningEnviroment_Crenein"
6. Ejecutar script de instalacion "EdgeHardeningInstall_Crenein"
```
/system script run EdgeHardeningInstall_Crenein
```
7. Deshabilitar los accepts "DeshabilitarFirewal_Crenein" para encender el firewall. Son 2