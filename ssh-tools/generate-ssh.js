const fs = require('fs')

let sshConfig = process.env['SSH_CONFIG']
let generatedConfig = process.env['GENERATED_CONFIG'] + '/ssh.conf'

let config_ssh = JSON.parse(fs.readFileSync(sshConfig, 'utf8'));

let auth = ""
let fileConfig = ""
let sshConf = ""
let ssh_alias = ""

config_ssh.forEach(function(item) {
  host = item.host;
  hostName = item.hostName;
  port = item.port;
  user = item.user;
  password = item.password;

  auth = auth + "machine " + host + " login " + user + " password " + password + "\n";

  if (item.identityFile && typeof item.identityFile !== 'undefined') {
    fileConfig = fileConfig + "Host " + host + "\n" +
      "\t HostName " + hostName + "\n" +
      "\t Port " + port + "\n" +
      "\t User " + user + "\n" +
      "\t IdentityFile " + item.identityFile + "\n" + "\n";
      ssh_alias = "alias " + "ssh" + host + "=" + "'sshrc " + user + "@${" + host + "server" + "}" + " -p " + port + " -i " + item.identityFile + "'";
  } else {
    fileConfig = fileConfig + "Host " + host + "\n" +
      "\t HostName " + hostName + "\n" +
      "\t Port " + port + "\n" +
      "\t User " + user + "\n" + "\n";
      ssh_alias = "alias " + "ssh" + host + "=" + "'sshrc " + user + "@${" + host + "server" + "}" + " -p " + port + " $" + host + "pass" + "'";
  }

  sshConf = sshConf + "export " + host + "server=" + hostName + "\n" +
    "export " + host + "pass='" + password + "'\n" +

    ssh_alias + "\n" +

  // execute command: sscubuntu netstat -tupln
    "alias " + "ssc" + host + "=" + "'sshpass " + "-p " + " $" + host + "pass" + " ssh " + user + "@${" + host + "server" + "}" + " -p " + port + " -t " + "'" + "\n" +

  // tunneling: sstbdcrawler5 localhost:8889:10.102.254.6:9090
    "alias " + "sst" + host + "=" + "'sshpass " + "-p " + "$" + host + "pass" + " ssh " + user + "@${" + host + "server" + "}" + " -p " + port + " -N -f -L " + "'" + "\n" +    

  // create web proxy with ssh tunneling SOCKs V5, default proxy: 127.0.0.1:8035
    "alias " + "ssd" + host + "=" + "'sshpass " + "-p " + "$" + host + "pass" + " ssh " + user + "@${" + host + "server" + "}" + " -p " + port + " -D 8035 -f -C -q -N " + "'" + "\n" +    

  // scpyngpu -s /root/crawl-youtube/only_id_error_11.json .
  // scpvlab2 -c crawl-youtube /root/.pm2/system
    "alias " + "scp" + host + "=" + "'my-scp " + '"' + user + "@${" + host + "server" + '}" ' + '"' + "$" + host + 'pass"' + ' "-P ' + port + '"' + "'" + "\n\n";
})


fs.writeFileSync(generatedConfig, sshConf)
