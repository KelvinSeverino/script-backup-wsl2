:: Cria a unidade S para acesso ao servidor de perfis
net use s: \\192.168.0.25\backups\profiles

:: Acessa a unidade S
s:

:: Verifica se pasta do usuario ja foi criada anteriormente
IF EXIST "%username%" (
	echo pasta ja criada anteriormente
) ELSE (
    :: Cria a pasta do usuário
	echo criando pasta do usuario
    mkdir %username%
)

:: Acessa a unidade C
c:

:: Acessa o local onde o script do Rsync esta localizado
cd C:\SCRIPT_BKP_PROFILE\

:: Roda o script do Rsync
wsl ./backup_profile_rsync.sh

:: Deleta a unidade S
net use s: /delete /y

:: Acessa a unidade C local
c:

:: Fecha o script
exit