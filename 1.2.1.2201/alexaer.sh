#!/bin/bash

COOLDOWN="false"

while true; do
  tail -n 10 /var/log/messages > /tmp/tmpLog
  if [[ ${COOLDOWN} == "false" ]]; then
    if grep "SetAlexaActive" /tmp/tmpLog; then
       if echo '{"type":"subscribe","module":"behaviors"}' | /anki/bin/websocat ws://localhost:8888/socket - | tr -d "[:space:]" | grep '"SleepCycle","Asleep"'; then
          echo '{"type":"data","module":"intents","data":{"intentType":"user","request":"show_clock"}}' | /anki/bin/websocat ws://localhost:8888/socket
          echo '{"type":"unsubscribe","module":"behaviors"}' | /anki/bin/websocat ws://localhost:8888/socket
          sleep 0.1
       fi
       curl -d "key=FakeButtonPressType&value=1" -X POST http://localhost:8889/consolevarset
       sleep 0.1
       curl -d "key=FakeButtonPressType&value=0" -X POST http://localhost:8889/consolevarset
       echo "cool"
       COOLDOWN="true"
    fi
  else
    echo "sleeping" 
    sleep 3
    echo "done sleeping"
    COOLDOWN="false"
  fi
  sleep 0.1 
done
