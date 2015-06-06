#SCRIPT DE CONTROLE DE ACK
:global interface 8; <strong>#Definir aqui o numero de interfaces wireless existentes
 :global ack ;
 :global cont;
 :global res;
 :global valor;
 :global mac ;
 :global ack2;
 :global confirm;
 :global cliente;
 :set ack 0;
 :set cont 0;
 :set res 0;
 :set valor 0;
 :set mac 0;
 :set ack2 0;
 :set confirm 0;
:set cliente 0;
:for j from=1 to=$interface step=1 do={
:foreach i in=[/interface wireless registration-table find interface="wlan$j"] do={
:set ack [/interface wireless registration-table get $i ack];
:set valor (valor+ack)
:set cont (cont+1)
}
 
:set res ((valor / cont)+10)
 
:foreach i in=[/interface wireless registration-table find interface="wlan$j"] do={
:set confirm ([/interface wireless registration-table get $i ack-timeout] > $res);
:if ($confirm=true) do={
:set cont (cont+1)
:set mac [/interface wireless registration-table get $i mac-address];
:set cliente [/interface wireless registration-table find mac-address=$mac];
:set ack2 [/interface wireless registration-table get $i ack-timeout];
:log info "Desconectado cliente da interface wlan$j seu mac : $mac o ack dele erra: $ack2 "
/interface wireless registration-table remove $cliente;
 
}
}
:set ack 0;
:set cont 0;
:set res 0;
:set valor 0;
:set mac 0;
:set ack2 0;
:set confirm 0;
:set cliente 0;
};
