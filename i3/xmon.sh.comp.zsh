#compdef xmon
cfgs=($(ls ~/.display/*.cfg | xargs basename -s .cfg))
_values , ${cfgs[@]}
return 0
