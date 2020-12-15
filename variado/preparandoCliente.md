# Preparación de un Cliente

> [!IMPORTANT]
> Hay que tener en cuenta que para los ejemplos de los siguientes comandos
> usaré mi dominio de pruebas megainfo211.com

## Crear los directorios personales en el Server

`mkdir -p /home/LDAP/juan`

## Copiar el "esqueleto de necesario para el directorio de trabajo del usuario juan"

`cp /etc/skel/.bash_logout /home/LDAP/juan`
`cp /etc/skel/.bashrc /home/LDAP/juan`
`cp /etc/skel/.profile /home/LDAP/juan`

### Otorgar permisos sobre el directorio de trabajo

**el uid de juan es el 2050 y el de su grupo el 2000**
`chown 2050:2000 -R /home/LDAP/juan`

> [!IMPORTANT]
> En el cliente será necesario configurar e instalar los paquetes necesarios

*[Ver Configuración del Cliente...](./configurarCliente)*

