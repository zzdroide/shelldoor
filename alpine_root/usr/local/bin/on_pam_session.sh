#!/bin/sh
if [ "$PAM_TYPE" = "open_session" ] && [ -x /alert/alert.sh ]; then
  /alert/alert.sh
fi
