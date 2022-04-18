1.2.1.2201 is a master-dev Vector software which has an old Alexa implementation which I like. However, the robot does not react to the wake word "alexa". It gets recognized and put into the messages log, but alexa does not get activated. This script does that.

SCP alexaer.sh into /anki/bin/ and vic-alexaer.service into /lib/systemd/system, run `systemctl daemon-reload` then `systemctl enable vic-alexaer` then `systemctl start vic-alexaer`
