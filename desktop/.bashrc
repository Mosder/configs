[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\[\e[0;35m\][\u@\h \W]\$\[\e[0m\] '

alias bashcfg='vim ~/.bashrc'
alias die='shutdown -h 0'
alias protontricks='flatpak run com.github.Matoking.protontricks'
alias aghvpn='sudo openvpn ~/Downloads/VPN-AGH.2025.ovpn'
alias lobbycode='clip ~/.local/share/Steam/steamapps/common/PAYDAY\ 2/lobby_code'
alias livesplit='~/livesplit/LiveSplitOne'
alias grepfind='sudo find / | grep'

vmplayer() {
	sudo systemctl start vmware-networks.service
	command vmplayer
}	
restart() {
    konsole &
    disown
    exit
}
clip() {
	xclip -sel clip "$@"
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
music() {
	if [[ $# == 0 ]]; then
		command find /hdd/mosder/music -printf "\"%p\"\n" | grep .mp3 | xargs vlc
	else
		if [[ $@ == list ]]; then
			command ls -AldQ /hdd/mosder/music/*/ | grep -v ^downloadLinkFiles/$ | awk -F'"' '{print $2}' | awk -F'/' '{print $5}'
		elif [[ $@ == metal ]]; then
			music alestorm dickinson dżem fighters ghost gloryhammer maiden kult lindemann littlev grubasa metallica nanowar powerwolf rammstein peppers sabaton samurai lawder accept/ sevenfold pestilence purple/ emigrate iggy asgard queen rainbow
		else
			rx="\($1"
			for regexp in "${@:2}"
			do
				rx="$rx\|$regexp"
			done
			rx="$rx\)"
			command find /hdd/mosder/music -printf "\"%p\"\n" | grep -i "$rx.*\.mp3\"$" | xargs vlc
        fi
	fi
}
