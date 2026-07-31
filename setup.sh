#!/bin/bash
echo -e "\033[96m"
echo ' _  __ ____  _     _ _____'
echo '/ |/ //  _ \/ \   / \\__  \'
echo '|   / | / \|| |   | |  /  |'
echo '|   \ | |-||| |_/\| | _\  |'
echo '\_|\_\\_/ \|\____/\_//____/'


# Install dependencies:
echo -e "\033[96m[+] Install system dependencies:\033[93m"
for i in i3 polybar python3-gi python3-gi-cairo python3-i3ipc libgtk-4-dev copyq rofi picom kitty obsidian feh xdotool
	do echo -e "\t${i}"
done

sudo apt install i3 polybar python3-gi python3-gi-cairo libgtk-4-dev copyq rofi picom kitty obsidian feh xdotool python3-i3ipc -y


# Taking backups in the event a roll back is wanted/need
echo -e "\033[96m[+] Taking backups of any found directories and configuration files...\033[0m" 

CONFIG_BU=$(find $HOME/.config/ -name i3 -o -name polybar -o -name kitty -o -name picom -o -name copyq)
for i in $CONFIG_BU
do echo -e "\t\033[93mmv ${i} ${i}_PRE_KALI3_BAK"; 
	sleep .5
	 mv "$i" "$i_PRE_KALI3_BAK"
done && echo -e "\033[92m[+] Backups taken successfully\033[0m"

TMUX_BU=$(find $HOME -name .tmux -o -name .tmux.conf)
if [[ $TMUX_BU != "" ]]
then
	for i in $TMUX_BU
	do sleep .5
		echo -e "\t\033[93mmv ${i} ${i}_PRE_KALI3_BAK" 
	 	mv "$i" "${i}_PRE_KALI3_BAK"
	done && echo -e "\033[92m[+] Backups taken successfully\033[0m"
fi
# Moving items into place:
# .config directories:
echo -e "\033[96m[+] Moving configs into place\033[0m" 
for i in i3 picom kitty polybar copyq
do sleep .5
	echo -e "\t\033[93mcp -a $PWD/$i $HOME/.config/$i"
	 cp -a "./${i}" "$HOME/.config/${i}"
done 
sleep .5
# Tmux:
echo -e "\t\033[93mcp -a $PWD/tmux/ $HOME/.tmux/"
sleep .5
cp -a ./tmux $HOME/.tmux
echo -e "\tcp -a $PWD/tmux.conf $HOME/.tmux.conf"
sleep .5
cp -a ./tmux.conf $HOME/.tmux.conf
# Fonts:
if [[ ! -d "$HOME/.local/share/fonts" ]]
then
	mkdir -p "$HOME/.local/share/fonts"
fi
echo -e "\tcp -a $PWD/*.ttf $HOME/.local/share/fonts/"
cp -a ./*.ttf $HOME/.local/share/fonts/
echo -e "\033[92m[+] Files moved successfully\033[0m"
echo 'export GTK_THEME=Adwaita:dark' >> $HOME/.profile
# Ready to roll
echo -e "\033[92m[+] Install has been completed. Please log out and select i3 as your session from the login screen\033[0m"
