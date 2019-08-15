@ECHO OFF
del acptemplates.tar
7z a -ttar -mx=9 acptemplates.tar .\acptemplates\*
del files.tar
7z a -ttar -mx=9 files.tar .\files\*
del dev.hanashi.wsc.discord-api.tar
7z a -ttar -mx=9 dev.hanashi.wsc.discord-api.tar .\* -x!acptemplates -x!files -x!templates -x!dev.hanashi.wsc.discord-api.tar -x!.git -x!.gitignore -x!make.bat -x!make.sh