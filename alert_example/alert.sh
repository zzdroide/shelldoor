#!/bin/sh

# Inspired by https://www.redpill-linpro.com/techblog/2017/12/11/break-the-glass.html

# Alert by Telegram
tg_alert() {
  readonly token="changeme"
  readonly chat_id="changeme"

  readonly url="https://api.telegram.org/bot$token/sendMessage"
  curl --fail-with-body --no-progress-meter \
    -X POST -d chat_id=$chat_id -d text="⚠️ shelldoor used" $url
}

# Log to another server
tx_log() {
  readonly basic_auth="changeme"  # echo "$(head -c8 /dev/urandom | base64):$(head -c8 /dev/urandom | base64)"
  readonly url="https://changeme/shelldoor_used"

  curl --silent --user "$basic_auth" \
    -H "X-Date: $(date)" `# To record date in log` \
    $url
}

tg_alert &
tx_log &
