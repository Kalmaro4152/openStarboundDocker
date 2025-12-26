OPENSTARBOUND SERVER DOCKER CONTAINER

After much grueling work learning Docker and building this file it is ready to be uploaded to DockerHub and GitHub.

The idea of this container is to download the OpenStarbound server files, run it initially, create the files, crash, then be ready to launch again once the user provides the packed.pak file.

In order to use this file, pull the image from DockerHub, bind port 21025, set up a persistant data directory (I recommend /home/$USER/servers/starbound/) to be binded to the internally directory of (/home/starbound/openStarbound), then run the following commands {mkdir -p (your server directory)/starbound} and {chmod 777 (your server directory)/starboundan}, then finally run the container.

It will crash initially, as it will be missing the packed.pak file (can't distribute it, that's illegal), but all you have to do is to copy packed.pak from your (starbound/assets/) directory into (~/servers/openstarbound) and the entry script will move it to its correct location.

To mod the server, copy (or unzip) the steam workshop folders into the (stagedMods) folder, and it should automatically detect any mod that doesn't have a uniquely named contents.pak file. The script will automagically find the files, rename them, then put them into the mods folder.

To update, simply restart the container. Hopefully it doesn't blow up!

That's everything I think. I'll update this as I go. Thank you for checking out this project. Ĝis la revido!
