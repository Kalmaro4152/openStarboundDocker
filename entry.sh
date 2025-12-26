#!/bin/bash

echo "Starting OpenStarbound Server..."
DATA="/home/starbound/openStarbound"

if [ ! -d "$DATA/linux/starbound_server" ]; then
    echo "First run detected, downloading OpenStarbound server..."

    wget -q --show-progress https://github.com/OpenStarbound/OpenStarbound/releases/download/v0.1.14/OpenStarbound-Linux-Clang-Server.zip
    unzip OpenStarbound-Linux-Clang-Server.zip
    echo "Removing top level zip"
    rm OpenStarbound-Linux-Clang-Server.zip
    tar -xvf server.tar
    echo "Removing second level tar"
    rm server.tar

    cd server_distribution

    mv --verbose -f assets "$DATA/"
    mv --verbose -f linux "$DATA/"
    mv --verbose -f mods "$DATA/"
    cd ..
    rm -rf server_distribution

    mkdir -p "$DATA/stagedMods"
    chmod -R u+rwx "$DATA"
fi

cd "$DATA"

echo "Finding packed.pak and moving it to assets"
find ./ -maxdepth 1 -type f -name "packed.pak" -print0 | xargs -0 -r mv -t ./assets/

echo "Finding contents.pak in various mod folders, renaming them, then moving them to the mods folder"
for folder in ./stagedMods/*; do
    [ -d "$folder" ] || continue
    foldername=$(basename "$folder")
    if [ -f "$folder/contents.pak" ]; then
        echo "Found $folder/contents.pak"
        mv -f "$folder/contents.pak" "./mods/$foldername.pak"
        echo "Moved to mods/$foldername.pak"
        [ -d "$folder" ] && rm -rf "$folder"
        echo "Removed the folder"
    fi
done

chown -R starbound:starbound "$DATA"

echo "Starting OpenStarbound server as non-root user..."

cd /home/starbound/openStarbound/linux
"./starbound_server"
