set --erase fish_greeting

fish_vi_key_bindings

function open
    command open $argv
end

function ls
    command ls --color=auto -h $argv
end

function df
    command df -h $argv
end

function du
    command du -h $argv
end

function free
    command free -h $argv
end

function bc
    command bc -l $argv
end

function info
    command info --vi-keys $argv
end

function sudo
    command sudo -E $argv
end

function curl
    command curl -L $argv
end

function cget
    curl -fJO --progress-bar --retry 10 -C - $argv
end

function speedtest
    curl -o /dev/null http://speedtest.atlanta.linode.com/100MB-atlanta.bin
end

function cal
    command cal $argv[-1..1]
end

function mail
    command mail -r $EMAIL $argv
end

function nyancat
    env TERM=xterm nyancat
end

function twitch
    source /mnt/crypt/foster/twitch/key

    set inres 1920x1080
    set offset 0,0
    set outres 1920x1080
    set fps 15
    set gop 30
    set gopmin 15
    set threads 2
    set cbr 1000k
    set quality fast
    set audio_rate 44100
    set uri rtmp://live-iad.twitch.tv/app/$stream_key

    ffmpeg -v warning -f x11grab -s $inres -r $fps -i $DISPLAY+$offset -f alsa -i pulse -f flv -ac 2 -ar $audio_rate -c:v libx264 -g $gop -keyint_min $gopmin -b:v $cbr -minrate $cbr -maxrate $cbr -pix_fmt yuv420p -s $outres -preset $quality -tune film -c:a libmp3lame -threads $threads -strict normal -bufsize $cbr $uri

    set -e stream_key
end

function record
    set res 1920x1080
    set offset 0,0
    set fps 15

    ffmpeg -v warning -f x11grab -s $res -r $fps -i $DISPLAY+$offset -f alsa -i pulse -pix_fmt yuv420p $argv
end
