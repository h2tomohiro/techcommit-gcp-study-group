# Google Calendar APIでイベントの操作を行うサンプルコード
## 1. 上記コードはRubyで書かれているため、Rubyの開発環境が必要
- 他の言語で実行したい方は、下記公式APIのQuickstartで言語を選択し、サンプルコードをお使いください。
  - https://developers.google.com/calendar/api/quickstart/js

## 2. GoogleAPIを使うためににAPIクライアントをインストール
- Rubyをお使いいただく方は、以下のコマンドをコンソール上で実行してライブラリをインストールしてください。
  - `gem install google-api-client`
- 他言語をお使いの方は、下記から `google-api-client` で検索して該当の言語のライブラリをお探しください。
  - https://github.com/googleapis?q=&type=all&language=&sort=
  
## 3. private_keyが記載されているJSONファイルを配置
- サービスアカウント作成時にダウンロードしたprivate_keyなどが記載されたJSONファイルを同じディレクトリ内に配置してくだい。

## 4. google_event_calendar.rbファイル内の6〜8行目の定数をご自身のものに設定

## 5. Rubyファイルの実行
- ファイルを配置しているディレクトリで`ruby google_event_calendar.rb `を実行すると、カレンダーにイベントが登録されます。
- 更新したい場合は、115行目にevent_idを設定し、updateやdeleteなどの、実行したいアクションを実行ください。
