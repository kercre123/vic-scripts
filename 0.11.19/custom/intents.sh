#!/bin/bash

function socketReq() {
  /anki/bin/custom/websocat ws://localhost:8888/socket
}

function doModeSelector() {
  echo '{"type":"data","module":"behaviors","data":{"behaviorName":"ModeSelector"}}' | socketReq
}

function successNoise() {
  curl -d "func=PostAudioEvent&args=Play__Robot_Vic_Sfx__Wake_Word_Success" -X POST http://localhost:8889/consolefunccall
}

/anki/bin/custom/ag.sh &

sleep 10

echo '{"type":"data","module":"touch","data":{"filterConfig":"Prod"}}' | socketReq

while true; do
  logcat -t 30 > /tmp/exceptionLog
  if cat /tmp/exceptionLog | grep -i "intent_play_blackjack"; then
    doModeSelector
    successNoise
    echo '{"type":"data","module":"intents","data":{"intentType":"cloud","request":"{\"intent\":\"intent_play_specific_extend\",\"params\": {\"entity_behavior\":\"blackjack\"}}"}}' | socketReq
  elif cat /tmp/exceptionLog | grep -i "NoStackInitialized"; then
    doModeSelector
  elif cat /tmp/exceptionLog | grep -i "intent_imperative_scold"; then
    doModeSelector
    successNoise
    echo '{"type":"data","module":"intents","data":{"intentType":"user","request":"imperative_negative"}}' | socketReq
  elif cat /tmp/exceptionLog | grep -i "intent_imperative_praise"; then
    doModeSelector
    successNoise
    echo '{"type":"data","module":"intents","data":{"intentType":"user","request":"imperative_affirmative"}}' | socketReq
  elif cat /tmp/exceptionLog | grep -i "intent_imperative_apologize"; then
    doModeSelector
    successNoise
    echo '{"type":"data","module":"intents","data":{"intentType":"user","request":"greeting_goodmorning"}}' | socketReq
  elif cat /tmp/exceptionLog | grep -i "intent_play_fistbump"; then
    doModeSelector
    successNoise
    echo '{"type":"data","module":"intents","data":{"intentType":"cloud","request":"{\"intent\":\"intent_play_specific_extend\",\"params\": {\"entity_behavior\":\"fist_bump\"}}"}}' | socketReq
  elif cat /tmp/exceptionLog | grep -i "keep away"; then
    doModeSelector
    successNoise
    echo '{"type":"data","module":"intents","data":{"intentType":"cloud","request":"{\"intent\":\"intent_play_specific_extend\",\"params\": {\"entity_behavior\":\"keep_away\"}}"}}' | socketReq
  elif cat /tmp/exceptionLog | grep -i "intent_play_rollcube"; then
    doModeSelector
    successNoise
    echo '{"type":"data","module":"intents","data":{"intentType":"cloud","request":"{\"intent\":\"intent_play_specific_extend\",\"params\": {\"entity_behavior\":\"roll_cube\"}}"}}' | socketReq
  elif cat /tmp/exceptionLog | grep -i "intent_imperative_findcube"; then
    doModeSelector
    successNoise
    echo '{"type":"data","module":"intents","data":{"intentType":"cloud","request":"{\"intent\":\"intent_play_specific_extend\",\"params\": {\"entity_behavior\":\"roll_cube\"}}"}}' | socketReq
  elif cat /tmp/exceptionLog | grep -i "pull cube"; then
    doModeSelector
    successNoise
    echo '{"type":"data","module":"intents","data":{"intentType":"cloud","request":"{\"intent\":\"intent_play_specific_extend\",\"params\": {\"entity_behavior\":\"roll_cube\"}}"}}' | socketReq
  elif cat /tmp/exceptionLog | grep -i "pull your cube"; then
    doModeSelector
    successNoise
    echo '{"type":"data","module":"intents","data":{"intentType":"cloud","request":"{\"intent\":\"intent_play_specific_extend\",\"params\": {\"entity_behavior\":\"roll_cube\"}}"}}' | socketReq
  elif cat /tmp/exceptionLog | grep -i "intent_seasonal_happynewyear"; then
    successNoise
    echo '{"type":"data","module":"behaviors","data":{"behaviorName":"DevBaseBehavior"}}' | socketReq
    if cat /tmp/ag | grep -i "1"; then
      curl "http://localhost:8889/consolefunccall?func=playanimation&args=anim_holiday_hny_fireworks_01+1"
      sleep 17.4
    else
      curl "http://localhost:8889/consolefunccall?func=playanimation&args=anim_holiday_hyn_confetti_01+1"
      sleep 13.9
    fi
    doModeSelector
  elif cat /tmp/exceptionLog | grep -i "intent_seasonal_happyholidays"; then
    successNoise
    echo '{"type":"data","module":"behaviors","data":{"behaviorName":"DevBaseBehavior"}}' | socketReq
    if cat /data/ag | grep -i "1"; then
      curl "http://localhost:8889/consolefunccall?func=playanimation&args=anim_holiday_hh_lights_01+1"
      sleep 16.4
    else
      curl "http://localhost:8889/consolefunccall?func=playanimation&args=anim_holiday_hh_lights_02+1"
      sleep 18.2
    fi
    doModeSelector
  elif cat /tmp/exceptionLog | grep -i "intent_imperative_love"; then
    successNoise
    echo '{"type":"data","module":"behaviors","data":{"behaviorName":"DevBaseBehavior"}}' | socketReq
    if cat /data/ag | grep -i "1"; then
      curl "http://localhost:8889/consolefunccall?func=playanimation&args=anim_feedback_iloveyou_01+1"
      sleep 3.6
    else
      curl "http://localhost:8889/consolefunccall?func=playanimation&args=anim_feedback_iloveyou_02+1"
      sleep 3.2
    fi
    doModeSelector
  fi
  sleep 0.1
done
