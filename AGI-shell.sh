#!/bin/bash

conect="mysql -uroot -pjefao -e"
declare -a array
while read -e ARG && [ "$ARG" ] ; do
        array=(` echo $ARG | sed -e 's/://'`)
        export ${array[0]}=${array[1]}
done

# Recebendo Variaveis do Asterisk no lancamento
echo $agi_request >&2
echo $agi_channel >&2
echo $agi_language >&2
echo $agi_type >&2
echo $agi_uniqueid >&2
echo $agi_callerid >&2
echo $agi_dnid >&2
echo $agi_rdnis >&2
echo $agi_context >&2
echo $agi_extension >&2
echo $agi_priority >&2
echo $agi_enhanced >&2

checkresults() {
        while read line
                do
                case ${line:0:4} in
                        "200 " ) echo $line >&2
                                 return;;
                        "510 " ) echo $line >&2
                                 return;;
                        "520 " ) echo $line >&2
                                 return;;
                        *      ) echo $line >&2;;       #Continua lendo ate um possivel erro
                                                        #Tipo um "520 End ..."
                esac
        done
}

sql=(`$conect "SELECT password FROM VipReal.peers WHERE name = $agi_callerid"`)
pass=${sql[1]}


echo "1.  Testando Playback ..." >&2
echo "STREAM FILE beep \"\""
checkresults

echo "2.  Mandando texto pro canal ..." >&2
echo "send text \"que\ bruxaria\ essa?\""
checkresults

echo "3.  Setando variavel ..." >&2
echo "set variable \"CHANNEL(language)\" pt_BR"
checkresults

echo "4.  Testando 'saynumber' ..." >&2
echo "SAY NUMBER $agi_extension \"\""
checkresults

echo "5.  Setando variavel ..." >&2
echo "set variable Bla $pass"
checkresults

echo "6.  Testando 'say phonetic' ..." >&2
echo "say phonetic gsm \"\""
checkresults

echo "6a.  playback" >&2
echo "STREAM FILE tt-monkeys \"\" "
checkresults

echo "" >&2
echo "verbose $1"
checkresults                                                                                      