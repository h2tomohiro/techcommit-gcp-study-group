# GoogleカレンダーAPIのサンプルコード(cloneしてお使いください。）
## 上記コードはRubyで書かれているため、Rubyの開発環境が必要です。
- 他の言語で実行したい方は、下記公式APIのQuickstartで言語を選択し、サンプルコードをお使いください。

## GoogleAPIを使うためににAPIクライアントをインストールしましょう。
- Rubyをお使いいただく方は、以下のコマンドをコンソール上で実行してください。
  - gem install google-api-client
- 他言語をお使いの方は、下記から `google-api-client` で検索してお探しください。
  - https://github.com/googleapis?q=&type=all&language=&sort=
  
## private_keyがJSONファイルを配置してください
- サービスアカウント作成時にダウンロードしたprivate_keyなどが記載されたJSONファイルを同じディレクトリ内に配置してくだい。

## ファイル内の6〜8行目の定数をご自身のものに設定してください
- APPLICATION_NAME
- GOOGLE_CALENDAR_ID
- CLIENT_SECRET_PATH

## Rubyファイルの実行
- ファイルを配置しているディレクトリで`ruby google_event_calendar.rb `を実行すると、カレンダーにイベントが登録されます。
- 更新したい場合は、115行目にevent_idを設定し、updateやdeleteなどの、実行したいアクションを実行ください。
