#!/usr/bin/env python3
import gi, subprocess, pyperclip
gi.require_version("Gtk","4.0")
from gi.repository import Gtk,GLib


network = []

ip_cmd = subprocess.run("ip a|grep '^[[:digit:]]'|grep -v 'state DOWN\|ligolo\| lo: \| docker'|cut -d: -f2|sed 's/ //'",shell=True,stdout=subprocess.PIPE,text=True)
interfaces = ip_cmd.stdout.split()
for iface in interfaces:
    parse_ip = subprocess.run("ip -4 addr show '" + iface +"'|grep inet|awk '{print $2}'|cut -d/ -f1",shell=True,text=True,stdout=subprocess.PIPE) 
    ip_addr = parse_ip.stdout
    network.append([iface,ip_addr.replace('\n','')])
    

def copy(event,ip):
    pyperclip.copy(ip)
    exit() 

def on_activate(app):
    window = Gtk.ApplicationWindow(application=app)
    window.set_title("Network Info:")
    window.set_default_size(300,100)

    box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
    box.set_margin_top(20)
    box.set_margin_bottom(20)
    #label = Gtk.Label(label="Active Interfaces (Click to Copy IP Addressi):")
    #window.add(label)
    for i in network:
        btn = Gtk.Button(label=str(i[0] + ": " + i[1]))
        btn.connect('clicked', copy, i[1])
        box.append(btn)

    window.set_child(box)
    window.present()

app = Gtk.Application(application_id="com.example.ip-copier")
app.connect("activate", on_activate)
app.run()
