# Minimal Kali i3 setup:
This setup features a minimal i3 setup. This desktop is meant to be ran in a virtual machine.
Currently, this i3 setup lacks many basic utilities such as (these features may be added at a later point): 
- Controlling audio
- Connecting bluetooth
- Adjusting Brightness
- Managing wireless networks

As it currently stands, this i3 setup only supports a single monitor. Support will be added eventually. 

*Please note, mileage may vary depending on which hypervisor you are using. VMWare Player has been pretty stable in my testing.*

# Software Requirements:
The following packages will need to be installed from the Kali repos:
- i3
- polybar
- python3-gi
- python3-gi-cairo
- libgtk-4-dev
- copyq
- rofi
- picom
- kitty
- obsidian
- feh

## Nerd fonts:
Icons in the polybar can be a little hit-or-miss. I would recommend having Meslo fonts installed in either ~/.fonts/ or ~/.local/share/fonts/ 

# Keybindings:
My general thought process is SUPER key controls i3 while ALT controls tmux.

## i3 Keybindings:
| Key Combo | Description |
| --- | --- |
| Super + Enter | Start Kitty|
| Super + t | Start a tmux session|
| Super + Space | Launch Rofi |
| Super + o | Start Obsidian |
| Super + f | Launch Firefox |
| Super + b | Launch Burpsuite |
| Super + v | Open a clipboard manager|
| Super + z | Toggle full screen |
| Super + **ARROW KEYS** | Change focused window |

## Tmux Keybindings:
| Key Combo | Description |
| --- | --- |
| ALT + O | Open a Vertical Pane |
| ALT + e | Open a Horizontal Pane |
| ALT + b | Toggle broadcast mode on/off (Sends keystrokes to all visible panes|
| ALT + **ARROW KEYS** | Change focused pane |
| ALT + z | Toggle full screen mode |
| ALT + v or Scroll through terminal | Enter Copy mode |

### Tmux Copy Mode bindings:
I have included the Vi copy mode. It adds a ton of versatility to your productivity.
| Key Combo | Description |
| --- | --- |
| / | Search below cursor for a specified string or pattern|
| ? | Search above cursor for a specified string or pattern|
| space | Set markers for the beginning and end of text to be copied within your terminal buffer |
| y | Copy the highlighted text to your system clipboard|
| ESC or Enter | Exit copy mode |

### Tmux Logging:
I have created a simple bash script which enables tmux logging. This is especially helpful for hands-on certifications, CTFs, and real engagements where you need to write a report, as this will allow you recollect all commands ran and their output. The log files will be saved in your current directory under ./logs/tmux.log. I also have implemented simple rotation such that the you do not lose any of the command output. 


# Installation:
## Automagic install script:
```
cd kali3

chmod +x setup.sh

./setup.sh
```

## Manual install:
```
cd kali3

cp -a ./tmux/ ~/.tmux

cp -a ./tmux.conf ~/.tmux.conf

for i in i3 polybar kitty; do cp -a "./${i}" "~/.config/";done

cp -a ./MesloLGSNerdFont-Regular.ttf ~/.local/share/fonts/

sudo apt install i3 polybar python3-gi python3-gi-cairo libgtk-4-dev copyq rofi picom kitty obsidian feh
```
Then log out and select i3 as your session. 

