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
    
    task 'clientRestart', (done) -> run "forever restart /srv/www/browserquest/current/client.js || forever start /srv/www/browserquest/current/client.js", done
    task 'serverRestart', (done) -> run "forever restart /srv/www/browserquest/current/server/js/main.js || forever start /srv/www/browserquest/current/server/js/main.js", done
    


namespace 'client', ->
    task  'start', (done) -> run "forever start /srv/www/browserquest/current/client.js", done
    task  'stop', (done) -> run "forever stop /srv/www/browserquest/current/client.js", done
    task  'restart', (done) -> run "forever restart /srv/www/browserquest/current/client.js || forever start /srv/www/browserquest/current/client.js", done

namespace 'server', ->
    task  'start', (done) -> run "forever start /srv/www/browserquest/current/server/js/main.js", done
    task  'stop', (done) -> run "forever stop /srv/www/browserquest/current/server/js/main.js", done
    task  'restart', (done) -> run "forever restart /srv/www/browserquest/current/server/js/main.js || forever start /srv/www/browserquest/current/server/js/main.js", done

