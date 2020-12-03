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

In this configuration file, we have 4 major type command:
 * ssh: to access any remote server
 * ssc: execute a command in server without interactive inside it
``` bash
sscubuntu "ls -alh"
```
 * sst: create tunnel port from server to local machine
``` bash
sstubuntu 127.0.0.1:8080:127.0.0.1:8888  # create tunnel access remote port 8888 from your local port 8080
```
 * scp: copy file from server to local or local to server
``` bash
scpubuntu -s /home/ubuntu/file ~/mylocalmachine  # copy file or directory from remote to local
scpubuntu -c ~/mylocalmachine/file /home/ubuntu/   # copy file or directory from local to remote
```
