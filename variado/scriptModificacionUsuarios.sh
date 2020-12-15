#!/bin/bash
while read i     
    do
        uid="$(echo $i| cut -d ":" -f2)"
        homeDirectory="$(echo $i| cut -d ":" -f8)"
        uidNumber="$(echo $i| cut -d ":" -f4)"
        gidNumber="$(echo $i| cut -d ":" -f6)"
        mkdir $homeDirectory
        cp /etc/skel/.bash_logout $homeDirectory
        cp /etc/skel/.bashrc $homeDirectory
        cp /etc/skel/.profile $homeDirectory
        chown $uidNumber:$gidNumber $homeDirectory
        echo "dn: uid=$uid,ou=people,dc=megainfo211,dc=com" >> modificacion.ldif
        echo "changetype: modify" >> modificacion.ldif
        echo "replace: homeDirectory" >> modificacion.ldif
        echo "homeDirectory: $homeDirectory" >> modificacion.ldif
        echo "" >> modificacion.ldif
    done <./temporalFINAL.txt
ldapmodify -x -D "cn=admin,dc=megainfo211,dc=com" -W -f modificacion.ldif