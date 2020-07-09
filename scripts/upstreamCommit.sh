#!/usr/bin/env bash
(
set -e
PS1="$"

function changelog() {
    base=$(git ls-tree HEAD $1  | cut -d' ' -f3 | cut -f1)
    cd $1 && git log --oneline ${base}...HEAD
}
nukkit=$(changelog NukkitX)

updated=""
logsuffix=""
if [ ! -z "$nukkit" ]; then
    logsuffix="$logsuffix\n\nNukkitX Changes:\n$nukkit"
    if [ -z "$updated" ]; then updated="NukkitX"; else updated="$updated/NukkitX"; fi
fi
disclaimer="The upstream version of this project has released new changes.\nThis project cleanly compiles against those changes but has not been fully tested. As with any changes, CompMC recommends you do your own testing."

if [ ! -z "$1" ]; then
    disclaimer="$@"
fi

log="${UP_LOG_PREFIX}Updated Upstream ($updated)\n\n${disclaimer}${logsuffix}"

echo -e "$log" | git commit -F -

) || exit 1
