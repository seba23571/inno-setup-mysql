[Setup]
AppName=EjecutaHeidisql
AppVerName=instaladorheidiMysql
DefaultGroupName=TestInstaladorMYSQL
; nota debe cambiar el camino hacia el directorio    \InstaladorParaMysql\
OutputDir=C:\Users\sebawin\Downloads\sharefolderXP\LinuxShared\instaladores\ejemplosHechos\InstaladorParaMysql\SalidaInstalador
AppPublisher=programador ingeniero en sistema con certificado oracle.
AppVersion=1.0
AllowNoIcons=false
AppCopyright=
PrivilegesRequired=admin

; Este es el nombre del archivo exe que se va a generar
OutputBaseFilename=MysqlTestInstallSetup
; Esta es la carpeta de instalación por defecto. OJO: {pf} es una variable propia de
; innosetup y significa la carpeta de Archivos de programa (o Program files si es
; un windows en inglés)
DefaultDirName={pf}\ProgramaCongreso
[Languages]
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"

[Tasks]
; Esto no se toca. Es la indicación para innosetup de que debe crear los íconos necesarios
; para iniciar el programa y para desinstalarlo
Name: desktopicon; Description: Create a &desktop icon; GroupDescription: Additional icons:

[Files]
; OJO: antes que todo. Los parámetros: regserver restartreplace shared file, etc. son
; parámetros que tienen que ir tal y como aparecen acá. Cuesta un poco comprenderlos.
; Por ahora los dejamos tal y como están acá.
; Otra cosa: {sys} = carpeta system de windows
;            {win} = carpeta windows de windows
;            {cf} = carpeta archivos comunes de windows
;            {tmp} = carpeta temporal de windows
;            {app} = carpeta donde se va a instalar el programa (fue definida arriba en el parámetro: DefaultDirName=
; -------------------------------------------------------------------------------------
; Aquí van los archivos de la aplicación: el .exe y otros que ocupe el programa    everyone-full

;C:\Users\sebasw7\Desktop\youtube\InstaladorParaMysql
; NOTA NOTA NOTA IMPORTANTE importante cambiar el Source a su camino personal de su pc hasta el directorio de \InstaladorParaMysql
Source: "C:\Users\sebawin\Downloads\sharefolderXP\LinuxShared\instaladores\ejemplosHechos\InstaladorParaMysql\HeidiSQL_9\heidisql.exe"; DestDir: "{app}"; Flags: "ignoreversion" ; Permissions: "everyone-modify"; 

source: "C:\Users\sebawin\Downloads\sharefolderXP\LinuxShared\instaladores\ejemplosHechos\InstaladorParaMysql\HeidiSQL_9\*"; DestDir: "{app}"; Flags: "ignoreversion recursesubdirs createallsubdirs"; Permissions: "everyone-modify"; 


Source: "C:\Users\sebawin\Downloads\sharefolderXP\LinuxShared\instaladores\ejemplosHechos\InstaladorParaMysql\complementos\*"; DestDir: "{tmp}"; Flags: "ignoreversion deleteafterinstall";Permissions: "everyone-modify"; 



[INI]

[Icons]
; Estos son los íconos que el instalador va a crear en el grupo de programas.
; Aquí se incluye: el ícono para abrir el programa, el ícono para desinstalar el programa
; y el ícono que se ubica en el escritorio
; OJO: {group} = nombre del grupo de programa que se definió arriba en el parámetro: DefaultGroupName=
Name: {group}\EjecutaHeidisql; Filename: {app}\heidisql.exe; WorkingDir: {app}; IconIndex: 0
Name: {group}\Desinstalar EjecutaHeidisql; Filename: {uninstallexe}
Name: {userdesktop}\EjecutaHeidisql; Filename: {app}\heidisql.exe; Tasks: desktopicon; WorkingDir: {app}; IconIndex: 0

[Run]
 Filename: "msiexec.exe" ;Parameters: "/i ""{tmp}\mysql-5.5.45-win32.msi"" /qn  INSTALLDIR=""C:\mysql""";WorkingDir:{tmp}; StatusMsg: "Instalando Motor de Base de Datos"; Description: "Instalar Motor de Base de Datos"; Flags: runhidden; 

Filename: C:\mysql\bin\mysqld.exe; Parameters: --install; WorkingDir: C:\mysql\bin; StatusMsg: Instalando Servicio MySQL; Description: Instalando  MySQL Server ; Flags: runhidden



Filename: net.exe; Parameters: start mysql; StatusMsg: Iniciando Servicio MySQL; Description: Iniciar Servicio MySQL; Flags: runhidden

Filename: C:\mysql\bin\mysql.exe; Parameters: "-uroot -hlocalhost -e ""SET PASSWORD FOR 'root'@'localhost'= PASSWORD('1024864')";     WorkingDir: {tmp}; StatusMsg: Creando usuario; Flags: runhidden

                            
                            
Filename: C:\mysql\bin\mysql.exe; Parameters: "-uroot -hlocalhost -pPasswordRoot -e ""create database congreso CHARACTER SET 'utf8' COLLATE utf8_spanish_ci";  WorkingDir: {tmp}; StatusMsg: Creando la Base dedatos; Flags: runhidden
                                                      

Filename: C:\mysql\bin\mysql.exe; Parameters: "-uroot -hlocalhost -pPasswordRoot -e ""CREATE USER 'sebas'@'localhost' IDENTIFIED BY '1024864'";   WorkingDir: {tmp}; StatusMsg: Creando usuario; Flags: runhidden
Filename: C:\mysql\bin\mysql.exe; Parameters: "-uroot -hlocalhost -pPasswordRoot -e ""GRANT ALL PRIVILEGES ON * . * TO 'sebas'@'localhost'";   WorkingDir: {tmp}; StatusMsg:  usuario privilegios; Flags: runhidden
Filename: C:\mysql\bin\mysql.exe; Parameters: "-uroot -hlocalhost -pPasswordRoot -e ""grant all on congreso.* to 'sebas'@'localhost'";  WorkingDir: {tmp}; StatusMsg: Otorgando permisos a base de dato; Flags: runhidden
Filename: C:\mysql\bin\mysql.exe; Parameters: "-uroot -hlocalhost -pPasswordRoot -e ""FLUSH PRIVILEGES";   WorkingDir: {tmp}; StatusMsg: terminado usuario; Flags: runhidden




                                                                                                                                                                             


Filename: C:\mysql\bin\mysql.exe; Parameters: "-usebas -hlocalhost -p1024864  -e ""use congreso; source congreso.sql;";  WorkingDir: {tmp}; StatusMsg: Base de Dato Congreso ingresando mas de 3000 registro paciencia; Flags: runhidden



[Messages]
; Estos mensajes simplemente son un override de los mensajes de Innosetup ya que vienen
; en inglés.
WelcomeLabel1=Instalación de gestor de base de datos para hacer purebas de tablas y usuarios creados con sus respectivas password.
WelcomeLabel2=Este proceso instalará Punto de venta CONGRESO en otros videos tutoriales .%n%nSe recomienda cerrar todas las aplicaciones abiertas%nantes de continuar.


