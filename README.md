# YouTube Studio ショートカットキー

YouTube Studio を素早く開くためのショートカットキー設定です。

## セットアップ方法

### 1. スクリプトの準備

```bash
# スクリプトをホームディレクトリにコピー
cp open-youtube-studio.sh ~/open-youtube-studio.sh

# 実行権限を付与
chmod +x ~/open-youtube-studio.sh
```

### 2. ショートカットキーの設定

#### GNOME (Ubuntu / Fedora)

1. **設定** → **キーボード** → **キーボードショートカット** を開く
2. **カスタムショートカット** の `+` ボタンをクリック
3. 以下を入力：
   - **名前**: `YouTube Studio`
   - **コマンド**: `/bin/bash /home/あなたのユーザー名/open-youtube-studio.sh`
   - **ショートカット**: 好みのキー（例: `Ctrl+Alt+Y`）を押す
4. **追加** をクリック

#### KDE Plasma

1. **システム設定** → **ショートカット** → **カスタムショートカット** を開く
2. **編集** → **新規** → **グローバルショートカット** → **コマンド/URL**
3. **トリガー** タブでショートカットキーを設定
4. **アクション** タブでコマンドを設定：
   ```
   /bin/bash /home/あなたのユーザー名/open-youtube-studio.sh
   ```

#### xfce

1. **アプリケーション** → **設定** → **キーボード** → **アプリケーションショートカット**
2. **追加** をクリック
3. コマンド: `/bin/bash /home/あなたのユーザー名/open-youtube-studio.sh`
4. ショートカットキーを押して設定

### 3. デスクトップエントリの設定（オプション）

```bash
# desktop ファイルを編集（パスを修正）
sed -i "s|/path/to/open-youtube-studio.sh|$HOME/open-youtube-studio.sh|" youtube-studio.desktop

# アプリケーション一覧に追加
cp youtube-studio.desktop ~/.local/share/applications/

# データベースを更新
update-desktop-database ~/.local/share/applications/
```

## 推奨ショートカットキー

| ショートカット | 説明 |
|---|---|
| `Ctrl+Alt+Y` | YouTube Studio を開く |
| `Super+Y` | YouTube Studio を開く（Superキー = Windowsキー） |
| `Ctrl+Alt+S` | YouTube Studio を開く |

## 動作確認

```bash
# スクリプトを直接実行してテスト
~/open-youtube-studio.sh
```

ブラウザが起動し、YouTube Studio が開けば成功です。
