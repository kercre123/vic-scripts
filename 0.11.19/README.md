0.11.19 is the demo software used in pre-release demos of Vector. I like this software a lot since it is very active and different. However, it uses old servers which are not fully functional. Currently, the voice server itself is up but the token server is not. There is no server_config.json for this vic-cloud so that cannot be changed. This gets a token from the new server periodically.

Also included is a script which fixes some commands like "roll your cube"

scp this custom folder into /anki/bin/

Put a dumped emr partition in the path /anki/bin/custom/elemedicalrecord

You will also need to auth in a newer firmware and put the token.jwt in /anki/bin/custom/weirdpath/persistent/token/token.jwt

Put a newdev server_config.json in /anki/bin/custom/server_config.json

Put vic-cloud in /anki/bin/

Put vic-token.service in /lib/systemd/system/ then run `systemctl daemon-reload` then `systemctl enable vic-token`

This only works with the newdev ddl servers
