## hardening de router de borde Mikrotik

##Comando de instalacion luego de subir archivos.

```
/system script remove preinstall
/system script add name=preinstall owner=admin \
source=[/file get mikrotik-edge-hardening/preinstall.rsc content]}
/system script run preinstall
/system script remove preinstall
```