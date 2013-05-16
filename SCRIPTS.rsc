# aug/31/2011 09:53:03 by RouterOS 3.30
# software id = QTHF-ZHWU
#
/system script
add name=LIMPAR policy=\
    ftp,reboot,read,write,policy,test,winbox,password,sniff,sensitive source="\
    /system logging action set memory memory-lines=1\r\
    \n/system logging action set memory memory-lines=65000\r\
    \n"
add name=6-CONTATO policy=\
    ftp,reboot,read,write,policy,test,winbox,password,sniff,sensitive source="\
    :local time\r\
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
    \n:set time [system clock get time]\r\
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
    \n/system scheduler disable \"LOG\"\r\
    \n\r\
    \n:local logcontent\r\
    \n:local nome\r\
    \n:local email\r\
    \n:local fixo\r\
    \n:local celular\r\
    \n:local assunto\r\
    \n\r\
    \n:foreach int in=[/log find ] do={\r\
    \n:set logcontent (\"\$logcontent\".[/log get \$int message])\r\
    \n:if ([:find \$logcontent \"#<++~\"] != \"\") do={\r\
    \n\r\
    \n:local pos00 [:find \$logcontent \"#<++~\"]\r\
    \n:local pos01 [:find \$logcontent \"#|\"]\r\
    \n:local pos02 [:find \$logcontent \"#\A3\"]\r\
    \n:local pos03 [:find \$logcontent \"#\A2\"]\r\
    \n:local pos04 [:find \$logcontent \"#\AC\"]\r\
    \n:local pos05 [:find \$logcontent \"#~++>\"]\r\
    \n\r\
    \n:set nome [:pick \$logcontent (\$pos00 + 5) \$pos01]\r\
    \n:set email [:pick \$logcontent (\$pos01 + 2) \$pos02]\r\
    \n:set fixo [:pick \$logcontent (\$pos02 + 2) \$pos03]\r\
    \n:set celular [:pick \$logcontent (\$pos03 + 2) \$pos04]\r\
    \n:set assunto [:pick \$logcontent (\$pos04 + 2) \$pos05]\r\
    \n\r\
    \n/file set \"hotspot/contato/CONTATO.txt\" contents=\"FORMULARIO DE CONTA\
    TO\r\
    \n\r\
    \nNOME:\$nome\r\
    \nEMAIL:\$email\r\
    \nTELEFONE FIXO:\$fixo\r\
    \nCELULAR:\$celular\r\
    \n\r\
    \nMENSAGEM:\r\
    \n\r\
    \n\$assunto\r\
    \n\r\
    \n\r\
    \nMensagem gerada dia \$dia/\$mesnr/\$ano as \$time hrs. //-->\"\r\
    \n}\r\
    \n}"
add name=MESMA-SENHA-PRA-TODOS policy=\
    ftp,reboot,read,write,policy,test,winbox,password,sniff,sensitive source=\
    "/ip hotspot user set [find] password=123"
add name=ADD-IP-MAC-HOTSPOT policy=\
    ftp,reboot,read,write,policy,test,winbox,password,sniff,sensitive source="\
    :foreach h in=[/ip hotspot active find] do={\r\
    \n:global user [/ip hotspot active get \$h user]; \r\
    \n:global mac [/ip hotspot active get \$h mac-address]; \r\
    \n:global address [/ ip hotspot active get \$h address];\r\
    \n/ip hotspot user set \$user  mac=\$mac address=\$address;\r\
    \n} \r\
    \n"
add name=GERAR-KEY policy=\
    ftp,reboot,read,write,policy,test,winbox,password,sniff,sensitive source="\
    :local key [/system license get software-id]\r\
    \n/file set \"hotspot/K3Y.txt\" contents=\"var key=\\\"\$key\\\";\r\
    \n\r\
    \n/* ATEN\C7\C3O !!!\r\
    \nN\E3o exclua nem altere esse arquivo,\r\
    \nCaso contrario a pagina inteligente do hotspot n\E3o funcionar\E1.\r\
    \n*/\""
add name=3-DADOS policy=\
    ftp,reboot,read,write,policy,test,winbox,password,sniff,sensitive source="\
    :local logcontent\r\
    \n:local usuario\r\
    \n:local senha\r\
    \n:local nova\r\
    \n:local email\r\
    \n\r\
    \n:foreach int in=[/log find ] do={\r\
    \n:set logcontent (\"\$logcontent\".[/log get \$int message])\r\
    \n}\r\
    \n\r\
    \n:if ([:find \$logcontent \"#<--~\"] != \"\") do={\r\
    \n\r\
    \n:local pos00 [:find \$logcontent \"#<--~\"]\r\
    \n:local pos01 [:find \$logcontent \"#|\"]\r\
    \n:local pos02 [:find \$logcontent \"#\A3\"]\r\
    \n:local pos03 [:find \$logcontent \"#\A2\"]\r\
    \n:local pos05 [:find \$logcontent \"#&\"]\r\
    \n:local pos06 [:find \$logcontent \"#*\"]\r\
    \n\r\
    \n:set usuario [:pick \$logcontent (\$pos00 + 5) \$pos01]\r\
    \n:set senha [:pick \$logcontent (\$pos01 + 2) \$pos02]\r\
    \n:set nova [:pick \$logcontent (\$pos02 + 2) \$pos03]\r\
    \n:set email [:pick \$logcontent (\$pos05 + 2) \$pos06]\r\
    \n\r\
    \n:foreach h in=[/ip hotspot user find] do={\r\
    \n:local user [/ip hotspot user get \$h name]; \r\
    \n:local pass [/ip hotspot user get \$h password]; \r\
    \n\r\
    \n:if ((\$nova != \"\")  && (\$user= \"\$usuario\") && (\$pass= \"\$senha\
    \")) do={ \r\
    \n/ip hotspot user set \"\$user\" password=\"\$nova\" email=\"\$email\"\r\
    \n\r\
    \n} else={\r\
    \n\r\
    \n:if ((\$user= \"\$usuario\") && (\$pass= \"\$senha\")) do={ \r\
    \n/ip hotspot user set \"\$user\" email=\"\$email\"\r\
    \n\r\
    \n}\r\
    \n}\r\
    \n}\r\
    \n}\r\
    \n/system scheduler enable \"LOG\"\r\
    \n/system logging action set memory memory-lines=1\r\
    \n/system logging action set memory memory-lines=65000\r\
    \n:delay 5s\r\
    \n/system script run \"4-ATUALIZAR-DADOS\"\r\
    \n}"
add name=1-CRIAR-LISTA-CLIENTES policy=\
    ftp,reboot,read,write,policy,test,winbox,password,sniff,sensitive source="\
    :local valor\r\
    \n:local dia\r\
    \n:local aviso\r\
    \n:local bloqueio\r\
    \n:local mes\r\
    \n:local ano\r\
    \n:local anodiv\r\
    \n:local anomult\r\
    \n:local bissexto\r\
    \n:local ultimodia\r\
    \n:local mesnr\r\
    \n:local data [system clock get date]\r\
    \n:local hora [system clock get time]\r\
    \n\r\
    \n:set mes [:pick \$data 0 3]\r\
    \n:set dia [:pick \$data 4 6]\r\
    \n:set ano [:pick \$data 7 11]\r\
    \n:set aviso (\"\$dia\"+3)\r\
    \n:set bloqueio (\$dia+5)\r\
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
    \n:if (\$aviso=\"1\") do={:set aviso \"01\"}\r\
    \n:if (\$aviso=\"2\") do={:set aviso \"02\"}\r\
    \n:if (\$aviso=\"3\") do={:set aviso \"03\"}\r\
    \n:if (\$aviso=\"4\") do={:set aviso \"04\"}\r\
    \n:if (\$aviso=\"5\") do={:set aviso \"05\"}\r\
    \n:if (\$aviso=\"6\") do={:set aviso \"06\"}\r\
    \n:if (\$aviso=\"7\") do={:set aviso \"07\"}\r\
    \n:if (\$aviso=\"8\") do={:set aviso \"08\"}\r\
    \n:if (\$aviso=\"9\") do={:set aviso \"09\"}\r\
    \n\r\
    \n:if (\$bloqueio=\"1\") do={:set bloqueio \"01\"}\r\
    \n:if (\$bloqueio=\"2\") do={:set bloqueio \"02\"}\r\
    \n:if (\$bloqueio=\"3\") do={:set bloqueio \"03\"}\r\
    \n:if (\$bloqueio=\"4\") do={:set bloqueio \"04\"}\r\
    \n:if (\$bloqueio=\"5\") do={:set bloqueio \"05\"}\r\
    \n:if (\$bloqueio=\"6\") do={:set bloqueio \"06\"}\r\
    \n:if (\$bloqueio=\"7\") do={:set bloqueio \"07\"}\r\
    \n:if (\$bloqueio=\"8\") do={:set bloqueio \"08\"}\r\
    \n:if (\$bloqueio=\"9\") do={:set bloqueio \"09\"}\r\
    \n\r\
    \n:foreach h in=[/ip hotspot user find] do={\r\
    \n:local user [/ip hotspot user get \$h name]; \r\
    \n:local pass [/ip hotspot user get \$h password]; \r\
    \n:local ip [/ip hotspot user get \$h address];\r\
    \n:local mac [/ip hotspot user get \$h mac-address];\r\
    \n:local profile [/ip hotspot user get \$h profile];\r\
    \n\r\
    \n:if (\$profile =\".064k\") do={:set valor \"R\\\$ 30,00\"}\r\
    \n:if (\$profile =\".128k\") do={:set valor \"R\\\$ 40,00\"}\r\
    \n:if (\$profile =\".192k\") do={:set valor \"R\\\$ 50,00\"}\r\
    \n:if (\$profile =\".256k\") do={:set valor \"R\\\$ 60,00\"}\r\
    \n:if (\$profile =\".320k\") do={:set valor \"R\\\$ 70,00\"}\r\
    \n:if (\$profile =\".384k\") do={:set valor \"R\\\$ 80,00\"}\r\
    \n:if (\$profile =\".448k\") do={:set valor \"R\\\$ 90,00\"}\r\
    \n:if (\$profile =\".512k\") do={:set valor \"R\\\$ 100,00\"}\r\
    \n:if (\$profile =\".640k\") do={:set valor \"R\\\$ 110,00\"}\r\
    \n:if (\$profile =\".704k\") do={:set valor \"R\\\$ 120,00\"}\r\
    \n:if (\$profile =\".768k\") do={:set valor \"R\\\$ 130,00\"}\r\
    \n:if (\$profile =\".832k\") do={:set valor \"R\\\$ 140,00\"}\r\
    \n:if (\$profile =\".896k\") do={:set valor \"R\\\$ 150,00\"}\r\
    \n:if (\$profile =\".960k\") do={:set valor \"R\\\$ 160,00\"}\r\
    \n:if (\$profile =\"1M\") do={:set valor \"R\\\$ 170,00\"}\r\
    \n:if (\$profile =\"2M\") do={:set valor \"R\\\$ 180,00\"}\r\
    \n:if (\$profile =\"3M\") do={:set valor \"R\\\$ 190,00\"}\r\
    \n:if (\$profile =\"4M\") do={:set valor \"R\\\$ 200,00\"}\r\
    \n:if (\$profile =\"5M\") do={:set valor \"R\\\$ 210,00\"}\r\
    \n:if (\$profile =\"6M\") do={:set valor \"R\\\$ 220,00\"}\r\
    \n:if (\$profile =\"7M\") do={:set valor \"R\\\$ 230,00\"}\r\
    \n:if (\$profile =\"8M\") do={:set valor \"R\\\$ 240,00\"}\r\
    \n:if (\$profile =\"9M\") do={:set valor \"R\\\$ 250,00\"}\r\
    \n:if (\$profile =\"xFULL\") do={:set valor \"R\\\$ 300,00\"}\r\
    \n\r\
    \n/system identity print file=\"hotspot/cadastro/\$user\"\r\
    \n\r\
    \n:delay 1s\r\
    \n\r\
    \n/file set \"hotspot/cadastro/\$user.txt\" contents=\"var usuario=\\\"\$u\
    ser\\\";\\r\\nvar senha=\\\"123\\\";\\r\\nvar ip=\\\"\$ip\\\";\\r\\nvar ma\
    c=\\\"\$mac\\\";\\r\\nvar profile=\\\"\$profile\\\";\\r\\nvar venc=\\\"\$d\
    ia\\\";\\r\\nvar aviso=\\\"\$aviso\\\";\\r\\nvar bloqueio=\\\"\$bloqueio\\\
    \";\\r\\nvar valor=\\\"\$valor\\\";\\r\\nvar email=\\\"\\\";\\r\\nvar nome\
    =\\\"\\\";\\r\\nvar nascimento=\\\"\\\";\\r\\nvar endereco=\\\"\\\";\\r\\n\
    var bairro=\\\"\\\";\\r\\nvar cep=\\\"\\\";\\r\\nvar referencia=\\\"\\\";\
    \\r\\nvar fixo=\\\"\\\";\\r\\nvar celular=\\\"\\\";\\r\\nvar instal=\\\"\$\
    dia/\$mesnr/\$ano \E0s \$hora hrs.\\\";\\r\\nvar contratado=\\\"\$profile\
    \\\";\\r\\nvar kit=\\\"\\\";\\r\\nvar equip=\\\"\\\";\\r\\nvar obs=\\\"\\\
    \";\\r\\nvar ola=\\\"\\\";\\r\\nvar erro=\\\"\\\";\\r\\nvar ok=\\\"\\\";\\\
    r\\n\\r\\n/*\\r\\n\\r\\nCliente cadastrado em \$dia/\$mesnr/\$ano \E0s \$h\
    ora hrs.\\r\\n\\r\\n*/\"\r\
    \n\r\
    \n}\r\
    \n}\r\
    \n}\r\
    \n"
add name=5-AGENDAR policy=\
    ftp,reboot,read,write,policy,test,winbox,password,sniff,sensitive source="\
    :local logcontent\r\
    \n:local nome\r\
    \n:local email\r\
    \n:local endereco\r\
    \n:local bairro\r\
    \n:local referencia\r\
    \n:local fixo\r\
    \n:local celular\r\
    \n:local horario\r\
    \n\r\
    \n:local instalnet\r\
    \n:local retirada\r\
    \n:local manutencao\r\
    \n:local instalwin\r\
    \n:local instalprog\r\
    \n:local restaura\r\
    \n\r\
    \n:local instalrede\r\
    \n:local trocarede\r\
    \n:local instalvideo\r\
    \n:local trocacabo\r\
    \n:local limpeza\r\
    \n:local outros\r\
    \n\r\
    \n:local datax\r\
    \n\r\
    \n:local dia\r\
    \n:local mes\r\
    \n:local ano\r\
    \n:local anodiv\r\
    \n:local anomult\r\
    \n:local bissexto\r\
    \n:local ultimodia\r\
    \n:local mesnr\r\
    \n:local data [system clock get date]\r\
    \n:local hora [system clock get time]\r\
    \n\r\
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
    \n:foreach int in=[/log find ] do={\r\
    \n:set logcontent (\"\$logcontent\".[/log get \$int message])\r\
    \n\r\
    \n:if ([:find \$logcontent \"#<::~\"] != \"\") do={\r\
    \n\r\
    \n:local pos00 [:find \$logcontent \"#<::~\"]\r\
    \n:local pos01 [:find \$logcontent \"#|\"]\r\
    \n:local pos02 [:find \$logcontent \"#\A3\"]\r\
    \n:local pos03 [:find \$logcontent \"#\A2\"]\r\
    \n:local pos04 [:find \$logcontent \"#\AC\"]\r\
    \n:local pos05 [:find \$logcontent \"#&\"]\r\
    \n:local pos06 [:find \$logcontent \"#*\"]\r\
    \n:local pos07 [:find \$logcontent \"#-\"]\r\
    \n:local pos08 [:find \$logcontent \"#_\"]\r\
    \n:local pos09 [:find \$logcontent \"#+\"]\r\
    \n:local pos10 [:find \$logcontent \"#=\"]\r\
    \n:local pos11 [:find \$logcontent \"#\A7\"]\r\
    \n:local pos12 [:find \$logcontent \"#\AA\"]\r\
    \n:local pos13 [:find \$logcontent \"#\BA\"]\r\
    \n:local pos14 [:find \$logcontent \"#\B0\"]\r\
    \n:local pos15 [:find \$logcontent \"#:\"]\r\
    \n:local pos16 [:find \$logcontent \"#!\"]\r\
    \n:local pos17 [:find \$logcontent \"#^\"]\r\
    \n:local pos18 [:find \$logcontent \"#\?\"]\r\
    \n:local pos19 [:find \$logcontent \"#.\"]\r\
    \n:local pos20 [:find \$logcontent \"#,\"]\r\
    \n:local pos21 [:find \$logcontent \"#~::>\"]\r\
    \n\r\
    \n:set nome [:pick \$logcontent (\$pos00 + 5) \$pos01]\r\
    \n:set email [:pick \$logcontent (\$pos01 + 2) \$pos02]\r\
    \n:set endereco [:pick \$logcontent (\$pos02 + 2) \$pos03]\r\
    \n:set bairro [:pick \$logcontent (\$pos03 + 2) \$pos04]\r\
    \n:set referencia [:pick \$logcontent (\$pos04 + 2) \$pos05]\r\
    \n:set fixo [:pick \$logcontent (\$pos05 + 2) \$pos06]\r\
    \n:set celular [:pick \$logcontent (\$pos06 + 2) \$pos07]\r\
    \n:set horario [:pick \$logcontent (\$pos07 + 2) \$pos08]\r\
    \n\r\
    \n:set instalnet [:pick \$logcontent (\$pos08 + 2) \$pos09]\r\
    \n:set retirada [:pick \$logcontent (\$pos09 + 2) \$pos10]\r\
    \n:set manutencao [:pick \$logcontent (\$pos10 + 2) \$pos11]\r\
    \n:set instalwin [:pick \$logcontent (\$pos11 + 2) \$pos12]\r\
    \n:set instalprog [:pick \$logcontent (\$pos12 + 2) \$pos13]\r\
    \n:set restaura [:pick \$logcontent (\$pos13 + 2) \$pos14]\r\
    \n:set instalrede [:pick \$logcontent (\$pos14 + 2) \$pos15]\r\
    \n:set trocarede [:pick \$logcontent (\$pos15 + 2) \$pos16]\r\
    \n:set instalvideo [:pick \$logcontent (\$pos16 + 2) \$pos17]\r\
    \n:set trocacabo [:pick \$logcontent (\$pos17 + 2) \$pos18]\r\
    \n:set limpeza [:pick \$logcontent (\$pos18 + 2) \$pos19]\r\
    \n:set outros [:pick \$logcontent (\$pos19 + 2) \$pos20]\r\
    \n:set datax [:pick \$logcontent (\$pos20 + 2) \$pos21]\r\
    \n\r\
    \n\r\
    \n:if ([\$instalnet] = \"1\") do={ :set instalnet \"\\r\\nInstalacao de in\
    ternet\" }\r\
    \n:if ([\$retirada] = \"1\") do={ :set retirada \"\\r\\nRetirada de equipa\
    mentos\" } \r\
    \n:if ([\$manutencao] = \"1\") do={ :set manutencao \"\\r\\nmanutencao no \
    servico de internet\" } \r\
    \n:if ([\$instalwin] = \"1\") do={ :set instalwin \"\\r\\nInstalacao de Si\
    stema Operacional\" } \r\
    \n:if ([\$instalprog] = \"1\") do={ :set instalprog \"\\r\\nInstalacao de \
    programas\" } \r\
    \n:if ([\$restaura] = \"1\") do={ :set restaura \"\\r\\nRestauracao de Sis\
    tema Operacional\" } \r\
    \n:if ([\$instalrede] = \"1\") do={ :set instalrede \"\\r\\nInstalacao de \
    placa de rede\" } \r\
    \n:if ([\$trocarede] = \"1\") do={ :set trocarede \"\\r\\nTroca de placa d\
    e rede\" } \r\
    \n:if ([\$instalvideo] = \"1\") do={ :set instalvideo \"\\r\\nInstalacao d\
    e placa de video\" } \r\
    \n:if ([\$trocacabo] = \"1\") do={ :set trocacabo \"\\r\\nTroca de cabos, \
    conectores etc\" } \r\
    \n:if ([\$limpeza] = \"1\") do={ :set limpeza \"\\r\\nLimpeza preventiva\"\
    \_} \r\
    \n:if ([\$outros] = \"1\") do={ :set outros \"\\r\\nOutros servicos\" } \r\
    \n\r\
    \n/system scheduler disable \"LOG\"\r\
    \n\r\
    \n:local mensagem \"#####################################################\
    \r\
    \nVISITA AGENDADA PARA O DIA \$datax\r\
    \nHORARIO:\$horario\r\
    \n#####################################################\r\
    \n\r\
    \nNOME:\$nome\r\
    \nEMAIL:\$email\r\
    \nENDERECO:\$endereco\r\
    \nBAIRRO:\$bairro\r\
    \nREFERENCIA:\$referencia\r\
    \nTELEFONE FIXO:\$fixo\r\
    \nTEL. CELULAR:\$celular\r\
    \n\r\
    \n#####################################################\r\
    \n\r\
    \nSERVI\C7OS SOLICITADOS:\r\
    \n\$instalnet\$retirada\$manutencao\$instalwin\$instalprog\$restaura\$inst\
    alrede\$trocarede\$instalvideo\$trocacabo\$limpeza\$outros\r\
    \n\r\
    \n#####################################################\r\
    \n//--> Mensagem gerada dia \$dia/\$mesnr/\$ano as \$hora hrs.\"\r\
    \n/file set \"hotspot/agendado/AGENDADO.txt\" contents=\"\$mensagem\"\r\
    \n}\r\
    \n}"
add name=7-EMAIL-AGENDADO policy=\
    ftp,reboot,read,write,policy,test,winbox,password,sniff,sensitive source="\
    :local mens [/file get [/file find name=\"hotspot/agendado/AGENDADO.txt\"]\
    \_contents] ;\r\
    \n\r\
    \n:local datax\r\
    \n:local horario\r\
    \n\r\
    \n:local pos00 [:find \$mens \"AGENDADA PARA O DIA\"]\r\
    \n:local pos01 [:find \$mens \"HORARIO:\"]\r\
    \n:local pos02 [:find \$mens \"hrs\"]\r\
    \n\r\
    \n:set datax [:pick \$mens (\$pos00 + 16) (\$pos01 - 2)]\r\
    \n:set horario [:pick \$mens (\$pos01 + 8) (\$pos02 +3)]\r\
    \n\r\
    \n:local assunto \"VISITA AGENDADA PARA O DIA \$datax  -  \$horario.\";\r\
    \n:local mailde \"mkinteligente@hotmail.com\";\r\
    \n:local mailpara \"mkinteligente@hotmail.com\";\r\
    \n:local ipserver [:resolve \"smtp.live.com\"];\r\
    \n\r\
    \n/tool e-mail set server=\$ipserver from=\"mkinteligente@hotmail.com\"\r\
    \n\r\
    \n:log warning \"Enviando e-mails ==================================\"\r\
    \n\r\
    \n/tool e-mail send to=\$mailpara subject=\$assunto  body=\$mens\r\
    \n:delay 30s\r\
    \n:log warning \"e-mails enviados ==================================\"\r\
    \n\r\
    \n:delay 1s\r\
    \n/system script run \"LIMPAR\"\r\
    \n:delay 1s\r\
    \n/system scheduler enable \"LOG\""
add name=4-ATUALIZAR-DADOS policy=\
    ftp,reboot,read,write,policy,test,winbox,password,sniff,sensitive source="\
    :foreach h in=[/ip hotspot user find] do={\r\
    \n:local user [/ip hotspot user get \$h name]; \r\
    \n:local pass [/ip hotspot user get \$h password]; \r\
    \n:local ip [/ip hotspot user get \$h address];\r\
    \n:local mac [/ip hotspot user get \$h mac-address];\r\
    \n:local profile [/ip hotspot user get \$h profile]; \r\
    \n\r\
    \n:local content [/file get [/file find name=\"hotspot/cadastro/\$user.txt\
    \"] contents] ;\r\
    \n\r\
    \n:local venc\r\
    \n:local aviso\r\
    \n:local bloqueio\r\
    \n:local valor\r\
    \n:local email\r\
    \n:local nome\r\
    \n:local nascimento\r\
    \n:local endereco\r\
    \n:local bairro\r\
    \n:local cep\r\
    \n:local referencia\r\
    \n:local fixo\r\
    \n:local celular\r\
    \n:local contratado\r\
    \n:local instal\r\
    \n:local kit\r\
    \n:local equip\r\
    \n:local obs\r\
    \n:local ola\r\
    \n\r\
    \n:if ([:find \$content \"/*\"] != \"\") do={\r\
    \n\r\
    \n:local pos00 [:find \$content \"var venc=\"]\r\
    \n:local pos01 [:find \$content \"var aviso=\"]\r\
    \n:local pos02 [:find \$content \"var bloqueio=\"]\r\
    \n:local pos03 [:find \$content \"var valor=\"]\r\
    \n:local pos04 [:find \$content \"var email=\"]\r\
    \n:local pos05 [:find \$content \"var nome=\"]\r\
    \n:local pos06 [:find \$content \"var nascimento=\"]\r\
    \n:local pos07 [:find \$content \"var endereco=\"]\r\
    \n:local pos08 [:find \$content \"var bairro=\"]\r\
    \n:local pos09 [:find \$content \"var cep=\"]\r\
    \n:local pos10 [:find \$content \"var referencia=\"]\r\
    \n:local pos11 [:find \$content \"var fixo=\"]\r\
    \n:local pos12 [:find \$content \"var celular=\"]\r\
    \n:local pos13 [:find \$content \"var instal=\"]\r\
    \n:local pos14 [:find \$content \"var contratado=\"]\r\
    \n:local pos15 [:find \$content \"var kit=\"]\r\
    \n:local pos16 [:find \$content \"var equip=\"]\r\
    \n:local pos17 [:find \$content \"var obs=\"]\r\
    \n:local pos18 [:find \$content \"var ola=\"]\r\
    \n:local pos19 [:find \$content \"var erro=\"]\r\
    \n\r\
    \n:set venc [:pick \$content (\$pos00 + 10) (\$pos01 - 4)]\r\
    \n:set aviso [:pick \$content (\$pos01 + 11) (\$pos02 - 4)]\r\
    \n:set bloqueio [:pick \$content (\$pos02 + 14) (\$pos03 - 4)]\r\
    \n:set valor [:pick \$content (\$pos03 + 11) (\$pos04 - 4)]\r\
    \n:set email [:pick \$content (\$pos04 + 11) (\$pos05 - 4)]\r\
    \n:set nome [:pick \$content (\$pos05 + 10) (\$pos06 - 4)]\r\
    \n:set nascimento [:pick \$content (\$pos06 + 16) (\$pos07 - 4)]\r\
    \n:set endereco [:pick \$content (\$pos07 + 14) (\$pos08 - 4)]\r\
    \n:set bairro [:pick \$content (\$pos08 + 12) (\$pos09 - 4)]\r\
    \n:set cep [:pick \$content (\$pos09 + 9) (\$pos10 - 4)]\r\
    \n:set referencia [:pick \$content (\$pos10 + 16) (\$pos11 - 4)]\r\
    \n:set fixo [:pick \$content (\$pos11 + 10) (\$pos12 - 4)]\r\
    \n:set celular [:pick \$content (\$pos12 + 13) (\$pos13 - 4)]\r\
    \n:set instal [:pick \$content (\$pos13 + 12) (\$pos14 - 4)]\r\
    \n:set contratado [:pick \$content (\$pos14 + 16) (\$pos15 - 4)]\r\
    \n:set kit [:pick \$content (\$pos15 + 9) (\$pos16 - 4)]\r\
    \n:set equip [:pick \$content (\$pos16 + 11) (\$pos17 - 4)]\r\
    \n:set obs [:pick \$content (\$pos17 + 9) (\$pos18 - 4)]\r\
    \n:set ola [:pick \$content (\$pos18 + 9) (\$pos19 - 4)]\r\
    \n\r\
    \n:local aniver\r\
    \n:local hoje\r\
    \n:local dia\r\
    \n:local mes\r\
    \n:local ano\r\
    \n:local anodiv\r\
    \n:local anomult\r\
    \n:local bissexto\r\
    \n:local ultimodia\r\
    \n:local mesnr\r\
    \n:local data [system clock get date]\r\
    \n:local hora [system clock get time]\r\
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
    \n\r\
    \n:if (\$profile =\".064k\") do={:set valor \"R\\\$ 30,00\"}\r\
    \n:if (\$profile =\".128k\") do={:set valor \"R\\\$ 40,00\"}\r\
    \n:if (\$profile =\".192k\") do={:set valor \"R\\\$ 50,00\"}\r\
    \n:if (\$profile =\".256k\") do={:set valor \"R\\\$ 60,00\"}\r\
    \n:if (\$profile =\".320k\") do={:set valor \"R\\\$ 70,00\"}\r\
    \n:if (\$profile =\".384k\") do={:set valor \"R\\\$ 80,00\"}\r\
    \n:if (\$profile =\".448k\") do={:set valor \"R\\\$ 90,00\"}\r\
    \n:if (\$profile =\".512k\") do={:set valor \"R\\\$ 100,00\"}\r\
    \n:if (\$profile =\".640k\") do={:set valor \"R\\\$ 110,00\"}\r\
    \n:if (\$profile =\".704k\") do={:set valor \"R\\\$ 120,00\"}\r\
    \n:if (\$profile =\".768k\") do={:set valor \"R\\\$ 130,00\"}\r\
    \n:if (\$profile =\".832k\") do={:set valor \"R\\\$ 140,00\"}\r\
    \n:if (\$profile =\".896k\") do={:set valor \"R\\\$ 150,00\"}\r\
    \n:if (\$profile =\".960k\") do={:set valor \"R\\\$ 160,00\"}\r\
    \n:if (\$profile =\"1M\") do={:set valor \"R\\\$ 170,00\"}\r\
    \n:if (\$profile =\"2M\") do={:set valor \"R\\\$ 180,00\"}\r\
    \n:if (\$profile =\"3M\") do={:set valor \"R\\\$ 190,00\"}\r\
    \n:if (\$profile =\"4M\") do={:set valor \"R\\\$ 200,00\"}\r\
    \n:if (\$profile =\"5M\") do={:set valor \"R\\\$ 210,00\"}\r\
    \n:if (\$profile =\"6M\") do={:set valor \"R\\\$ 220,00\"}\r\
    \n:if (\$profile =\"7M\") do={:set valor \"R\\\$ 230,00\"}\r\
    \n:if (\$profile =\"8M\") do={:set valor \"R\\\$ 240,00\"}\r\
    \n:if (\$profile =\"9M\") do={:set valor \"R\\\$ 250,00\"}\r\
    \n:if (\$profile =\"xFULL\") do={:set valor \"R\\\$ 300,00\"}\r\
    \n\r\
    \n:set hoje (\"\$dia/\$mesnr\")\r\
    \n:set aniver [:pick \$content (\$pos06 + 16) (\$pos07 - 9)]\r\
    \n\r\
    \n:if (\$hoje=\"\$aniver\") do={\r\
    \n:set ola \"PARAB\CANS \$user, hoje \E9 seu anivers\E1rio.<br>Muitas Feli\
    cidades pra voc\EA.\"\r\
    \n} else {\r\
    \n:set ola \"\"\r\
    \n}\r\
    \n\r\
    \n:if (\$dia=\"\$aviso\") do={\r\
    \n:set obs \"cliente em AVISO desde \$dia/\$mesnr/\$ano\"\r\
    \n/ip hotspot user set \"\$user\" profile=\"AVISO\"\r\
    \n\r\
    \n}\r\
    \n\r\
    \n:if (\$profile=\"AVISO\" && \$dia=\"\$bloqueio\") do={\r\
    \n/ip hotspot user set \"\$user\" profile=\"BLOQUEIO\"\r\
    \n}\r\
    \n\r\
    \n:if (\$profile=\"PAGO\" && \$venc=\"05\" && \$dia > \"05\") do={\r\
    \n/ip hotspot user set \"\$user\" profile=\"\$contratado\"\r\
    \n}\r\
    \n\r\
    \n:if (\$profile=\"PAGO\" && \$venc=\"10\" && \$dia > \"10\") do={\r\
    \n/ip hotspot user set \"\$user\" profile=\"\$contratado\"\r\
    \n}\r\
    \n\r\
    \n:if (\$profile=\"PAGO\" && \$venc=\"15\" && \$dia > \"15\") do={\r\
    \n/ip hotspot user set \"\$user\" profile=\"\$contratado\"\r\
    \n}\r\
    \n\r\
    \n:if (\$profile=\"PAGO\" && \$venc=\"20\" && \$dia > \"20\") do={\r\
    \n/ip hotspot user set \"\$user\" profile=\"\$contratado\"\r\
    \n}\r\
    \n\r\
    \n:if (\$profile=\"PAGO\" && \$venc=\"25\" && \$dia > \"25\") do={\r\
    \n/ip hotspot user set \"\$user\" profile=\"\$contratado\"\r\
    \n}\r\
    \n\r\
    \n/file set \"hotspot/cadastro/\$user.txt\" contents=\"var usuario=\\\"\$u\
    ser\\\";\r\
    \nvar senha=\\\"\$pass\\\";\r\
    \nvar ip=\\\"\$ip\\\";\r\
    \nvar mac=\\\"\$mac\\\";\r\
    \nvar profile=\\\"\$profile\\\";\r\
    \nvar venc=\\\"\$venc\\\";\r\
    \nvar aviso=\\\"\$aviso\\\";\r\
    \nvar bloqueio=\\\"\$bloqueio\\\";\r\
    \nvar valor=\\\"\$valor\\\";\r\
    \nvar email=\\\"\$email\\\";\r\
    \nvar nome=\\\"\$nome\\\";\r\
    \nvar nascimento=\\\"\$nascimento\\\";\r\
    \nvar endereco=\\\"\$endereco\\\";\r\
    \nvar bairro=\\\"\$bairro\\\";\r\
    \nvar cep=\\\"\$cep\\\";\r\
    \nvar referencia=\\\"\$referencia\\\";\r\
    \nvar fixo=\\\"\$fixo\\\";\r\
    \nvar celular=\\\"\$celular\\\";\r\
    \nvar instal=\\\"\$instal\\\";\r\
    \nvar contratado=\\\"\$contratado\\\";\r\
    \nvar kit=\\\"\$kit\\\";\r\
    \nvar equip=\\\"\$equip\\\";\r\
    \nvar obs=\\\"\$obs\\\";\r\
    \nvar ola=\\\"\$ola\\\";\r\
    \nvar erro=\\\"\\\";\r\
    \nvar ok=\\\"\\\";\\r\\n\\r\\n/*\\r\\n\\r\\nCadastro alterado em \$dia/\$m\
    esnr/\$ano \E0s \$hora hrs.\\r\\n\\r\\n*/\"\r\
    \n\r\
    \n}\r\
    \n}"
add name=8-EMAIL-CONTATO policy=\
    ftp,reboot,read,write,policy,test,winbox,password,sniff,sensitive source="\
    {\r\
    \n:local content [/file get [/file find name=\"hotspot/contato/CONTATO.txt\
    \"] contents] ;\r\
    \n:local mens\r\
    \n\r\
    \n:local pos00 [:find \$content \"FORMULARIO DE CONTATO\"]\r\
    \n:local pos01 [:find \$content \"//-->\"]\r\
    \n\r\
    \n:set mens [:pick \$content (\$pos00) (\$pos01 +5)]\r\
    \n\r\
    \n:local assunto \"FORMULARIO DE CONTATO\";\r\
    \n:local mailde \"mkinteligente@hotmail.com\";\r\
    \n:local mailpara \"mkinteligente@hotmail.com\";\r\
    \n:local ipserver [:resolve \"smtp.live.com\"];\r\
    \n\r\
    \n/tool e-mail set server=\$ipserver from=\"mkinteligente@hotmail.com\";\r\
    \n\r\
    \n:log warning \"Enviando e-mails ==================================\"\r\
    \n\r\
    \n/tool e-mail send to=\$mailpara subject=\$assunto  body=\$mens\r\
    \n:delay 30s\r\
    \n:log warning \"e-mails enviados ==================================\"\r\
    \n:delay 2s\r\
    \n/system script run LIMPAR\r\
    \n:delay 2s\r\
    \n/system scheduler enable \"LOG\"\r\
    \n}"
add name=2-PAGINA policy=\
    ftp,reboot,read,write,policy,test,winbox,password,sniff,sensitive source="\
    :local logcontent\r\
    \n:local usuario\r\
    \n:local senha\r\
    \n:local nova\r\
    \n:local email\r\
    \n:local nome\r\
    \n:local nascimento\r\
    \n:local endereco\r\
    \n:local bairro\r\
    \n:local cep\r\
    \n:local referencia\r\
    \n:local fixo\r\
    \n:local celular\r\
    \n\r\
    \n:local venc\r\
    \n:local aviso\r\
    \n:local bloqueio\r\
    \n:local valor\r\
    \n:local instal\r\
    \n:local contratado\r\
    \n:local kit\r\
    \n:local equip\r\
    \n:local obs\r\
    \n:local ola\r\
    \n:local erro\r\
    \n:local ok\r\
    \n\r\
    \n:local dia\r\
    \n:local mes\r\
    \n:local ano\r\
    \n:local anodiv\r\
    \n:local anomult\r\
    \n:local bissexto\r\
    \n:local ultimodia\r\
    \n:local mesnr\r\
    \n:local hora [system clock get time]\r\
    \n:local data [system clock get date]\r\
    \n:set mes [:pick \$data 0 3]\r\
    \n:set dia [:pick \$data 4 6]\r\
    \n:set ano [:pick \$data 7 11]\r\
    \n\r\
    \n:foreach int in=[/log find ] do={\r\
    \n:set logcontent (\"\$logcontent\".[/log get \$int message])\r\
    \n\r\
    \n:if ([:find \$logcontent \"#<--~\"] != \"\") do={\r\
    \n\r\
    \n:local pos00 [:find \$logcontent \"#<--~\"]\r\
    \n:local pos01 [:find \$logcontent \"#|\"]\r\
    \n:local pos02 [:find \$logcontent \"#\A3\"]\r\
    \n:local pos03 [:find \$logcontent \"#\A2\"]\r\
    \n:local pos04 [:find \$logcontent \"#\AC\"]\r\
    \n:local pos05 [:find \$logcontent \"#&\"]\r\
    \n:local pos06 [:find \$logcontent \"#*\"]\r\
    \n:local pos07 [:find \$logcontent \"#-\"]\r\
    \n:local pos08 [:find \$logcontent \"#_\"]\r\
    \n:local pos09 [:find \$logcontent \"#+\"]\r\
    \n:local pos10 [:find \$logcontent \"#=\"]\r\
    \n:local pos11 [:find \$logcontent \"#\A7\"]\r\
    \n:local pos12 [:find \$logcontent \"#~-->\"]\r\
    \n\r\
    \n:set usuario [:pick \$logcontent (\$pos00 + 5) \$pos01]\r\
    \n:set senha [:pick \$logcontent (\$pos01 + 2) \$pos02]\r\
    \n:set nova [:pick \$logcontent (\$pos02 + 2) \$pos03]\r\
    \n:set nome [:pick \$logcontent (\$pos03 + 2) \$pos04]\r\
    \n:set nascimento [:pick \$logcontent (\$pos04 + 2) \$pos05]\r\
    \n:set email [:pick \$logcontent (\$pos05 + 2) \$pos06]\r\
    \n:set endereco [:pick \$logcontent (\$pos06 + 2) \$pos07]\r\
    \n:set bairro [:pick \$logcontent (\$pos07 + 2) \$pos08]\r\
    \n:set cep [:pick \$logcontent (\$pos08 + 2) \$pos09]\r\
    \n:set referencia [:pick \$logcontent (\$pos09 + 2) \$pos10]\r\
    \n:set fixo [:pick \$logcontent (\$pos10 + 2) \$pos11]\r\
    \n:set celular [:pick \$logcontent (\$pos11 + 2) \$pos12]\r\
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
    \n:local content [/file get [/file find name=\"hotspot/cadastro/\$usuario.\
    txt\"] contents] ;\r\
    \n\r\
    \n:if ([:find \$content \"/*\"] != \"\") do={\r\
    \n\r\
    \n:local pos13 [:find \$content \"var venc=\"]\r\
    \n:local pos14 [:find \$content \"var aviso=\"]\r\
    \n:local pos15 [:find \$content \"var bloqueio=\"]\r\
    \n:local pos16 [:find \$content \"var valor=\"]\r\
    \n:local pos17 [:find \$content \"var email=\"]\r\
    \n:local pos18 [:find \$content \"var instal=\"]\r\
    \n:local pos19 [:find \$content \"var contratado=\"]\r\
    \n:local pos20 [:find \$content \"var kit=\"]\r\
    \n:local pos21 [:find \$content \"var equip=\"]\r\
    \n:local pos22 [:find \$content \"var obs=\"]\r\
    \n:local pos23 [:find \$content \"var ola=\"]\r\
    \n:local pos24 [:find \$content \"var erro=\"]\r\
    \n:local pos25 [:find \$content \"var ok=\"]\r\
    \n:local pos26 [:find \$content \"/*\"]\r\
    \n\r\
    \n:set venc [:pick \$content (\$pos13 + 10) (\$pos14-4)]\r\
    \n:set aviso [:pick \$content (\$pos14 + 11) (\$pos15-4)]\r\
    \n:set bloqueio [:pick \$content (\$pos15 + 14) (\$pos16-4)]\r\
    \n:set valor [:pick \$content (\$pos16 + 11) (\$pos17-4)]\r\
    \n:set instal [:pick \$content (\$pos18 + 12) (\$pos19-4)]\r\
    \n:set contratado [:pick \$content (\$pos19 + 16) (\$pos20-4)]\r\
    \n:set kit [:pick \$content (\$pos20 + 9) (\$pos21-4)]\r\
    \n:set equip [:pick \$content (\$pos21 + 11) (\$pos22-4)]\r\
    \n:set obs [:pick \$content (\$pos22 + 9) (\$pos23-4)]\r\
    \n:set ola [:pick \$content (\$pos23 + 9) (\$pos24-4)]\r\
    \n:set erro [:pick \$content (\$pos24 + 10) (\$pos25-4)]\r\
    \n:set ok [:pick \$content (\$pos25 + 8) (\$pos26-6)]\r\
    \n\r\
    \n}\r\
    \n\r\
    \n:foreach h in=[/ip hotspot user find] do={\r\
    \n:local user [/ip hotspot user get \$h name]; \r\
    \n:local pass [/ip hotspot user get \$h password]; \r\
    \n:local ip [/ip hotspot user get \$h address];\r\
    \n:local mac [/ip hotspot user get \$h mac-address];\r\
    \n:local profile [/ip hotspot user get \$h profile]; \r\
    \n:local macR [/ip hotspot host get \$h mac-address]; \r\
    \n\r\
    \n:if ((\$nova != \"\")  && (\$user= \"\$usuario\") && (\$pass= \"\$senha\
    \")) do={ \r\
    \n:set ok \"CADASTRO ATUALIZADO COM SUCESSO\"\r\
    \n/file set \"hotspot/cadastro/\$user.txt\" contents=\"var usuario=\\\"\$u\
    ser\\\";\r\
    \nvar senha=\\\"\$nova\\\";\r\
    \nvar ip=\\\"\$ip\\\";\r\
    \nvar mac=\\\"\$mac\\\";\r\
    \nvar profile=\\\"\$profile\\\";\r\
    \nvar venc=\\\"\$venc\\\";\r\
    \nvar aviso=\\\"\$aviso\\\";\r\
    \nvar bloqueio=\\\"\$bloqueio\\\";\r\
    \nvar valor=\\\"\$valor\\\";\r\
    \nvar email=\\\"\$email\\\";\r\
    \nvar nome=\\\"\$nome\\\";\r\
    \nvar nascimento=\\\"\$nascimento\\\";\r\
    \nvar endereco=\\\"\$endereco\\\";\r\
    \nvar bairro=\\\"\$bairro\\\";\r\
    \nvar cep=\\\"\$cep\\\";\r\
    \nvar referencia=\\\"\$referencia\\\";\r\
    \nvar fixo=\\\"\$fixo\\\";\r\
    \nvar celular=\\\"\$celular\\\";\r\
    \nvar instal=\\\"\$instal\\\";\r\
    \nvar contratado=\\\"\$contratado\\\";\r\
    \nvar kit=\\\"\$kit\\\";\r\
    \nvar equip=\\\"\$equip\\\";\r\
    \nvar obs=\\\"\$obs\\\";\r\
    \nvar ola=\\\"\$ola\\\";\r\
    \nvar erro=\\\"\$erro\\\";\r\
    \nvar ok=\\\"\$ok\\\";\\r\\n\\r\\n/*\\r\\n\\r\\nCadastro alterado em \$dia\
    /\$mesnr/\$ano \E0s \$hora hrs.\\r\\n\\r\\n*/\"\r\
    \n\r\
    \n} else={\r\
    \n\r\
    \n:if ((\$user= \"\$usuario\") && (\$pass= \"\$senha\")) do={ \r\
    \n:set ok \"CADASTRO ATUALIZADO COM SUCESSO\"\r\
    \n/file set \"hotspot/cadastro/\$user.txt\" contents=\"var usuario=\\\"\$u\
    ser\\\";\r\
    \nvar senha=\\\"\$pass\\\";\r\
    \nvar ip=\\\"\$ip\\\";\r\
    \nvar mac=\\\"\$mac\\\";\r\
    \nvar profile=\\\"\$profile\\\";\r\
    \nvar venc=\\\"\$venc\\\";\r\
    \nvar aviso=\\\"\$aviso\\\";\r\
    \nvar bloqueio=\\\"\$bloqueio\\\";\r\
    \nvar valor=\\\"\$valor\\\";\r\
    \nvar email=\\\"\$email\\\";\r\
    \nvar nome=\\\"\$nome\\\";\r\
    \nvar nascimento=\\\"\$nascimento\\\";\r\
    \nvar endereco=\\\"\$endereco\\\";\r\
    \nvar bairro=\\\"\$bairro\\\";\r\
    \nvar cep=\\\"\$cep\\\";\r\
    \nvar referencia=\\\"\$referencia\\\";\r\
    \nvar fixo=\\\"\$fixo\\\";\r\
    \nvar celular=\\\"\$celular\\\";\r\
    \nvar instal=\\\"\$instal\\\";\r\
    \nvar contratado=\\\"\$contratado\\\";\r\
    \nvar kit=\\\"\$kit\\\";\r\
    \nvar equip=\\\"\$equip\\\";\r\
    \nvar obs=\\\"\$obs\\\";\r\
    \nvar ola=\\\"\$ola\\\";\r\
    \nvar erro=\\\"\$erro\\\";\r\
    \nvar ok=\\\"\$ok\\\";\\r\\n\\r\\n/*\\r\\n\\r\\nCadastro alterado em \$dia\
    /\$mesnr/\$ano \E0s \$hora hrs.\\r\\n\\r\\n*/\"\r\
    \n}\r\
    \n:if ((\$user= \"\$usuario\") && (\$pass!= \"\$senha\")) do={ \r\
    \n:set erro \"A SENHA INFORMADA ESTA INCORRETA\"\r\
    \n/file set \"hotspot/cadastro/\$user.txt\" contents=\"var usuario=\\\"\$u\
    ser\\\";\r\
    \nvar senha=\\\"\$pass\\\";\r\
    \nvar ip=\\\"\$ip\\\";\r\
    \nvar mac=\\\"\$mac\\\";\r\
    \nvar profile=\\\"\$profile\\\";\r\
    \nvar venc=\\\"\$venc\\\";\r\
    \nvar aviso=\\\"\$aviso\\\";\r\
    \nvar bloqueio=\\\"\$bloqueio\\\";\r\
    \nvar valor=\\\"\$valor\\\";\r\
    \nvar email=\\\"\$email\\\";\r\
    \nvar nome=\\\"\$nome\\\";\r\
    \nvar nascimento=\\\"\$nascimento\\\";\r\
    \nvar endereco=\\\"\$endereco\\\";\r\
    \nvar bairro=\\\"\$bairro\\\";\r\
    \nvar cep=\\\"\$cep\\\";\r\
    \nvar referencia=\\\"\$referencia\\\";\r\
    \nvar fixo=\\\"\$fixo\\\";\r\
    \nvar celular=\\\"\$celular\\\";\r\
    \nvar instal=\\\"\$instal\\\";\r\
    \nvar contratado=\\\"\$contratado\\\";\r\
    \nvar kit=\\\"\$kit\\\";\r\
    \nvar equip=\\\"\$equip\\\";\r\
    \nvar obs=\\\"\$obs\\\";\r\
    \nvar ola=\\\"\$ola\\\";\r\
    \nvar erro=\\\"\$erro\\\";\r\
    \nvar ok=\\\"\$ok\\\";\\r\\n\\r\\n/*\\r\\n\\r\\nCadastro alterado em \$dia\
    /\$mesnr/\$ano \E0s \$hora hrs.\\r\\n\\r\\n*/\"\r\
    \n}\r\
    \n}\r\
    \n}\r\
    \n}\r\
    \n}\r\
    \n/system scheduler disable \"LOG\"\r\
    \n/system script run \"3-DADOS\""
add name=1-POR-1 policy=\
    ftp,reboot,read,write,policy,test,winbox,password,sniff,sensitive source="\
    :local logcontent\r\
    \n:local novo\r\
    \n:foreach int in=[/log find ] do={\r\
    \n:set logcontent (\"\$logcontent\".[/log get \$int message])\r\
    \n\r\
    \n:if ([:find \$logcontent \"hotspot user\"] != \"\") do={\r\
    \n:local pos00 [:find \$logcontent \"hotspot user\"]\r\
    \n:local pos01 [:find \$logcontent \"added by\"]\r\
    \n:set novo [:pick \$logcontent (\$pos00 + 13) (\$pos01 -1)]\r\
    \n\r\
    \n/ip hotspot user set \"\$novo\" password=\"123\"\r\
    \n\r\
    \n:local valor\r\
    \n:local dia\r\
    \n:local aviso\r\
    \n:local bloqueio\r\
    \n:local mes\r\
    \n:local ano\r\
    \n:local anodiv\r\
    \n:local anomult\r\
    \n:local bissexto\r\
    \n:local ultimodia\r\
    \n:local mesnr\r\
    \n:local data [system clock get date]\r\
    \n:local hora [system clock get time]\r\
    \n\r\
    \n:set mes [:pick \$data 0 3]\r\
    \n:set dia [:pick \$data 4 6]\r\
    \n:set ano [:pick \$data 7 11]\r\
    \n:set aviso (\"\$dia\"+3)\r\
    \n:set bloqueio (\$dia+5)\r\
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
    \n:if (\$aviso=\"1\") do={:set aviso \"01\"}\r\
    \n:if (\$aviso=\"2\") do={:set aviso \"02\"}\r\
    \n:if (\$aviso=\"3\") do={:set aviso \"03\"}\r\
    \n:if (\$aviso=\"4\") do={:set aviso \"04\"}\r\
    \n:if (\$aviso=\"5\") do={:set aviso \"05\"}\r\
    \n:if (\$aviso=\"6\") do={:set aviso \"06\"}\r\
    \n:if (\$aviso=\"7\") do={:set aviso \"07\"}\r\
    \n:if (\$aviso=\"8\") do={:set aviso \"08\"}\r\
    \n:if (\$aviso=\"9\") do={:set aviso \"09\"}\r\
    \n\r\
    \n:if (\$bloqueio=\"1\") do={:set bloqueio \"01\"}\r\
    \n:if (\$bloqueio=\"2\") do={:set bloqueio \"02\"}\r\
    \n:if (\$bloqueio=\"3\") do={:set bloqueio \"03\"}\r\
    \n:if (\$bloqueio=\"4\") do={:set bloqueio \"04\"}\r\
    \n:if (\$bloqueio=\"5\") do={:set bloqueio \"05\"}\r\
    \n:if (\$bloqueio=\"6\") do={:set bloqueio \"06\"}\r\
    \n:if (\$bloqueio=\"7\") do={:set bloqueio \"07\"}\r\
    \n:if (\$bloqueio=\"8\") do={:set bloqueio \"08\"}\r\
    \n:if (\$bloqueio=\"9\") do={:set bloqueio \"09\"}\r\
    \n\r\
    \n:foreach h in=[/ip hotspot user find] do={\r\
    \n:local user [/ip hotspot user get \$h name]; \r\
    \n:local pass [/ip hotspot user get \$h password]; \r\
    \n:local ip [/ip hotspot user get \$h address];\r\
    \n:local mac [/ip hotspot user get \$h mac-address];\r\
    \n:local profile [/ip hotspot user get \$h profile];\r\
    \n\r\
    \n:if (\$profile =\".064k\") do={:set valor \"R\\\$ 30,00\"}\r\
    \n:if (\$profile =\".128k\") do={:set valor \"R\\\$ 40,00\"}\r\
    \n:if (\$profile =\".192k\") do={:set valor \"R\\\$ 50,00\"}\r\
    \n:if (\$profile =\".256k\") do={:set valor \"R\\\$ 60,00\"}\r\
    \n:if (\$profile =\".320k\") do={:set valor \"R\\\$ 70,00\"}\r\
    \n:if (\$profile =\".384k\") do={:set valor \"R\\\$ 80,00\"}\r\
    \n:if (\$profile =\".448k\") do={:set valor \"R\\\$ 90,00\"}\r\
    \n:if (\$profile =\".512k\") do={:set valor \"R\\\$ 100,00\"}\r\
    \n:if (\$profile =\".640k\") do={:set valor \"R\\\$ 110,00\"}\r\
    \n:if (\$profile =\".704k\") do={:set valor \"R\\\$ 120,00\"}\r\
    \n:if (\$profile =\".768k\") do={:set valor \"R\\\$ 130,00\"}\r\
    \n:if (\$profile =\".832k\") do={:set valor \"R\\\$ 140,00\"}\r\
    \n:if (\$profile =\".896k\") do={:set valor \"R\\\$ 150,00\"}\r\
    \n:if (\$profile =\".960k\") do={:set valor \"R\\\$ 160,00\"}\r\
    \n:if (\$profile =\"1M\") do={:set valor \"R\\\$ 170,00\"}\r\
    \n:if (\$profile =\"2M\") do={:set valor \"R\\\$ 180,00\"}\r\
    \n:if (\$profile =\"3M\") do={:set valor \"R\\\$ 190,00\"}\r\
    \n:if (\$profile =\"4M\") do={:set valor \"R\\\$ 200,00\"}\r\
    \n:if (\$profile =\"5M\") do={:set valor \"R\\\$ 210,00\"}\r\
    \n:if (\$profile =\"6M\") do={:set valor \"R\\\$ 220,00\"}\r\
    \n:if (\$profile =\"7M\") do={:set valor \"R\\\$ 230,00\"}\r\
    \n:if (\$profile =\"8M\") do={:set valor \"R\\\$ 240,00\"}\r\
    \n:if (\$profile =\"9M\") do={:set valor \"R\\\$ 250,00\"}\r\
    \n:if (\$profile =\"xFULL\") do={:set valor \"R\\\$ 300,00\"}\r\
    \n\r\
    \n:local mens \"var usuario=\\\"\$user\\\";\\r\\nvar senha=\\\"123\\\";\\r\
    \\nvar ip=\\\"\$ip\\\";\\r\\nvar mac=\\\"\$mac\\\";\\r\\nvar profile=\\\"\
    \$profile\\\";\\r\\nvar venc=\\\"\$dia\\\";\\r\\nvar aviso=\\\"\$aviso\\\"\
    ;\\r\\nvar bloqueio=\\\"\$bloqueio\\\";\\r\\nvar valor=\\\"\$valor\\\";\\r\
    \\nvar email=\\\"\\\";\\r\\nvar nome=\\\"\\\";\\r\\nvar nascimento=\\\"\\\
    \";\\r\\nvar endereco=\\\"\\\";\\r\\nvar bairro=\\\"\\\";\\r\\nvar cep=\\\
    \"\\\";\\r\\nvar referencia=\\\"\\\";\\r\\nvar fixo=\\\"\\\";\\r\\nvar cel\
    ular=\\\"\\\";\\r\\nvar instal=\\\"\$dia/\$mesnr/\$ano \E0s \$hora hrs.\\\
    \";\\r\\nvar contratado=\\\"\$profile\\\";\\r\\nvar kit=\\\"\\\";\\r\\nvar\
    \_equip=\\\"\\\";\\r\\nvar obs=\\\"\\\";\\r\\nvar ola=\\\"\\\";\\r\\nvar e\
    rro=\\\"\\\";\\r\\nvar ok=\\\"\\\";\\r\\n\\r\\n/*\\r\\n\\r\\nCliente cadas\
    trado em \$dia/\$mesnr/\$ano \E0s \$hora hrs.\\r\\n\\r\\n*/\"\r\
    \n\r\
    \n/file set \"hotspot/cadastro/NOVO-USER.txt\" contents=\"\$mens\"\r\
    \n\r\
    \n}\r\
    \n/tool fetch address=\"192.168.88.1\" src-path=\"hotspot/cadastro/NOVO-US\
    ER.txt\"  user=\"h3lyo\" mode=ftp password=\"123\" dst-path=\"hotspot/cada\
    stro/\$novo.txt\" port=21 host=\"\" keep-result=yes\r\
    \n\r\
    \n/system script run \"LIMPAR\"\r\
    \n\r\
    \n}\r\
    \n}\r\
    \n"
add name=9-RECUPERAR-SENHA policy=\
    ftp,reboot,read,write,policy,test,winbox,password,sniff,sensitive source="\
    :local logcontent\r\
    \n:local user\r\
    \n:local nasc\r\
    \n:local nascimento\r\
    \n:local pass\r\
    \n\r\
    \n:foreach int in=[/log find ] do={\r\
    \n:set logcontent (\"\$logcontent\".[/log get \$int message])\r\
    \n}\r\
    \n:if ([:find \$logcontent \"#<==~\"] != \"\") do={\r\
    \n:local pos00 [:find \$logcontent \"#<==~\"]\r\
    \n:local pos01 [:find \$logcontent \"#|\"]\r\
    \n:local pos02 [:find \$logcontent \"#~==>\"]\r\
    \n\r\
    \n:set user [:pick \$logcontent (\$pos00 + 5) \$pos01]\r\
    \n:set nasc [:pick \$logcontent (\$pos01 + 2) \$pos02]\r\
    \n\r\
    \n:local content [/file get [/file find name=\"hotspot/cadastro/\$user.txt\
    \"] contents] ;\r\
    \n:local pos03 [:find \$content \"var senha=\"]\r\
    \n:local pos04 [:find \$content \"var ip=\"]\r\
    \n:local pos05 [:find \$content \"var nascimento=\"]\r\
    \n:local pos06 [:find \$content \"var endereco=\"]\r\
    \n\r\
    \n:set pass [:pick \$content (\$pos03 + 11) (\$pos04  -4)]\r\
    \n:set nascimento [:pick \$content (\$pos05 + 16) (\$pos06  -4)]\r\
    \n}\r\
    \n:if (\$nasc=\"\$nascimento\") do={\r\
    \n/file set \"hotspot/errors.txt\" contents=\"invalid-username = A senha c\
    adastrada \E9: \$pass\";\r\
    \n/system script run \"LIMPAR\"\r\
    \n\r\
    \n:delay 15s\r\
    \n\r\
    \n/tool fetch address=\"192.168.88.1\" src-path=\"hotspot/lv/errors.txt\" \
    \_user=\"h3lyo\" mode=ftp password=\"123\" dst-path=\"hotspot/errors.txt\"\
    \_port=21 host=\"\" keep-result=yes}\r\
    \n\r\
    \n:delay 3s\r\
    \n/system script run \"LIMPAR\"\r\
    \n}\r\
    \n}"
add name=script1 policy=\
    ftp,reboot,read,write,policy,test,winbox,password,sniff,sensitive source="\
    \r\
    \n:local date [/system clock get date];\r\
    \n:local dayYear [:pick \$date ([:find \$date \"/\" 0] + 1) [:len \$date]]\
    ;\r\
    \n:local day [:pick \$dayYear 0 [:find \$dayYear \"/\" 0]];\r\
    \n:if (\$day => \"7\" and \$day < \"31\") do={  \r\
    \n/ ip hotspot user set [find profile=AVISO-05] profile=BLOQUEIO-05\r\
    \n\r\
    \n}\r\
    \n\r\
    \n"
