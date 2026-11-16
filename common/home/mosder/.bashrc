[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\[\e[0;35m\][\u@\h \W]\$\[\e[0m\] '

alias sudo='sudo '
alias vim='nvim'
alias bashcfg='vim ~/.bashrc'
alias hyprcfg='vim ~/.config/hypr/hyprland.lua'
alias die='shutdown -h 0'
alias grepfind='sudo find / | grep'
alias rfm='ranger'
alias lobbycode='clip ~/.local/share/Steam/steamapps/common/PAYDAY\ 2/lobby_code'

# yaptide
alias yap='~/projects/yap/start.sh'

restart() {
    wezterm &
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
music() {
    if [[ $# == 0 ]]; then
        find /nfs/music -printf "\"%p\"\n" | grep \\.opus\"$ | xargs vlc
    else
        rx="\($1"
        for regexp in "${@:2}"
        do
            rx="$rx\|$regexp"
        done
        rx="$rx\)"
        find /nfs/music -printf "\"%p\"\n" | grep -i "$rx.*\.opus\"$" | xargs vlc
    fi
}
reenc() {
    res="\nRESULT:"
    for f in "$@"; do
        ext=$(echo "$f" | awk -F. '{print $NF}' | tr A-Z a-z)
        len=${#ext}
        res+="\n$f "
        if [[ "$f" == "$ext" ]]; then
            res+="- couldn't determine extension"
        else
            case $ext in
                jpeg | jpg | png | webp | avif)
                    out=${f::-$len}avif
                    ffmpeg -i "$f" "tmp-$out"
                    mv "tmp-$out" "$out"
                    res+="-> $out"
                    ;;
                mp3 | webm | flac | wav | opus)
                    out=${f::-$len}opus
                    ffmpeg -i "$f" "tmp-$out"
                    mv "tmp-$out" "$out"
                    res+="-> $out"
                    ;;
                mp4 | mkv | webm | avi)
                    out=${f::-$len}mkv
                    ffmpeg -i "$f" -c:v libsvtav1 -c:a libopus "tmp-$out"
                    mv "tmp-$out" "$out"
                    res+="-> $out"
                    ;;
                *)
                    res+="- not supported extension"
                    ;;
            esac
        fi
    done
    printf "$res"
}

export PATH="$PATH:/home/mosder/.bin:/home/mosder/.local/bin:/usr/bin"
