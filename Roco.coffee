set 'env', 'development'
set 'hosts', ['toomanyoranges.com']
set 'deployTo', '/srv/www/browserquest'
set 'appPort', 8082
set 'nodeEntry', 'client.js'

namespace 'deploy', ->
  task  'build', (done) -> run "cd #{roco.currentPath}/bin; ./build.sh"

namespace 'client', ->
    task  'start', (done) -> run "forever start /srv/www/browserquest/current/client.js"
    task  'stop', (done) -> run "forever stop /srv/www/browserquest/current/client.js" 
    task  'restart', (done) -> run "forever restart /srv/www/browserquest/current/client.js || forever start /srv/www/browserquest/current/client.js"
    task  'build', (done) -> run "cd #{roco.currentPath}/bin; ./build.sh"

namespace 'server', ->
    task  'start', (done) -> run "forever start /srv/www/browserquest/current/server/js/main.js"
    task  'stop', (done) -> run "forever stop /srv/www/browserquest/current/server/js/main.js"
    task  'restart', (done) -> run "forever restart /srv/www/browserquest/current/server/js/main.js || forever start /srv/www/browserquest/current/server/js/main.js"

