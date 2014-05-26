alias sudo="sudo -E"

alias minecraft="optirun java -jar ~/.minecraft/Minecraft.jar"
alias technic="optirun java -jar ~/.technic/TechnicLauncher.jar"
alias fnetup="sudo systemctl start openvpn@foosternet"
alias fnetdown="sudo systemctl stop openvpn@foosternet"
alias virtup="sudo systemctl start libvirtd && virt-manager"
alias virtdown="killall virt-manager && sudo systemctl stop libvirtd"
