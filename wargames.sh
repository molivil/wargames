#!/bin/bash
#
###############################################################################
#
# Wargames WOPR sequence simulator v1.0
#
# To work properly, this script requires a recent version of bash and 
# a VT100 terminal
#
# VT100 specific functions provided by vt100.sh
#
# Created by Oliver Molini 2021 (www.protoweb.org, www.steptail.com)
#
# Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0.
# International Public License
# https://creativecommons.org/licenses/by-nc-sa/4.0/
#
###############################################################################

interactive="0"

source "./vt100.sh"

export keybuffer

function slowprint {
  text=$1
  for (( i=0; i<=${#text}; i++ ))
  do
    echo -n "${text:$i:1}" 
    if [[ ${text:$i:1} == " " ]]; then 
      echo -n #sleep .001; 
    else
      sleep .03; 
    fi
  done
}

function typesim {
  text=$1
  for (( i=0; i<=${#text}; i++ ))
  do
    if [[ ${text:$i:1} == " " ]]; then 
      sleep .2; 
    else
      sleep .$((1 + $RANDOM % 7))
    fi
    echo -n "${text:$i:1}"
  done
  if [[ ! $interactive == "1" ]]; then keybuffer="$text"; fi
}

function drawmap {
  modesoff
  setspecg0
  slowprint "    /ooooooooooo"; setusg0; slowprint "~";setspecg0; slowprint "o\\~                  "
    slowprint "                 srr/\\";echo
  slowprint "   x'              oo\\    sr,/oxx     "
    slowprint "               s/    ";underline; slowprint "/ ";modesoff;slowprint "rq'\\";echo
  slowprint "  /.                  \\sr/    /       "
    slowprint "    ss      s/o            \\,qq.rrss";echo
  slowprint " /                          /         "
    slowprint "   \' \\rq'oo                        o\\";echo
  slowprint " \                         x          "
    slowprint "  s/                                  \\";echo
  slowprint "  \                       /           "
    slowprint " /                             s    /";setusg0;slowprint "\`";setspecg0;slowprint "'"; echo
  slowprint "   ";setusg0; slowprint "\`"; setspecg0; slowprint ".srss                /            "
    setusg0; slowprint "|";setspecg0; slowprint "                          ,qq'/ /oo"; echo;setspecg0;
  slowprint "         o";setusg0; slowprint "\\"; setspecg0; slowprint "rr.  /oop'oo\\'\\            "
    slowprint " \              ssr.  /opqq\\   \/"; echo
  slowprint "              \/        \/            "
    slowprint "  ";setusg0; slowprint "\`"; setspecg0; slowprint ".rs         /    oo    //"; echo
  slowprint "                                      "
    slowprint "      o";setusg0; slowprint "\\"; setspecg0; slowprint "rr.s.r/           o";echo
  slowprint "       UNITED STATES                  "
  slowprint "           SOVIET UNION";echo
  setusg0
#  slowprint "       UNITED STATES                             SOVIET UNION";echo
}

function updatetrack {
  row=$(($RANDOM % 10))
  col=$(($RANDOM % 4))
  randno="$(($RANDOM % 10))$(($RANDOM % 10))$(($RANDOM % 10)) $(($RANDOM % 10))$(($RANDOM % 10))$(($RANDOM % 10))"
  if [[ $row == "5" ]]; then row=11; fi
  row=$(expr $row + 15)
  cols=$(expr $col \* 20 + 8)
  col=$(expr $col \* 20 + 10)
  cursorpos $row $col; echo -n "       "; cursorpos $row $cols
  sleep .4
  cursorpos $row $col; echo -n "$randno"; cursorpos $row $cols
}

function dologin {
rep=
while true; do
  slowprint "LOGON:  "
  if [[ $interactive == "1" ]]; then
    read rep
  else
    ((phase=phase+1))
    if [[ $phase == "1" ]]; then
      #sleep 2; typesim "Joshua"; sleep 1
      sleep 2; typesim "000001"; sleep 1
    elif [[ $phase == "2" ]]; then
      sleep 2; typesim "Help Logon"; sleep 1
    elif [[ $phase == "3" ]]; then
      sleep 3; typesim "Help Games"; sleep 1
    elif [[ $phase == "4" ]]; then
      sleep 3.5; typesim "List Games"; sleep 1
    elif [[ $phase == "5" ]]; then
      sleep 6; typesim ""; sleep 1
    elif [[ $phase == "6" ]]; then
      sleep 2.5; typesim "Falkens-Maze"; sleep 1
    elif [[ $phase == "7" ]]; then
      sleep 2; typesim "Armageddon"; sleep 1
    elif [[ $phase == "8" ]]; then
      sleep 4; typesim "Joshua"; sleep 1
    fi
    read rep <<< $keybuffer
    echo
  fi
  if [[ ${rep,,} == "help" ]]; then
    echo
    sleep 1
    slowprint "HELP NOT AVAILABLE"
    sleep 1
    echo
    echo
    echo
  elif [[ ${rep,,} == "help logon" ]]; then
    echo
    sleep 1
    slowprint "HELP NOT AVAILABLE"
    echo
    echo
    echo
  elif [[ ${rep,,} == "help games" ]]; then
    echo
    sleep 1
    slowprint "'GAMES' REFERS TO MODELS, SIMULATIONS AND GAMES"; echo
    slowprint "WHICH HAVE TACTICAL AND STRATEGIC APPLICATIONS."; echo
    echo
    echo
  elif [[ ${rep,,} == "joshua" ]]; then
    break
  elif [[ ${rep,,} == "list games" ]]; then
    echo
    sleep 1.5
    slowprint "FALKEN'S MAZE"; echo; sleep .5
    slowprint "BLACK JACK"; echo; sleep .5
    slowprint "GIN RUMMY"; echo; sleep .5
    slowprint "HEARTS"; echo; sleep .5
    slowprint "BRIDGE"; echo; sleep .5
    slowprint "CHECKERS"; echo; sleep .5
    slowprint "CHESS"; echo; sleep .5
    slowprint "POKER"; echo; sleep 1
    slowprint "FIGHTER COMBAT"; echo; sleep .75
    slowprint "GUERRILLA ENGAGEMENT"; echo; sleep .75
    slowprint "DESERT WARFARE"; echo; sleep .75
    slowprint "AIR-TO-GROUND ACTIONS"; echo; sleep .75
    slowprint "THEATERWIDE TACTICAL WARFARE"; echo; sleep .75
    slowprint "THEATERWIDE BIOTOXIC AND CHEMICAL WARFARE"; echo; sleep 1
    echo
    slowprint "GLOBAL THERMONUCLEAR WAR"; echo; sleep 2
    echo
    echo
  else
    echo
    sleep 1.5
    slowprint "INDENTIFICATION NOT RECOGNIZED BY SYSTEM"
    echo
    slowprint "--CONNECTION TERMINATED--"
    sleep 4
    echo
    clearscreen; cursorhome
  fi
done
}

# run in loop
while true; do

clearscreen; cursorhome
slowprint "      "; echo -n "             "
slowprint "   "; echo -n "               "
slowprint "     "; echo -n "           "
slowprint "      "; echo -n "           "
slowprint "    "; echo -n "           "
slowprint "  "; echo -n "             "
slowprint "     "; echo -n "               "
slowprint "       "; echo -n "           "
slowprint "        "; echo -n "           "
slowprint "  "; echo -n "           "
echo
phase=
dologin

echo
sleep 3
clearscreen; cursorhome
echo "#45     ^^456          ^^009          ^^893          ^^972          ^^315"
echo "PRT CON. 3.4.5.  SECTRAN 9.4.3.                      PORT STAT: SD-345"
echo
echo "(311) 699-7305"
echo -e "CONNECTION RESET \033[2J"
reverse
echo "TERMINAL CONNECTION RAW"
modesoff
clearscreen; #cursorhome
#echo; echo; echo; echo; echo; echo; echo; echo; echo; echo; echo; echo; echo; echo; echo; echo; echo
echo "(311) 936-3582"
clearscreen; cursorhome
echo; echo; echo; echo; echo; echo; echo; echo
echo "(311) 767-8739"
echo "(311) 936-2364"
echo "            PRT. STAT.                                   CRT. DEF."
echo "          ======================================================"
echo "               3453                                         3594"
cursorup 2
reverse
echo "(311) 888-8804"
modesoff
echo "FSKDJLSD: SDSDKJ: SDFJSL:                           DKSJL: SKFJJ: SDKFJLJ:"
echo "SYSPROC FUNCT READY                            ALT NET READY"
echo "CPU AUTH RV-345-AX8           SYSCOMP STATUS:  ALL PORTS ACTIVE"
echo "22/34534.90/3209                                          ^^CVB-3904-39490"
echo "(311) 936-2364"
reverse
echo "CONNECTION     # A-A-B-B-GREAD LINES VERIFY CODE 8/4/5/2"
modesoff
echo "(311) 936-3582"
echo "22/34534.90/3209                                          ^^CVB-3904-39490"
clearscreen; cursorhome
echo "12934-AD-43KJ: CONTR PAK"
echo "(311) 767-1083"
echo "     FLD CRS: 33.34.543   HPBS: 34/56/67/83/  STATUS FLT  034/304"
clearscreen; cursorhome
sleep .5
echo; echo; echo; echo; echo; echo; echo; echo; echo; echo; echo; echo; echo; echo; echo; echo; echo
reverse
echo "VERIFY CONTR RAW"
modesoff
echo "^^#5-45-F6-3456                  NOPR STATUS: TRAK OFF      PRON ACTIVE"
echo "#45:45:45 ^^ WER: 45/29/01  XCOMP: 43239582  YCOMP:3492930D  ZCOMP:343906834"
echo "PROM VERIFY                                           TRON: 65=65/74/24/65/87"
echo "            PRT. STAT.                                   CRT. DEF."
echo "          ======================================================"
echo "               3453                                         3594"
cursorup 2
echo "(311) 888-8804"
clearscreen; cursorhome
echo
echo "FL342     TK01    BM93    RG01    PZ90    GJ82    FP03    ZW08    JM89"
echo "REF TAPCON: 43.45342.349"
echo "SYSPROC FUNCT READY                            ALT NET READY"
echo
echo "CPU AUTH RV-345-AX8           SYSCOMP STATUS: ALL PORTS ACTIVE"
clearscreen; cursorhome
reverse
echo "VERIFY CONTR RAW"
modesoff
echo "^^#5-45-F6-3456                  NOPR STATUS: TRAK OFF      PRON ACTIVE"
echo "#45:45:45 ^^ WER: 45/29/01  XCOMP: 43239582  YCOMP:3492930D  ZCOMP:343906834"
echo "PROM VERIFY                                           TRON: 65=65/74/24/65/87"
echo "            PRT. STAT.                                   CRT. DEF."
echo "          ======================================================"
echo "               3453                                         3594"
cursorup 2
echo "(311) 888-8804"
clearscreen; cursorhome
echo "#45     ^^456          ^^009          ^^893          ^^972          ^^315"
echo "PRT CON. 3.4.5.  SECTRAN 9.4.3.                      PORT STAT: SD-345"
echo
echo "(311) 699-7305"
echo -e "CONNECTION RESET \033[2J"
reverse
echo "TERMINAL CONNECTION RAW"
modesoff
clearscreen; #cursorhome
#echo; echo; echo; echo; echo; echo; echo; echo; echo; echo; echo; echo; echo; echo; echo; echo; echo
echo "(311) 936-3582"
clearscreen
echo; echo; echo; echo; echo; echo; echo; echo
echo "(311) 767-8739"
echo "(311) 936-2364"
echo "            PRT. STAT.                                   CRT. DEF."
echo "          ======================================================"
echo "               3453                                         3594"
cursorup 2
reverse
echo "(311) 888-8804"
modesoff
cursorhome
echo "FSKDJLSD: SDSDKJ: SDFJSL:                           DKSJL: SKFJJ: SDKFJLJ:"
echo "SYSPROC FUNCT READY                            ALT NET READY"
echo "CPU AUTH RV-345-AX8           SYSCOMP STATUS:  ALL PORTS ACTIVE"
echo "22/34534.90/3209                                          ^^CVB-3904-39490"
echo "(311) 936-2364"
reverse
echo "CONNECTION     # A-A-B-B-GREAD LINES VERIFY CODE 8/4/5/2"
modesoff
echo "(311) 936-3582"
echo "22/34534.90/3209                                          ^^CVB-3904-39490"
clearscreen; cursorhome
echo; echo
sleep 4
slowprint "GREETINGS PROFESSOR FALKEN."
echo; echo

if [[ $interactive == "1" ]]; then
  read rep
else
  sleep 3; typesim "Hello."; sleep 1
  echo
fi
echo
echo
sleep 1
slowprint "HOW ARE YOU FEELING TODAY?"
echo
echo
if [[ $interactive == "1" ]]; then
  read rep
else
  sleep 3; typesim "I'm fine.  How are you?"; sleep 1
  rep=$keybuffer
  echo
fi
echo
echo
sleep 1
if [[ ${rep,,} == *"how are you?"* ]]; then
  slowprint "EXCELLENT.  "
fi
sleep .5
slowprint "IT'S BEEN A LONG TIME.  CAN YOU EXPLAIN"
echo
slowprint "THE REMOVAL OF YOUR USER ACCOUNT NUMBER ON 6/23/73?"
echo
echo
if [[ $interactive == "1" ]]; then
  read rep
else
  sleep 3; typesim "People sometimes make mistakes."; sleep 1
  rep=$keybuffer
  echo
fi
echo
sleep .5
if [[ ${rep,,} == *"make mistak"* ]]; then
  slowprint "YES THEY DO.  "
  sleep 2
fi
slowprint "SHALL WE PLAY A GAME?"
echo
echo
if [[ $interactive == "1" ]]; then
  read rep
else
  sleep 3; typesim "Love to.  How about Global Thermonuclear War?"; sleep 1
  rep=$keybuffer
  echo
fi
echo
sleep .5
if [[ ${rep,,} == *"global thermonuclear"* ]]; then
  slowprint "WOULDN'T YOU PREFER A GOOD GAME OF CHESS?"
fi
echo
echo

if [[ $interactive == "1" ]]; then
  read rep
else
  sleep 3; typesim "Later.  Let's play Global Thermonuclear War."; sleep 1
  rep=$keybuffer
  echo
fi
echo
sleep 1
slowprint "FINE."
sleep 5
clearscreen; cursorhome
drawmap
echo
slowprint "WHICH SIDE DO YOU WANT?";echo
echo
slowprint "  1.    UNITED STATES";echo
sleep .25
slowprint "  2.    SOVIET UNION";echo
sleep .5
echo
slowprint "PLEASE CHOOSE ONE:  "
modesoff
if [[ $interactive == "1" ]]; then
  read rep
else
  sleep 2; typesim "2 "; sleep 1
  rep=$keybuffer
  echo
fi
echo
cursorup 4
echo -n "                    "
sleep .5
cursorlf 20
echo -n "  2.    SOVIET UNION"
sleep .5
cursorlf 20
echo -n "                    "
sleep .5
cursorlf 20
echo -n "  2.    SOVIET UNION"
sleep .5
cursorlf 20
echo -n "                    "
sleep .5
cursorlf 20
echo -n "  2.    SOVIET UNION"
sleep .5
cursorlf 20
echo -n "                    "
sleep .5
cursorlf 20
echo -n "  2.    SOVIET UNION"
sleep .5
clearscreen; cursorhome
sleep .75
slowprint "AWAITING FIRST STRIKE COMMAND"; echo
setspecg0
echo      "ooooooooooooooooooooooooooooo"
setusg0
echo
sleep 1.25
slowprint "PLEASE LIST PRIMARY TARGETS BY";echo
slowprint "CITY AND/OR COUNTY NAME:";echo
echo
if [[ $interactive == "1" ]]; then
  read rep
else
  sleep 3; typesim "Las Vegas"; sleep 1
  rep=$keybuffer
  echo
fi

if [[ $interactive == "1" ]]; then
  read rep
else
  sleep 1; typesim "Seattle"; sleep 1
  rep=$keybuffer
  echo
fi

if [[ $interactive == "1" ]]; then
  read rep
else
  sleep 1; typesim ""; sleep 2
  rep=$keybuffer
  echo
fi

clearscreen; cursorhome
drawmap
blink
cursorpos 1 34; echo -n "."
cursorpos 2 35; echo -n ". ."
cursorpos 3 36; echo -n "."
cursorpos 7 31; echo -n "."
cursorpos 8 5; echo -n "."
cursorpos 8 30; echo -n "."
cursorpos 9 0; echo -n ". .";
cursorpos 9 28; echo -n ".. .";
cursorpos 10 4; echo -n "."
cursorpos 10 28; echo -n ". .";
modesoff
cursorpos 13 0;
sleep .5
slowprint "TRAJECTORY HEADING  TRAJECTORY HEADING  TRAJECTORY HEADING  TRAJECTORY HEADING";echo
#echo "T"
setspecg0
echo      "oooooooooooooooooo  oooooooooooooooooo  oooooooooooooooooo  oooooooooooooooooo"
setusg0
sleep 1.5
echo      "A-5520-A 939 523    C-5520-A 243 587    E-5520-A 398 984    G-5520-A 919 437  "
echo      "       B 664 295           B 892 754           B 394 345           B 132 147  "
echo      "       C 125 386           C 374 256           C 407 340           C 095 485  "
echo      "       D 456 374           D 826 684           D 251 953           D 095 485  "
echo      "       E 125 386           E 374 256           E 407 340           E 095 485  "
echo
echo      "B-5520-A 939 523    D-5520-A 243 587    F-5520-A 398 984    H-5520-A 919 437  "
echo      "       B 664 295           B 892 754           B 394 345           B 132 147  "
echo      "       C 125 386           C 374 256           C 407 340           C 095 485  "
echo      "       D 456 374           D 826 684           D 251 953           D 095 485  "
echo -n   "       E 125 386           E 374 256           E 407 340           E 095 485  "
modesoff
sleep 1.25
phase=
while true; do
  ((phase=phase+1))
  updatetrack
  sleep .05
  if [[ $phase == "30" ]]; then cursorpos 1 14; echo -n "////"; fi
  if [[ $phase == "55" ]]; then cursorpos 2 13; echo -n "////"; fi
  if [[ $phase == "75" ]]; then cursorpos 3 12; echo -n "////"; fi
  if [[ $phase == "78" ]]; then cursorpos 1 4; echo -n "\\\\\\\\"; fi
  if [[ $phase == "95" ]]; then cursorpos 4 11; echo -n "////"; fi
  if [[ $phase == "97" ]]; then cursorpos 2 5; echo -n "\\\\\\\\"; fi
  if [[ $phase == "115" ]]; then cursorpos 5 10; echo -n "/\\/\\/\\"; fi
  if [[ $phase == "118" ]]; then cursorpos 3 5; echo -n "\\/\\/\\"; fi
  if [[ $phase == "135" ]]; then cursorpos 6 9; echo -n "/\\/\\/\\/\\"; fi
  if [[ $phase == "138" ]]; then cursorpos 4 4; echo -n "/\\/\\/\\"; fi
  if [[ $phase == "165" ]]; then break; fi
done
clearscreen
cursorpos 11 25; echo "*****************************"
cursorpos 12 25; echo "*                           *"
cursorpos 13 25; echo "*     USER DISCONNECTED     *"
cursorpos 14 25; echo "*                           *"
cursorpos 15 25; echo "*****************************"
cursorhome
sleep .75; setrevscrn
sleep .75; setnormscrn
sleep .75; setrevscrn
sleep .75; setnormscrn
sleep .75; setrevscrn
sleep .75; setnormscrn
sleep .75; setrevscrn
sleep .75; setnormscrn
clearscreen
sleep 4

# end loop
done