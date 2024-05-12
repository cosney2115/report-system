fx_version 'cerulean'
game 'gta5'

name 'report system'
author 'cosney'

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua'
}

server_script 'server/main.lua'

client_script 'client/main.lua'

lua54 'yes'