#!/bin/bash

# DroidDucky
# Simple Duckyscript interpreter in Bash. Based on android-keyboard-gadget and hid-gadget-test utility.
#
# Usage: droidducky.sh payload_file.txt
#
# Copyright (C) 2015 - Andrej Budinčević <andrew@hotmail.rs>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

defdelay=0
kb="/dev/hidg0 keyboard"
while IFS='' read -r line || [[ -n "$line" ]]; do
	read -r cmd info <<< "$line"
	if [ "$cmd" == "STRING" ] 
	then
		for ((  i=0; i<${#info}; i++  )); do
			kbcode="";

			if [ "${info:$i:1}" == " " ]
			then
				kbcode='space'
			elif [ "${info:$i:1}" == "!" ]
			then
				kbcode='left-shift 1'
			elif [ "${info:$i:1}" == "." ]
			then
				kbcode='period'
			elif [ "${info:$i:1}" == "\`" ]
			then
				kbcode='backquote'
			elif [ "${info:$i:1}" == "~" ]
			then
				kbcode='left-shift tilde'
			elif [ "${info:$i:1}" == "+" ]
			then
				kbcode='kp-plus'
			elif [ "${info:$i:1}" == "=" ]
			then
				kbcode='equal'
			elif [ "${info:$i:1}" == "_" ]
			then
				kbcode='left-shift minus'
			elif [ "${info:$i:1}" == "-" ]
			then
				kbcode='minus'
			elif [ "${info:$i:1}" == "\"" ]
			then
				kbcode='left-shift quote'
			elif [ "${info:$i:1}" == "'" ]
			then
				kbcode='quote'
			elif [ "${info:$i:1}" == ":" ]
			then
				kbcode='left-shift semicolon'
			elif [ "${info:$i:1}" == ";" ]
			then
				kbcode='semicolon'
			elif [ "${info:$i:1}" == "<" ]
			then
				kbcode='left-shift comma'
			elif [ "${info:$i:1}" == "," ]
			then
				kbcode='comma'
			elif [ "${info:$i:1}" == ">" ]
			then
				kbcode='left-shift period'
			elif [ "${info:$i:1}" == "?" ]
			then
				kbcode='left-shift slash'
			elif [ "${info:$i:1}" == "\\" ]
			then
				kbcode='backslash'
			elif [ "${info:$i:1}" == "|" ]
			then
				kbcode='left-shift backslash'
			elif [ "${info:$i:1}" == "/" ]
			then
				kbcode='slash'
			elif [ "${info:$i:1}" == "{" ]
			then
				kbcode='left-shift lbracket'
			elif [ "${info:$i:1}" == "}" ]
			then
				kbcode='left-shift rbracket'
			elif [ "${info:$i:1}" == "(" ]
			then
				kbcode='left-shift 9'
			elif [ "${info:$i:1}" == ")" ]
			then
				kbcode='left-shift 0'
			elif [ "${info:$i:1}" == "[" ]
			then
				kbcode='lbracket'
			elif [ "${info:$i:1}" == "]" ]
			then
				kbcode='rbracket'
			elif [ "${info:$i:1}" == "#" ]
			then
				kbcode='left-shift 3'
			elif [ "${info:$i:1}" == "@" ]
			then
				kbcode='left-shift 2'
			elif [ "${info:$i:1}" == "$" ]
			then
				kbcode='left-shift 4'
			elif [ "${info:$i:1}" == "%" ]
			then
				kbcode='left-shift 5'
			elif [ "${info:$i:1}" == "^" ]
			then
				kbcode='left-shift 6'
			elif [ "${info:$i:1}" == "&" ]
			then
				kbcode='left-shift 7'
			elif [ "${info:$i:1}" == "*" ]
			then
				kbcode='kp-multiply'

			else
				case ${info:$i:1} in
				[[:upper:]])
					tmp=${info:$i:1}
					kbcode="left-shift ${tmp,,}"
					;;
				*)
					kbcode="${info:$i:1}"
					;;
				esac
			fi

			if [ "$kbcode" != "" ]
			then
				echo "$kbcode" | ./hid-gadget-test $kb > /dev/null
			fi
		done
	elif [ "$cmd" == "ENTER" ] 
	then
		echo enter | ./hid-gadget-test $kb > /dev/null
	
	elif [ "$cmd" == "DELAY" ] 
	then
		((info = info*1000))
		usleep $info

	elif [ "$cmd" == "WINDOWS" -o "$cmd" == "GUI" ] 
	then
		echo left-meta ${info,,} | ./hid-gadget-test $kb > /dev/null

	elif [ "$cmd" == "MENU" -o "$cmd" == "APP" ] 
	then
		echo menu | ./hid-gadget-test $kb > /dev/null

	elif [ "$cmd" == "DOWNARROW" -o "$cmd" == "DOWN" ] 
	then
		echo down | ./hid-gadget-test $kb > /dev/null

	elif [ "$cmd" == "LEFTARROW" -o "$cmd" == "LEFT" ] 
	then
		echo left | ./hid-gadget-test $kb > /dev/null

	elif [ "$cmd" == "RIGHTARROW" -o "$cmd" == "RIGHT" ] 
	then
		echo right | ./hid-gadget-test $kb > /dev/null

	elif [ "$cmd" == "UPARROW" -o "$cmd" == "UP" ] 
	then
		echo up | ./hid-gadget-test $kb > /dev/null

	elif [ "$cmd" == "DEFAULT_DELAY" -o "$cmd" == "DEFAULTDELAY" ] 
	then
		((defdelay = info*1000))

	elif [ "$cmd" == "BREAK" -o "$cmd" == "PAUSE" ] 
	then
		echo pause | ./hid-gadget-test $kb > /dev/null

	elif [ "$cmd" == "ESC" -o "$cmd" == "ESCAPE" ] 
	then
		echo escape | ./hid-gadget-test $kb > /dev/null

	elif [ "$cmd" == "PRINTSCREEN" ] 
	then
		echo print | ./hid-gadget-test $kb > /dev/null

	elif [ "$cmd" == "CAPSLOCK" -o "$cmd" == "DELETE" -o "$cmd" == "END" -o "$cmd" == "HOME" -o "$cmd" == "INSERT" -o "$cmd" == "NUMLOCK" -o "$cmd" == "PAGEUP" -o "$cmd" == "PAGEDOWN" -o "$cmd" == "SCROLLLOCK" -o "$cmd" == "SPACE" -o "$cmd" == "TAB" \
	-o "$cmd" == "F1" -o "$cmd" == "F2" -o "$cmd" == "F3" -o "$cmd" == "F4" -o "$cmd" == "F5" -o "$cmd" == "F6" -o "$cmd" == "F7" -o "$cmd" == "F8" -o "$cmd" == "F9" -o "$cmd" == "F10" -o "$cmd" == "F11" -o "$cmd" == "F12" ] 
	then
		echo "${cmd,,}" | ./hid-gadget-test $kb > /dev/null

	elif [ "$cmd" == "REM" ] 
	then
		echo "$info"

	elif [ "$cmd" == "SHIFT" ] 
	then
		if [ "$info" == "DELETE" -o "$info" == "END" -o "$info" == "HOME" -o "$info" == "INSERT" -o "$info" == "PAGEUP" -o "$info" == "PAGEDOWN" -o "$info" == "SPACE" -o "$info" == "TAB" ] 
		then
			echo "left-shift ${info,,}" | ./hid-gadget-test $kb > /dev/null

		elif [ "$info" == *"WINDOWS"* -o "$info" == *"GUI"* ] 
		then
			read -r gui char <<< "$info"
			echo "left-shift left-meta ${char,,}" | ./hid-gadget-test $kb > /dev/null

		elif [ "$info" == "DOWNARROW" -o "$info" == "DOWN" ] 
		then
			echo left-shift down | ./hid-gadget-test $kb > /dev/null

		elif [ "$info" == "LEFTARROW" -o "$info" == "LEFT" ] 
		then
			echo left-shift left | ./hid-gadget-test $kb > /dev/null

		elif [ "$info" == "RIGHTARROW" -o "$info" == "RIGHT" ] 
		then
			echo left-shift right | ./hid-gadget-test $kb > /dev/null

		elif [ "$info" == "UPARROW" -o "$info" == "UP" ] 
		then
			echo left-shift up | ./hid-gadget-test $kb > /dev/null

		else
			echo "Parse error: $cmd $info"
		fi

	elif [ "$cmd" == "CONTROL" -o "$cmd" == "CTRL" ] 
	then
		if [ "$info" == "BREAK" -o "$info" == "PAUSE" ] 
		then
			echo left-ctrl pause | ./hid-gadget-test $kb > /dev/null

		elif [ "$info" == "F1" -o "$info" == "F2" -o "$info" == "F3" -o "$info" == "F4" -o "$info" == "F5" -o "$info" == "F6" -o "$info" == "F7" -o "$info" == "F8" -o "$info" == "F9" -o "$info" == "F10" -o "$info" == "F11" -o "$info" == "F12" ] 
		then
			echo "left-ctrl ${cmd,,}" | ./hid-gadget-test $kb > /dev/null

		elif [ "$info" == "ESC" -o "$info" == "ESCAPE" ] 
		then
			echo left-ctrl escape | ./hid-gadget-test $kb > /dev/null

		elif [ "$info" == "" ]
		then
			echo left-ctrl | ./hid-gadget-test $kb > /dev/null

		else 
			echo "left-ctrl ${info,,}" | ./hid-gadget-test $kb > /dev/null
		fi

	elif [ "$cmd" == "ALT" ] 
	then
		if [ "$info" == "END" -o "$info" == "SPACE" -o "$info" == "TAB" \
		-o "$info" == "F1" -o "$info" == "F2" -o "$info" == "F3" -o "$info" == "F4" -o "$info" == "F5" -o "$info" == "F6" -o "$info" == "F7" -o "$info" == "F8" -o "$info" == "F9" -o "$info" == "F10" -o "$info" == "F11" -o "$info" == "F12" ] 
		then
			echo "left-alt ${info,,}" | ./hid-gadget-test $kb > /dev/null

		elif [ "$info" == "ESC" -o "$info" == "ESCAPE" ] 
		then
			echo "left-alt escape" | ./hid-gadget-test $kb > /dev/null

		elif [ "$info" == "" ]
		then
			echo left-alt | ./hid-gadget-test $kb > /dev/null

		else 
			echo "left-alt ${info,,}" | ./hid-gadget-test $kb > /dev/null
		fi

	elif [ "$cmd" == "ALT-SHIFT" ] 
	then
		echo left-shift left-alt | ./hid-gadget-test $kb > /dev/null

	elif [ "$cmd" == "CTRL-ALT" ] 
	then
		if [ "$info" == "BREAK" -o "$info" == "PAUSE" ] 
		then
			echo left-ctrl left-alt pause | ./hid-gadget-test $kb > /dev/null

		elif [ "$info" == "END" -o "$info" == "SPACE" -o "$info" == "TAB" -o "$info" == "DELETE" -o "$info" == "F1" -o "$info" == "F2" -o "$info" == "F3" -o "$info" == "F4" -o "$info" == "F5" -o "$info" == "F6" -o "$info" == "F7" -o "$info" == "F8" -o "$info" == "F9" -o "$info" == "F10" -o "$info" == "F11" -o "$info" == "F12" ] 
		then
			echo "left-ctrl left-alt ${cmd,,}" | ./hid-gadget-test $kb > /dev/null

		elif [ "$info" == "ESC" -o "$info" == "ESCAPE" ] 
		then
			echo left-ctrl left-alt escape | ./hid-gadget-test $kb > /dev/null

		elif [ "$info" == "" ]
		then
			echo left-ctrl left-alt | ./hid-gadget-test $kb > /dev/null

		else 
			echo "left-ctrl left-alt ${info,,}" | ./hid-gadget-test $kb > /dev/null
		fi

	elif [ "$cmd" == "CTRL-SHIFT" ] 
	then
		if [ "$info" == "BREAK" -o "$info" == "PAUSE" ] 
		then
			echo left-ctrl left-shift pause | ./hid-gadget-test $kb > /dev/null

		elif [ "$info" == "END" -o "$info" == "SPACE" -o "$info" == "TAB" -o "$info" == "DELETE" -o "$info" == "F1" -o "$info" == "F2" -o "$info" == "F3" -o "$info" == "F4" -o "$info" == "F5" -o "$info" == "F6" -o "$info" == "F7" -o "$info" == "F8" -o "$info" == "F9" -o "$info" == "F10" -o "$info" == "F11" -o "$info" == "F12" ] 
		then
			echo "left-ctrl left-shift ${cmd,,}" | ./hid-gadget-test $kb > /dev/null

		elif [ "$info" == "ESC" -o "$info" == "ESCAPE" ] 
		then
			echo left-ctrl left-shift escape | ./hid-gadget-test $kb > /dev/null

		elif [ "$info" == "" ]
		then
			echo left-ctrl left-shift | ./hid-gadget-test $kb > /dev/null

		else 
			echo "left-ctrl left-shift ${info,,}" | ./hid-gadget-test $kb > /dev/null
		fi

	elif [ "$cmd" != "" ] 
	then
		echo "Parse error: $cmd"
	fi

	usleep $defdelay
done < "$1"