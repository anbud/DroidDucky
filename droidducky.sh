#!/bin/bash

#
#	DroidDucky
#	Simple Duckyscript interpreter in Bash. Based on android-keyboard-gadget and hid-gadget-test utility.
#
#	Usage: droidducky.sh payload_file.txt
#
#	Copyright (C) 2015 - Andrej Budinčević <andrew@hotmail.rs>
#
#	This program is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	(at your option) any later version.
#
#	This program is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
#	GNU General Public License for more details.
#	You should have received a copy of the GNU General Public License
#	along with this program.	If not, see <http://www.gnu.org/licenses/>.
#

defdelay=0
while IFS='' read -r line || [[ -n "$line" ]]; do
	read -r cmd info <<< "$line"
	if [ "$cmd" == "STRING" ] 
	then
		for ((  i=0; i<${#info}; i++  )); do
			if [ "${info:$i:1}" == " " ]
			then
				echo space | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null
			elif [ "${info:$i:1}" == "!" ]
			then
				echo left-shift 1 | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null
			elif [ "${info:$i:1}" == "." ]
			then
				echo period | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null
			elif [ "${info:$i:1}" == "\`" ]
			then
				echo backquote | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null
			elif [ "${info:$i:1}" == "~" ]
			then
				echo tilde | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null
			elif [ "${info:$i:1}" == "+" ]
			then
				echo kp-plus | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null
			elif [ "${info:$i:1}" == "=" ]
			then
				echo equal | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null
			elif [ "${info:$i:1}" == "_" ]
			then
				echo left-shift minus | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null
			elif [ "${info:$i:1}" == "-" ]
			then
				echo minus | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null
			elif [ "${info:$i:1}" == "\"" ]
			then
				echo left-shift quote | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null
			elif [ "${info:$i:1}" == "'" ]
			then
				echo quote | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null
			elif [ "${info:$i:1}" == ":" ]
			then
				echo left-shift semicolon | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null
			elif [ "${info:$i:1}" == ";" ]
			then
				echo semicolon | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null
			elif [ "${info:$i:1}" == "<" ]
			then
				echo left-shift comma | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null
			elif [ "${info:$i:1}" == "," ]
			then
				echo comma | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null
			elif [ "${info:$i:1}" == ">" ]
			then
				echo left-shift period | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null
			elif [ "${info:$i:1}" == "?" ]
			then
				echo left-shift slash | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null
			elif [ "${info:$i:1}" == "\\" ]
			then
				echo backslash | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null
			elif [ "${info:$i:1}" == "|" ]
			then
				echo left-shift backslash | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null
			elif [ "${info:$i:1}" == "/" ]
			then
				echo slash | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null

			else
				case ${info:$i:1} in
				[[:upper:]])
					tmp=${info:$i:1}
					echo left-shift ${tmp,,} | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null
					;;
				*)
					echo ${info:$i:1} | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null
					;;
				esac
			fi
		done
	elif [ "$cmd" == "ENTER" ] 
	then
		echo enter | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null
	
	elif [ "$cmd" == "DELAY" ] 
	then
		((info = $info*1000))
		usleep $info

	elif [ "$cmd" == "WINDOWS" -o "$cmd" == "GUI" ] 
	then
		echo left-meta $info | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null

	elif [ "$cmd" == "MENU" -o "$cmd" == "APP" ] 
	then
		echo menu | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null

	elif [ "$cmd" == "DOWNARROW" -o "$cmd" == "DOWN" ] 
	then
		echo down | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null

	elif [ "$cmd" == "LEFTARROW" -o "$cmd" == "LEFT" ] 
	then
		echo left | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null

	elif [ "$cmd" == "RIGHTARROW" -o "$cmd" == "RIGHT" ] 
	then
		echo right | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null

	elif [ "$cmd" == "UPARROW" -o "$cmd" == "UP" ] 
	then
		echo up | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null

	elif [ "$cmd" == "DEFAULT_DELAY" -o "$cmd" == "DEFAULTDELAY" ] 
	then
		((defdelay = $info*1000))

	elif [ "$cmd" == "BREAK" -o "$cmd" == "PAUSE" ] 
	then
		echo pause | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null

	elif [ "$cmd" == "CAPSLOCK" ] 
	then
		echo capslock | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null

	elif [ "$cmd" == "DELETE" ] 
	then
		echo delete | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null

	elif [ "$cmd" == "END" ] 
	then
		echo end | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null

	elif [ "$cmd" == "ESC" -o "$cmd" == "ESCAPE" ] 
	then
		echo escape | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null

	elif [ "$cmd" == "HOME" ] 
	then
		echo home | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null

	elif [ "$cmd" == "INSERT" ] 
	then
		echo insert | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null

	elif [ "$cmd" == "NUMLOCK" ] 
	then
		echo numlock | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null

	elif [ "$cmd" == "PAGEUP" ] 
	then
		echo pageup | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null

	elif [ "$cmd" == "PAGEDOWN" ] 
	then
		echo pagedown | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null

	elif [ "$cmd" == "PRINTSCREEN" ] 
	then
		echo print | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null

	elif [ "$cmd" == "SCROLLLOCK" ] 
	then
		echo scrolllock | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null

	elif [ "$cmd" == "SPACE" ] 
	then
		echo space | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null

	elif [ "$cmd" == "TAB" ] 
	then
		echo tab | ./hid-gadget-test /dev/hidg0 keyboard > /dev/null

	#elif [ "$cmd" == "ALT" ] 
	#then
		# TODO: Implement ALT functionality

	#elif [ "$cmd" == "SHIFT" ] 
	#then
		# TODO: Implement SHIFT functionality

	#elif [ "$cmd" == "CONTROL" -o "$cmd" == "CTRL" ] 
	#then
		# TODO: Implement CTRL functionality

	fi

	usleep $defdelay
done < "$1"