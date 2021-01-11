#!/bin/bash
# Este script parte de la premisa de que es un entorno nuevo y no hay uidnumbers utilizados
uidNumber=2009
# Comprobar si whois esta intalado, es necesario para el uso de este script
if [ $(apt policy whois| grep -w "Instalados: (ninguno)"| wc -l) -ne 0 ]
        then
            echo "Es necesario que tenga instalado la siguientes herramientas: whois"
            apt-get install whois -y
            clear
            echo "Paquete whois a sido instalado"
            sleep 1
            echo "Generando fichero LDIF..."
fi
# Comprobar si el fichero existe    
if [ -f creacionUsuarios.ldif ]
        then
            echo "Ya existe un fichero de creacionUsuarios en el directorio actual"
            exit 1
fi    
while read i 
    do
        uid=$(echo $i| cut -d "," -f5) >> creacionUsuarios.ldif
        sn=$(echo $i| cut -d "," -f2) >> creacionUsuarios.ldif
        givenName=$(echo $i| cut -d "," -f1) >> creacionUsuarios.ldif
        cn=$(echo $i| cut -d "," -f1)$(echo $i| cut -d "," -f2) >> creacionUsuarios.ldif
        uidNumber=$(($uidNumber+1)) >> creacionUsuarios.ldif
        gidNumber=2000 >> creacionUsuarios.ldif
#       Contraseña en texto plano fichero de datos
        contra=$(echo $i| cut -d "," -f5) >> creacionUsuarios.ldif
#       Contraseña cifrada MD5
        userPassword=$(mkpasswd -m md5 $contra) >> creacionUsuarios.ldif
#       userPassword=$(mkpasswd -m sha-512 $contra)
        homeDirectory="/home/$givenName" >> creacionUsuarios.ldif
        loginShell="/bin/bash" >> creacionUsuarios.ldif
        mail=$(echo $i| cut -d "," -f3) >> creacionUsuarios.ldif
#       Ruta foto Ej: /ana
        foto=$(echo $i| cut -d "," -f4) >> creacionUsuarios.ldif
        jpegPhoto="< file:/root/scriptOpenLDAP/$foto" >> creacionUsuarios.ldif
#       Creación del fichero LDIF
        echo "dn: uid=$uid,ou=people,dc=megainfo211,dc=com" >> creacionUsuarios.ldif
        echo "objectClass: top" >> creacionUsuarios.ldif
        echo "objectClass: posixAccount" >> creacionUsuarios.ldif
        echo "objectClass: inetOrgPerson" >> creacionUsuarios.ldif
        echo "objectClass: shadowAccount" >> creacionUsuarios.ldif
        echo "uid: $uid" >> creacionUsuarios.ldif
        echo "sn: $sn" >> creacionUsuarios.ldif
        echo "givenName: $givenName" >> creacionUsuarios.ldif
        echo "cn: $cn" >> creacionUsuarios.ldif
        echo "uidNumber: $uidNumber" >> creacionUsuarios.ldif
        echo "gidNumber: $gidNumber" >> creacionUsuarios.ldif
        echo "userpassword: $userPassword" >> creacionUsuarios.ldif
        echo "homeDirectory: $homeDirectory" >> creacionUsuarios.ldif
        echo "loginShell: $loginShell" >> creacionUsuarios.ldif
        echo "mail: $mail" >> creacionUsuarios.ldif
        echo "jpegPhoto: $foto" >> creacionUsuarios.ldif
#       Espacio necesario por sintaxis        
        echo "" >> creacionUsuarios.ldif
    done <./datos.txt
    echo "Fichero ldif creado en el directorio actual"
    ls -l creacionUsuarios.ldif
    sleep 1
    echo "Añadiendo usuarios al servicio de directorios..."
    sleep 0.5
    echo ""
    ldapadd -x -W -D cn=admin,dc=megainfo211,dc=com -f creacionUsuarios.ldif
    echo ""
    echo "Listo"