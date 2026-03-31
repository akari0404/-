#!/bin/bash
# YouTube Studio ショートカットキー 自動セットアップスクリプト
# 使い方: bash install-shortcut.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="$HOME/open-youtube-studio.sh"
SHORTCUT_KEY="<Primary><Alt>y"
SHORTCUT_NAME="YouTube Studio"
SHORTCUT_CMD="/bin/bash $TARGET"

echo "=== YouTube Studio ショートカットキー セットアップ ==="
echo ""

# 1. スクリプトをホームディレクトリにコピー
echo "[1/3] スクリプトを $TARGET にコピー中..."
cp "$SCRIPT_DIR/open-youtube-studio.sh" "$TARGET"
chmod +x "$TARGET"
echo "      完了"

# 2. デスクトップ環境を検出してショートカットを設定
echo "[2/3] デスクトップ環境を検出中..."

if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]] || [[ "$XDG_CURRENT_DESKTOP" == *"Unity"* ]]; then
    echo "      GNOME を検出しました"

    # 既存のカスタムショートカット一覧を取得
    EXISTING=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings 2>/dev/null || echo "@as []")

    # 新しいショートカットのパス
    NEW_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/youtube-studio/"

    # パスを追加（重複チェック）
    if echo "$EXISTING" | grep -q "youtube-studio"; then
        echo "      既存の設定を上書きします"
    else
        if [[ "$EXISTING" == "@as []" ]] || [[ "$EXISTING" == "[]" ]]; then
            gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['$NEW_PATH']"
        else
            UPDATED=$(echo "$EXISTING" | sed "s|]|, '$NEW_PATH']|")
            gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$UPDATED"
        fi
    fi

    # ショートカットの設定
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/youtube-studio/ name "$SHORTCUT_NAME"
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/youtube-studio/ command "$SHORTCUT_CMD"
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/youtube-studio/ binding "$SHORTCUT_KEY"

    echo "      GNOME ショートカット設定完了: Ctrl+Alt+Y"

elif [[ "$XDG_CURRENT_DESKTOP" == *"KDE"* ]]; then
    echo "      KDE を検出しました"
    mkdir -p ~/.config
    cat >> ~/.config/kglobalshortcutsrc << KDEEOF

[youtube-studio.desktop]
_launch=Ctrl+Alt+Y,none,YouTube Studio
KDEEOF
    # デスクトップファイルも作成
    mkdir -p ~/.local/share/applications
    cat > ~/.local/share/applications/youtube-studio.desktop << DESKTOPEOF
[Desktop Entry]
Version=1.0
Type=Application
Name=YouTube Studio
Exec=$SHORTCUT_CMD
Terminal=false
DESKTOPEOF
    echo "      KDE ショートカット設定完了: Ctrl+Alt+Y"

elif [[ "$XDG_CURRENT_DESKTOP" == *"XFCE"* ]]; then
    echo "      XFCE を検出しました"
    # xfconf を使って設定
    if command -v xfconf-query &> /dev/null; then
        xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Primary><Alt>y" -n -t string -s "$SHORTCUT_CMD"
        echo "      XFCE ショートカット設定完了: Ctrl+Alt+Y"
    else
        echo "      xfconf-query が見つかりません。手動で設定してください。"
    fi

else
    echo "      デスクトップ環境: ${XDG_CURRENT_DESKTOP:-不明}"
    echo "      手動でショートカットを設定してください:"
    echo "      コマンド: $SHORTCUT_CMD"
    echo "      キー: Ctrl+Alt+Y"
fi

# 3. 動作テスト
echo ""
echo "[3/3] セットアップ完了!"
echo ""
echo "========================================"
echo "  ショートカットキー: Ctrl + Alt + Y"
echo "  開くURL: https://studio.youtube.com/channel/UCTLPmcqT0CK_LF905kJUzjg"
echo "========================================"
echo ""
echo "テスト実行: bash $TARGET"
