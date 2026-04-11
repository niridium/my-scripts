if [[ ! -f $HOME/my_scripts/config/archive.conf ]] then
	echo "Configuration file not found, you can find a sample at 'config' directory"
	exit 2
fi

source ~/my_scripts/config/archive.conf

if [[ -z $1 || -n $2 ]] then 
	echo "Incorrect number of arguments"
	exit 1
elif [[ ! -d $1 ]]
then
	echo "Target doesn't exist"
	exit 1
else
	INPUT=$(echo $1 | sed -e 's#/$##') #Sanitize string removing last slash, correctly getting INPUT top directory

	if [[ ! -f $INPUT.tar ]] then
		tar -cf "$INPUT.tar" "$INPUT"
		echo "Tarball created"
	fi

	echo "Compressing..."
	nix run nixpkgs#zstd -- $ZSTD_PARAMETERS "$INPUT.tar"
fi
