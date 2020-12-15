# Herramietas Examen LDIF

## [1.- Crear Base.](LDIF/base.ldif)
## [2.- Modelo Crear Usuario.](LDIF/juan.ldif)
## [3.- Mofificacion de usuario.](LDIF/CambioJuan.ldif)
## [4.- Mofificacion varios usuarios.](LDIF/modificacion.ldif)
## [5.- Eliminar Campos.](LDIF/eliminarMail.ldif)
## [6.- Prepararaciones para un cliente.](LDIF/eliminarMail.ldif)
## BASH:
> [!IMPORTANT]
> Hay que tener en cuenta que para los ejemplos de los siguientes comandos
> usaré mi dominio de pruebas megainfo211.com
### Añadir datos a OpenLDAP desde fichero LDIF:

`ldapadd -x -W -D cd=admin,dc=megainfo211,dc=com -f base.ldif`

> [!TIP]
> Para evitar posibles errores declaramos una variable con el nombre dn Ej: miServer="cn=admin,dc=megainfo211,dc=com"
> Conseguimos ldapadd -x -W -D $miServer -f fichero.ldif

`miServer='"cn=admin,dc=megainfo211,dc=com"'`

### Modificar atributos de Objetos de OpenLDAP desde fichero LDIF:

`ldapmodify -x -W -D $miServer -f modificacion.ldif`

### Borrar usuario y Objetos de OpenLDAP:

`ldapdelete -W -D $miServer "uid=elpepe,ou=people,dc=megainfo211,dc=com"`

### Buscar un usuario u objeto de OpenLDAP:

`ldapsearch -LL -x -b "uid=elpepe,ou=people,dc=megainfo211,dc=com"`


### VER LISTADO DE ARIBUTOS

[Listado de Atributos LDIF](https://www.zytrax.com/books/ldap/ape/)