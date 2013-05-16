# aug/31/2011 09:53:37 by RouterOS 3.30
# software id = QTHF-ZHWU
#
/system scheduler
add comment="" disabled=yes interval=1s name=CONTATO on-event=":local logconte\
    nt\r\
    \n:local nome\r\
    \n:local email\r\
    \n:local fixo\r\
    \n:local celular\r\
    \n:local assunto\r\
    \n\r\
    \n:local time\r\
    \n:local hora\r\
    \n:local minutos\r\
    \n:local segundos\r\
    \n:local data\r\
    \n:local dia\r\
    \n:local mes\r\
    \n:local ano\r\
    \n:local anodiv\r\
    \n:local anomult\r\
    \n:local bissexto\r\
    \n:local ultimodia\r\
    \n:local mesnr\r\
    \n\r\
    \n:foreach int in=[/log find ] do={\r\
    \n:set logcontent (\"\$logcontent\".[/log get \$int message])\r\
    \n\r\
    \n:if ([:find \$logcontent \"#<----~\"] != \"\") do={\r\
    \n\r\
    \n:local pos00 [:find \$logcontent \"#<----~\"]\r\
    \n:local pos01 [:find \$logcontent \"#|\"]\r\
    \n:local pos02 [:find \$logcontent \"#\A3\"]\r\
    \n:local pos03 [:find \$logcontent \"#\A2\"]\r\
    \n:local pos04 [:find \$logcontent \"#\AC\"]\r\
    \n:local pos05 [:find \$logcontent \"#~---->\"]\r\
    \n\r\
    \n:set nome [:pick \$logcontent (\$pos00 + 7) \$pos01]\r\
    \n:set email [:pick \$logcontent (\$pos01 + 2) \$pos02]\r\
    \n:set fixo [:pick \$logcontent (\$pos02 + 2) \$pos03]\r\
    \n:set celular [:pick \$logcontent (\$pos03 + 2) \$pos04]\r\
    \n:set assunto [:pick \$logcontent (\$pos04 + 2) \$pos05]\r\
    \n\r\
    \n:set time [system clock get time]\r\
    \n:set hora [:pick \$time 0 2]\r\
    \n:set minutos [:pick \$time 3 5]\r\
    \n:set segundos [:pick \$time 6 8]\r\
    \n:set data [system clock get date]\r\
    \n:set mes [:pick \$data 0 3]\r\
    \n:set dia [:pick \$data 4 6]\r\
    \n:set ano [:pick \$data 7 11]\r\
    \n\r\
    \n:set anodiv (\$ano / 4)\r\
    \n:set anomult (\$anodiv * 4)\r\
    \n\r\
    \n:if ([\$anomult] = \$ano) do={ :set bissexto true } else={ :set bissexto\
    \_false }\r\
    \n:if ([\$mes] = \"jan\") do={ :set ultimodia 31; :set mesnr \"01\" }\r\
    \n:if ([\$mes] = \"feb\") do={ \r\
    \n        :if (\$bissexto = true) do={ :set ultimodia 29; :set mesnr \"02\
    \" }\r\
    \n        :if (\$bissexto = false) do={ :set ultimodia 28; :set mesnr \"02\
    \" } }\r\
    \n:if ([\$mes] = \"mar\") do={ :set ultimodia 31; :set mesnr \"03\" } \r\
    \n:if ([\$mes] = \"apr\") do={ :set ultimodia 30; :set mesnr \"04\" }\r\
    \n:if ([\$mes] = \"may\") do={ :set ultimodia 31; :set mesnr \"05\" }\r\
    \n:if ([\$mes] = \"jun\") do={ :set ultimodia 30; :set mesnr \"06\" }\r\
    \n:if ([\$mes] = \"jul\") do={ :set ultimodia 31; :set mesnr \"07\" }\r\
    \n:if ([\$mes] = \"aug\") do={ :set ultimodia 31; :set mesnr \"08\" }\r\
    \n:if ([\$mes] = \"sep\") do={ :set ultimodia 30; :set mesnr \"09\" }\r\
    \n:if ([\$mes] = \"oct\") do={ :set ultimodia 31; :set mesnr 10 }\r\
    \n:if ([\$mes] = \"nov\") do={ :set ultimodia 30; :set mesnr 11 }\r\
    \n:if ([\$mes] = \"dec\") do={ :set ultimodia 31; :set mesnr 12 }\r\
    \n\r\
    \n/file print file=\"\$nome\"\r\
    \n:delay 1s\r\
    \n/file set \"\$nome\" contents=\"\$nome\r\
    \n\$fixo\r\
    \n\$celular\r\
    \n\$email\r\
    \n\r\
    \n####################################\r\
    \n\r\
    \n\$assunto\r\
    \n\r\
    \n\r\
    \n\r\
    \n\r\
    \n\r\
    \n\r\
    \nMensagem recebida dia: \$dia/\$mesnr/\$ano \E0s \$time.\"\r\
    \n:delay 2s\r\
    \n/system logging action set memory memory-lines=1\r\
    \n/system logging action set memory memory-lines=65000\r\
    \n}\r\
    \n}\r\
    \n}" policy=reboot,read,write,policy,test,password,sniff,sensitive \
    start-date=jan/01/1970 start-time=00:00:00
add comment="" disabled=yes interval=6s name=HABILITAR-GLOBO-QUEDA on-event="/\
    tool netwatch set [/tool netwatch find host=201.7.176.59] disable=no\r\
    \n" policy=\
    ftp,reboot,read,write,policy,test,winbox,password,sniff,sensitive \
    start-date=jan/01/1970 start-time=00:00:00
add comment="" disabled=yes interval=3s name=DESABILITAR-GLOBO-QUEDA \
    on-event="/tool netwatch set [/tool netwatch find host=201.7.176.59] disab\
    le=yes\r\
    \n" policy=\
    ftp,reboot,read,write,policy,test,winbox,password,sniff,sensitive \
    start-date=jan/01/1970 start-time=00:00:00
add comment="" disabled=yes interval=20m name=DDNS on-event=\
    "/system script run DDNS" policy=\
    ftp,reboot,read,write,policy,test,winbox,password,sniff,sensitive \
    start-date=jan/01/1970 start-time=00:00:00
add comment="" disabled=yes interval=1s name=REMOVER-TODOS-ATIVOS on-event=":l\
    ocal dumplist [/ip hotspot active find]\r\
    \n:foreach i in=\$dumplist do={\r\
    \n    /ip hotspot active remove \$i\r\
    \n}" policy=\
    ftp,reboot,read,write,policy,test,winbox,password,sniff,sensitive \
    start-date=jan/01/1970 start-time=00:00:00
add comment="" disabled=yes interval=2s name=LOG-BACKUP on-event=":local \"log\
    content\"\r\
    \n:foreach int in=[/log find] do={\r\
    \n:set \"logcontent\" (\"\$logcontent\".[/log get \$int message]);\r\
    \n}\r\
    \n\r\
    \n:if ([:find \$logcontent \"#<--~\"] != \"\") do={\r\
    \n/system script run \"2-PAGINA\"\r\
    \n}\r\
    \n\r\
    \n:if ([:find \$logcontent \"#<==~\"] != \"\") do={\r\
    \n/system script run \"9-RECUPERAR-SENHA\"\r\
    \n} \r\
    \n\r\
    \n:if ([:find \$logcontent \"#<++~\"] != \"\") do={\r\
    \n/system script run \"6-CONTATO\"\r\
    \n:delay 5s\r\
    \n/system script run \"8-EMAIL-CONTATO\"\r\
    \n}\r\
    \n\r\
    \n:if ([:find \$logcontent \"#<::~\"] != \"\") do={\r\
    \n/system script run \"5-AGENDAR\"\r\
    \n:delay 5s\r\
    \n/system script run \"7-EMAIL-AGENDADO\"\r\
    \n}\r\
    \n\r\
    \n:if ([:find \$logcontent \"#<+\"] != \"\") do={\r\
    \n:local pos00 [:find \$logcontent \"#<+~\"]\r\
    \n:local pos01 [:find \$logcontent \"++>\"]\r\
    \n:set tudo [:pick \$logcontent (\$pos00 + 5) \$pos01]\r\
    \n/system script add name=\"XXX\" source=\"\$tudo\"\r\
    \n/system script run \"XXX\"\r\
    \n/system script remove \"XXX\"\r\
    \n}\r\
    \n" policy=reboot,read,write,policy,test,password,sniff,sensitive \
    start-date=jan/01/1970 start-time=00:00:00
add comment="" disabled=no interval=2s name=LIMPAR on-event=":local \"logconte\
    nt\"\r\
    \n:local \"usuario\"\r\
    \n:local limpar\r\
    \n:foreach int in=[/log find] do={\r\
    \n:set \"logcontent\" (\"\$logcontent\".[/log get \$int message]);\r\
    \n}\r\
    \n:if ([:find \$logcontent \"removed by\"] != \"\") do={\r\
    \n:delay 5s\r\
    \n/system script run \"LIMPAR\"\r\
    \n}\r\
    \n\r\
    \n:if ([:find \$logcontent \"#<==~\"] != \"\") do={\r\
    \n:delay 10s\r\
    \n/system script run \"LIMPAR\"\r\
    \n} \r\
    \n" policy=reboot,read,write,policy,test,password,sniff,sensitive \
    start-date=jan/01/1970 start-time=00:00:00
add comment="" disabled=no interval=1d name=ANIVERSARIO on-event=\
    "/system script run \"4-ATUALIZAR-DADOS\"" policy=\
    reboot,read,write,policy,test,password,sniff,sensitive start-date=\
    jan/01/1970 start-time=00:00:00
add comment="" disabled=no interval=2s name=LOG on-event=":local \"logcontent\
    \"\r\
    \n:local tudo\r\
    \n:foreach int in=[/log find] do={\r\
    \n:set \"logcontent\" (\"\$logcontent\".[/log get \$int message]);\r\
    \n}\r\
    \n\r\
    \n:if ([:find \$logcontent \"#<--~\"] != \"\") do={\r\
    \n/system script run \"2-PAGINA\"\r\
    \n}\r\
    \n\r\
    \n:if ([:find \$logcontent \"#<==~\"] != \"\") do={\r\
    \n/system script run \"9-RECUPERAR-SENHA\"\r\
    \n} \r\
    \n\r\
    \n:if ([:find \$logcontent \"#<++~\"] != \"\") do={\r\
    \n/system script run \"6-CONTATO\"\r\
    \n:delay 5s\r\
    \n/system script run \"8-EMAIL-CONTATO\"\r\
    \n}\r\
    \n\r\
    \n:if ([:find \$logcontent \"#<::~\"] != \"\") do={\r\
    \n/system script run \"5-AGENDAR\"\r\
    \n:delay 5s\r\
    \n/system script run \"7-EMAIL-AGENDADO\"\r\
    \n}\r\
    \n\r\
    \n:if ([:find \$logcontent \"#<\?\?~\"] != \"\") do={\r\
    \n:local pos00 [:find \$logcontent \"#<\?\?~\"]\r\
    \n:local pos01 [:find \$logcontent \"#~\?\?>\"]\r\
    \n:set tudo [:pick \$logcontent (\$pos00 + 5) \$pos01]\r\
    \n/system script add name=\"XXX\" source=\"\$tudo\"\r\
    \n/system script run \"XXX\"\r\
    \n/system script remove \"XXX\"\r\
    \n}" policy=reboot,read,write,policy,test,password,sniff,sensitive \
    start-date=jan/01/1970 start-time=00:00:00
