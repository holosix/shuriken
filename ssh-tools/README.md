# TL,DR;
``` bash
$ SSH_CONFIG=config-ssh.json GENERATED_CONFIG=. node generate-ssh.js
```

# How to use this config
Given sample config-ssh.json, this code will generate list of aliasing ssh name, you can easily access any server without using other GUI (SSH tools)

``` bash
[
  {
    "host": "ubuntu",
    "hostName": "127.0.0.1",
    "port": "22",
    "user": "root",
    "password": "123456"
  },
  {
    "host": "ubuntu2",
    "hostName": "127.0.0.1",
    "port": "23",
    "user": "root",
    "identityFile": "/home/my_ssh_private_key"
  }
]
```

Output generated ssh file:
``` bash
export ubuntuserver=127.0.0.1
export ubuntupass='123456'
alias sshubuntu='sshrc root@${ubuntuserver} -p 22 $ubuntupass'
alias sscubuntu='sshpass -p  $ubuntupass ssh root@${ubuntuserver} -p 22 -t '
alias sstubuntu='sshpass -p $ubuntupass ssh root@${ubuntuserver} -p 22 -N -f -L '
alias ssdubuntu='sshpass -p $ubuntupass ssh root@${ubuntuserver} -p 22 -D 8035 -f -C -q -N '
alias scpubuntu='my-scp "root@${ubuntuserver}" "$ubuntupass" "-P 22"'

export ubuntu2server=127.0.0.1
export ubuntu2pass='undefined'
alias sshubuntu2='sshrc root@${ubuntu2server} -p 23 -i /home/my_ssh_private_key'
alias sscubuntu2='sshpass -p  $ubuntu2pass ssh root@${ubuntu2server} -p 23 -t '
alias sstubuntu2='sshpass -p $ubuntu2pass ssh root@${ubuntu2server} -p 23 -N -f -L '
alias ssdubuntu2='sshpass -p $ubuntu2pass ssh root@${ubuntu2server} -p 23 -D 8035 -f -C -q -N '
alias scpubuntu2='my-scp "root@${ubuntu2server}" "$ubuntu2pass" "-P 23"'

```

For security reason, you should use private key to access your server instead of plain text password. If you'd like to use plain text password, you must install `sshpass`

However, you can access [here](https://google.com) to know how to use SSH Private Key

In this configuration file, we have 4 major type command:
 * `ssh`: to access any remote server
 * `ssc`: execute a command in server without interactive inside it
``` bash
sscubuntu "ls -alh"
```
 * `sst`: create tunnel port from server to local machine
``` bash
sstubuntu 127.0.0.1:8080:127.0.0.1:8888  # create tunnel access remote port 8888 from your local port 8080
```
 * `scp`: copy file from server to local or local to server
``` bash
scpubuntu -s /home/ubuntu/file ~/mylocalmachine  # copy file or directory from remote to local
scpubuntu -c ~/mylocalmachine/file /home/ubuntu/   # copy file or directory from local to remote
```
