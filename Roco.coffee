set 'env', 'development'
set 'hosts', ['toomanyoranges.com']
set 'deployTo', '/srv/www/browserquest'
set 'appPort', 8082
set 'nodeEntry', 'client.js'


namespace 'deploy', ->
    task  'default', (done) -> sequence 'update', 'expressLink', 'clientConfig', 'serverConfig', 'build', 'clientRestart', 'serverRestart', done
    
    task 'expressLink', (done) -> run "cd #{roco.currentPath}; sudo npm link express", done

    task 'clientConfig', (done) -> run "cd #{roco.currentPath}/client/config; cp /srv/www/browserquest/config/client/config_build.json ./; cp /srv/www/browserquest/config/client/config_local.json ./;", done
    task 'serverConfig', (done) -> run "cd #{roco.currentPath}/server; cp /srv/www/browserquest/config/server/config_local.json ./;", done
    
    task  'build', (done) -> run "cd #{roco.currentPath}/bin; ./build.sh", done
    
    task 'clientRestart', (done) -> run "sudo -u node forever restart /srv/www/browserquest/current/client.js || sudo -u node forever start /srv/www/browserquest/current/client.js", done
    task 'serverRestart', (done) -> run "cd #{roco.currentPath}; sudo -u node forever restart server/js/main.js || sudo -u node forever start server/js/main.js", done
    


namespace 'client', ->
    task  'config', (done) -> run "cd #{roco.currentPath}/client/config; cp /srv/www/browserquest/config/client/config_build.json ./; cp /srv/www/browserquest/config/client/config_local.json ./;", done
    task  'start', (done) -> run "sudo -u node forever start /srv/www/browserquest/current/client.js", done
    task  'stop', (done) -> run "sudo -u node forever stop /srv/www/browserquest/current/client.js", done
    task  'restart', (done) -> run "sudo -u node forever restart /srv/www/browserquest/current/client.js || sudo -u node forever start /srv/www/browserquest/current/client.js", done

namespace 'server', ->
    task 'config', (done) -> run "cd #{roco.currentPath}/server; cp /srv/www/browserquest/config/server/config_local.json ./;", done
    task  'start', (done) -> run "cd #{roco.currentPath}; sudo -u node forever start server/js/main.js", done
    task  'stop', (done) -> run "cd #{roco.currentPath}; sudo -u node forever stop server/js/main.js", done
    task  'restart', (done) -> run "cd #{roco.currentPath}; sudo -u node forever restart server/js/main.js || sudo -u node forever start server/js/main.js", done