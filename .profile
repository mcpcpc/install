#!/bin/sh
CORES=$(nproc || echo 1)

export CFLAGS="-O3 -pipe -march=native"
export CXXFLAGS=$CFLAGS
export MAKEFLAGS="-j$CORES"
export SAMUFLAGS=$MAKEFLAGS

paste () {
	curl -sF 'clbin=<'"${1:--}" https://clbin.com;
}

(read -r _ _ k _ </proc/version;IFS=. read -r s _ </proc/uptime;d=$((s/60/60/24));h=$((s/60/60%24));m=$((s/60%60));[ "$d" = 0 ]||u="$u ${d}d";[ "$h" = 0 ]||u=$u\ ${h}h;[ "$m" = 0 ]||u=$u\ ${m}m;. /etc/os-release;while IFS=: read -r a b;do b=${b%kB};case $a in MemT*)_=$((z+=b));_=$((y=b));; Shmem)_=$((z+=b));;MemF*|Buf*|Cac*|SR*)_=$((z-=b));esac;done </proc/meminfo;_=$((z/=1024));_=$((y/=1024));set -- /var/db/k*/ins*/*/;printf '%b\n' "
[34;1m    ___      [33m${USER:-$(id -un)}[m@[33;1m$(hostname)[m
[34;1m   ([37m.. [34m|     [31mos[m:     ${PRETTY_NAME:-Linux}
[34;1m   ([35m<> [34m|     [31mkernel[m: ${k:-linux}
[34;1m  / [37m__  [34m\\    [31mshell[m:  ${SHELL:-/bin/sh}
[34;1m ( [37m/  \\ [34m/|   [31muptime[m:${u:-0m}
[35;1m_[34m/\\ [37m__)[34m/[35m_[34m)   [31mpkgs[m:   $#
[35;1m\/[34m-____[35m\/    [31mmemory[m: ${z:-?}M / ${y:-?}M
") 2>/dev/null
