#!/bin/bash
for nsfolder in $( ls ); do
	if [ $nsfolder != "restore.sc" ] 
	then
		cd $nsfolder
		for cfolder in $( ls ); do
			cd $cfolder
			keyprop=$(<$PWD/keyprop.config)
			for scriptfile in $( ls ); do
				if [ $scriptfile != "keyprop.config" ] 
				then
					objects=$(<$PWD/$scriptfile)
					json="{\"Objects\":$objects,\"Parameters\":{\"KeyProperty\":\"$keyprop\"}}"
					curl -H 'Content-Type: application/json' -H 'securityToken: 123' -H 'log: log' -X POST -d "$json" $1/$nsfolder/$cfolder
					echo " "
				fi
			done
			cd ../
		done
		cd ../
	fi
done