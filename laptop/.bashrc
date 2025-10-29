[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\[\e[0;35m\][\u@\h \W]\$\[\e[0m\] '

alias bashcfg='vim ~/.bashrc'
alias hyprcfg='vim ~/.config/hypr/hyprland.conf'
alias die='shutdown -h 0'
alias aghvpn='sudo openvpn ~/Downloads/VPN-AGH.2025.ovpn'
alias grepfind='sudo find / | grep'

restart() {
    konsole &
	disown
    exit
}
clip() {
	wl-copy < "$@"
}
open(){
	for file in "$@"
	do
		xdg-open "$file"
	done
}
resizeVideo() {
	if [[ $# != 3 ]]; then
		echo "Usage: resizeVideo <input-file> <output-file> <size-in-MiB>"
	else
		inputFile=$1
		outputFile=$2
		sizeInMiB=$3
		videoLength=$(ffprobe -i $inputFile -show_entries format=duration -v quiet -of csv="p=0")
		bitrateInkb=$(echo "$sizeInMiB*8300/$videoLength" | bc)
		ffmpeg -y -i $inputFile -c:v libx264 -b:v ${bitrateInkb}k -pass 1 -an -f null /dev/null && \
		ffmpeg -i $inputFile -c:v libx264 -b:v ${bitrateInkb}k -pass 2 -c:a aac -b:a 128k $outputFile
		rm ffmpeg2pass-0.log ffmpeg2pass-0.log.mbtree
	fi
}
