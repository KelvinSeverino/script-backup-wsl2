#!/bin/bash
#===========================================================================================
#DECLARACAO DE VARIAVEIS DE CAMINHO PARA UNIDADE S                                         |
#===========================================================================================
FOLDER=/mnt/s
#===========================================================================================
# Verificando se a unidade S foi criada e montada
if [ -d "/mnt/s" ] 
then
    echo "Diretorio Unidade S existente" 
    # Verificando se a unidade S foi montada
    if [[ $(findmnt -M "$FOLDER") ]]; 
    then
        echo "Unidade S Mounted"
    else
        echo "Unidade S Not mounted...Montando unidade S"
        sudo mount -t drvfs S: /mnt/s
    fi
else
    echo "Diretorio Unidade S não existe...criando diretorio unidade S"
    sudo mkdir /mnt/s
    # Verificando se a unidade S foi montada
    if [[ $(findmnt -M "$FOLDER") ]]; 
    then
        echo "Unidade S Mounted"
    else
        echo "Unidade S Not mounted...Montando unidade"
        sudo mount -t drvfs S: /mnt/s
    fi
fi
#============================================================================================
#DECLARACAO DE VARIAVEIS DE CAMINHO PARA RSYNC                                              |
# - FILEIGNORED :: Arquivos que serão ignorados pelo rsync                                  |
# - DESTINO     :: Caminho para onde serão enviados os arquivos copiados                    |
# - USERNAME    :: Contem o nome do usuario                                                 |
#============================================================================================
USERNAME=$USER
# Arquivos que serão ignorados no backup
FILEIGNORED=/mnt/c/SCRIPT_BKP_PROFILE/arquivos_ignorados.txt
# Pastas que serão copiadas
DESKTOP=/mnt/c/Users/$USERNAME/Desktop
DOCUMENTOS=/mnt/c/Users/$USERNAME/Documents
IMAGENS=/mnt/c/Users/$USERNAME/Pictures
# Caminho onde as pastas copiadas serao armazenadas
DESTINO=/mnt/s/$USERNAME
#============================================================================================
#COMANDO RSYNC ABAIXO                                                                       |                                                
# -r :: cópia recursiva;                                                                    |
# -v :: de modo verbose, para mostrar na tela tudo o que esta sendo feito;                  |
# -z :: para compactar o arquivo durante a transferência (e descompactar no destino);       |
# -u :: modo update. Se o arquivo não foi atualizado, pula para o próximo, poupando tempo;  |
# -p :: preserva as permissões dos arquivos.                                                |
# -h :: exibe numeros de forma legivel para humanos                                         |
# --progess :: mostra todo o progresso do rsync                                             |
# --delete :: apaga arquivo do destino que nao tem na origem                                | log_bkp-$USERNAME-`date +%d_%m_%Y__%H_h_%M`.log
#=====================================================================================================================================================
rsync -rvzuh --exclude-from=$FILEIGNORED --progress --delete $DESKTOP $IMAGENS $DOCUMENTOS $DESTINO --log-file=/mnt/s/$USERNAME/log_script_backup/log_bkp_$USERNAME.log
#=====================================================================================================================================================
