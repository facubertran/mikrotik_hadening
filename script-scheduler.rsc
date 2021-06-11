:do {/system script remove F_ListaNegraGeneral} on-error={:put "No se pudo eliminar el script F_ListaNegraGeneral"}
/system script
add name=F_ListaNegraGeneral source="ip firewall ad\
    dress-list\r\
    \n:local update do={\r\
    \n:do {\r\
    \n:local data ([:tool fetch url=\$url output=user as-value]->\"data\")\r\
    \nremove [find list=F_ListaNegraGeneral comment=\$description]\r\
    \n:while ([:len \$data]!=0) do={\r\
    \n:if ([:pick \$data 0 [:find \$data \"\\n\"]]~\"^[0-9]{1,3}\\\\.[0-9]{1,3}\\\\.[0-9]{1,3}\\\\.[0-9]{1,3}\") do={\r\
    \n:do {add list=F_ListaNegraGeneral address=([:pick \$data 0 [:find \$data \$delimiter]].\$cidr) comment=\$description timeout=1d} on-error={}\r\
    \n}\r\
    \n:set data [:pick \$data ([:find \$data \"\\n\"]+1) [:len \$data]]\r\
    \n}\r\
    \n} on-error={:log warning \"Address list <\$description> update failed\"}\r\
    \n}\r\
    \n\$update url=https://www.dshield.org/block.txt description=DShield delimiter=(\"\\t\") cidr=/24\r\
    \n\$update url=https://www.spamhaus.org/drop/drop.txt description=\"Spamhaus DROP\" delimiter=(\"\\_\")\r\
    \n\$update url=https://www.spamhaus.org/drop/edrop.txt description=\"Spamhaus EDROP\" delimiter=(\"\\_\")\r\
    \n\$update url=https://sslbl.abuse.ch/blacklist/sslipblacklist.txt description=\"Abuse.ch SSLBL\" delimiter=(\"\\r\")"
:execute "F_ListaNegraGeneral"

:do {/system scheduler remove F_ListaNegraGeneral} on-error={:put "No se pudo eliminar el scheduler F_ListaNegraGeneral"}
/system scheduler
add interval=1d name=F_ListaNegraGeneral on-event=F_ListaNegraGeneral start-date=\
    may/27/2021 start-time=19:56:16