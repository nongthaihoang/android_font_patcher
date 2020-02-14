#!/usr/bin/bash

if [ -n $1 ]; then
    case $1 in
		-cn )	FONT=Roboto/RobotoCondensed
				NAME="Roboto Condensed"
				shift
				;;

		* )		FONT=Roboto/Roboto
				NAME=$FONT
				;;
    esac
else
	exit
fi

for i in "$@"
do
	STYLE=none
	if [[ $i == *"-Regular."* ]]; then
		STYLE=Regular
	elif [[ $i == *"-Italic."* ]]; then
		STYLE=Italic
	elif [[ $i == *"-Light."* ]]; then
		STYLE=Light
		NAME=$NAME" Light"
	elif [[ $i == *"-LightItalic."* ]]; then
		STYLE=LightItalic
		NAME=$NAME" Light"
	elif [[ $i == *"-Thin."* ]]; then
		STYLE=Thin
		NAME=$NAME" Thin"
	elif [[ $i == *"-ThinItalic."* ]]; then
		STYLE=ThinItalic
		NAME=$NAME" Thin"
	elif [[ $i == *"-Medium."* ]]; then
		STYLE=Medium
		NAME=$NAME" Medium"
	elif [[ $i == *"-MediumItalic."* ]]; then
		STYLE=MediumItalic
		NAME=$NAME" Medium"
	elif [[ $i == *"-Bold."* ]]; then
		STYLE=Bold
	elif [[ $i == *"-BoldItalic."* ]]; then
		STYLE=BoldItalic
	elif [[ $i == *"-Black."* ]]; then
		STYLE=Black
		NAME=$NAME" Black"
	elif [[ $i == *"-BlackItalic."* ]]; then
		STYLE=BlackItalic
		NAME=$NAME" Black"
	fi

	if [[ $STYLE != none ]]; then
		RBT=$FONT-$STYLE.ttf
		fontforge -script fontpatcher.pe $RBT $i "$NAME"
		TMP=${i/./-patched.}
		OUT=$(dirname $TMP)
		mkdir -p $OUT/Roboto
		RBT=$OUT/$RBT
		mv $TMP $RBT
	fi
done
