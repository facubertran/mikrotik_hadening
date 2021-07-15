#Get logs
:global intentosfallidos;
:global ultimologid;
:local alllogs [/log find];
:local countlogs [:len $alllogs];
:local newslogs [:pick $alllogs [find $alllogs $ultimologid] (($countlogs)-1)];
:global ultimologid [:pick $alllogs (($countlogs)-1)];
##Analisis de logs
:foreach auth in=$newslogs do={
  :local message [/log get $auth message];
  :if ($message ~ "login failure for user" and $message ~ "api") do={
    :local iponly [:pick [/log get $auth message ] 23 [:find [/log get $auth message ] " api"]];
    :local iponly2 [:pick $iponly [:find $iponly "m "] [:find $iponly " via"] ];
    :local iponly3 [:pick $iponly2 2 100];
    :if ([:len $iponly3] > 6) do={
      :local countip [:len [/log find $auth message ~ "login failure for user" ~ $iponly3 ~ "api"]];
      :if ($countip >= $intentosfallidos) do={
        :do {
          [/ip firewall address-list add list=F_ListaNegraAPI address=$iponly3];
        } on-error={:put "Error al agregar IP a lista. La IP $iponly3 ya existe."};
      }
    }
  }
}