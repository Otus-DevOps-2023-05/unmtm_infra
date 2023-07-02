# unmtm_infra
unmtm Infra repository
Подключиться к someinternalhost можно с помощью команды 
ssh -J appuser@158.160.74.247 appuser@10.129.0.28

Для подключения по алиасу необходимо отредактировать файл nano ~/.ssh/config:

Host bastion
    HostName 158.160.74.247
    User appuser
    IdentityFile ~/.ssh/priv

Host someinternalhost
    HostName 10.129.0.28
    User appuser
    ProxyJump bastion
    IdentityFile ~/.ssh/priv

После чего можно подключаться к хостам через алиас.

bastion_IP = 158.160.74.247
someinternalhost_IP = 10.129.0.28
