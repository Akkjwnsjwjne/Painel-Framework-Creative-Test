fx_version 'bodacious'
game 'gta5'
author '7w#1038'
version '1.0'

ui_page "nui/index.html"

files {
	"nui/*.*",
	"nui/**/*.*"
}

client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}