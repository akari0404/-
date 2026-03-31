#!/bin/bash
# YouTube Studio ショートカットキー: Ctrl+Alt+Y

URL="https://studio.youtube.com/channel/UCTLPmcqT0CK_LF905kJUzjg?c=UCTLPmcqT0CK_LF905kJUzjg"

if command -v google-chrome &> /dev/null; then
    google-chrome "$URL"
elif command -v google-chrome-stable &> /dev/null; then
    google-chrome-stable "$URL"
elif command -v chromium-browser &> /dev/null; then
    chromium-browser "$URL"
elif command -v chromium &> /dev/null; then
    chromium "$URL"
elif command -v firefox &> /dev/null; then
    firefox "$URL"
elif command -v xdg-open &> /dev/null; then
    xdg-open "$URL"
else
    echo "ブラウザが見つかりません"
    exit 1
fi
