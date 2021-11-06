#!/bin/bash
#
###############################################################################
#
# Common VT100 terminal programming escape codes implemented as functions
#
# Created by Oliver Molini 2021 (www.protoweb.org, www.steptail.com)
#
# Licensed under Creative Commons Attribution-ShareAlike 4.0.
# International Public License
# https://creativecommons.org/licenses/by-sa/4.0/
#
###############################################################################

# Set reverse video on screen
function setrevscrn { echo -en "\033[?5h"; }

# Set normal video on screen
function setnormscrn { echo -en "\033[?5l"; }

# Set interlacing mode
function setinter { echo -en "\033[?9h"; }

# Turn off character attributes
function modesoff { echo -en "\033[m"; }

# Turn bold mode on
function bold { echo -en "\033[1m"; }

# Turn low intensity mode on
function lowint { echo -en "\033[2m"; }

# Turn underline mode on
function underline { echo -en "\033[4m"; }

# Turn blinking mode on
function blink { echo -en "\033[5m"; }

# Turn reverse video on
function reverse { echo -en "\033[7m"; }

# Turn invisible text mode on
function invisible { echo -en "\033[8m"; }

# Move cursor up n lines
function cursorup { echo -en "\033[${1}A"; }

# Move cursor down n lines
function cursordn { echo -en "\033[${1}B"; }

# Move cursor right n lines
function cursorrt { echo -en "\033[${1}C"; }

# Move cursor left n lines
function cursorlf { echo -en "\033[${1}D"; }

# Move cursor to upper left corner
function cursorhome { echo -en "\033[H"; }

# Move cursor to screen location v,h
function cursorpos { echo -en "\033[${1};${2}H"; }

# Double-height letters, top half
function dhtop { echo -en "\033[#3"; }

# Double-height letters, bottom half
function dhbot { echo -en "\033[#4"; }

# Single width, single height letters
function swsh { echo -en "\033[#5"; }

# Double-width, single height letters
function dwsh { echo -en "\033[#6"; }

# Clear screen from cursor down
function cleareos { echo -en "\033[0J"; }

# Clear screen from cursor up
function clearbos { echo -en "\033[1J"; }

# Clear entire screen
function clearscreen { echo -en "\033[2J"; }

# Reset terminal to initial state
function reset { echo -en "\033c"; }

# Screen alignment display
function align { echo -en "\033#8"; }

# Set G0 special chars. & line set
function setspecg0 { echo -en "\033(0"; }

# Set G1 special chars. & line set
function setspecg1 { echo -en "\033)0"; }

# Set United States G0 character set
function setusg0 { echo -en "\033(B"; }

# Set United States G1 character set
function setusg1 { echo -en "\033)B"; }
