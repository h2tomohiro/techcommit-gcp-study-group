require "google/apis/calendar_v3"
require "googleauth"
require "googleauth/stores/file_token_store"
require "fileutils"

APPLICATION_NAME = 'xxxxxxxxxxxxxxxxxxxx' # ご自身で作成したサービスアカウント名を設定してください
GOOGLE_CALENDAR_ID = 'xxxxxxxxxxxxxxxxxxxx' # ご自身のカレンダーIDを設定してください
CLIENT_SECRET_PATH = 'xxxxxxxxxxxxxxxxxxxx.json' # ご自身で作成したprivate_keyをディレクトリ内に配置し、pathを設定してください
TIME_ZONE = 'Japan'

class GoogleEventCalendar
  def initialize
    # カレンダー操作用のインスタンスを生成
    @client = Google::Apis::CalendarV3::CalendarService.new
    # アプリケーション名（サービスアカウント名）を設定
    @client.client_options.application_name = APPLICATION_NAME
    # 認証
    @client.authorization = authorize
    # 利用するカレンダーのIDを設定
    @google_calendar_id = GOOGLE_CALENDAR_ID
  end

  def authorize
    # 認証用の情報を格納
    auth = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open(CLIENT_SECRET_PATH), # 認証用のキー
      scope:       Google::Apis::CalendarV3::AUTH_CALENDAR
    )
    # アクセストークンを取得
    auth.fetch_access_token!
    auth
  end

  # カレンダー登録に必要な情報のインスタンスをbuild
  def build_google_calender_event(summary, description, location, start_time, end_time)
    Google::Apis::CalendarV3::Event.new({
        summary: summary,
        description: description,
        location: location,
        start: Google::Apis::CalendarV3::EventDateTime.new(
          date_time: start_time
        ),
        end: Google::Apis::CalendarV3::EventDateTime.new(
          date_time: end_time
        )
      }
    )
  end

  #レスポンスとして受け取るEventをコンソールに表示
  def puts_event(event)
    puts "Summary:     #{event.summary}"
    puts "Location:    #{event.location}"
    puts "Description: #{event.description}"
    puts "EventID:     #{event.id}"
    puts "Start:       #{event.start.date_time}"
    puts "End:         #{event.end.date_time}"
  end

  def create
    # 登録したいイベントをbuild
    event = build_google_calender_event(
      'TechCommit勉強会', # summary(タイトル)
      'GCPについてのハンズオン', # description(説明文),
      '渋谷', # location(開催場所)
      DateTime.new(2022, 2, 13, 16), # start_time（開始時間）
      DateTime.new(2022, 2, 13, 18) # end_time（終了時間）
    )
    # Googleカレンダーに、イベント作成のリクエスト
    response =  @client.insert_event(
      @google_calendar_id,  # calendarID
      event # 挿入したいイベント(Google::Apis::CalendarV3::Event)
    )
  end

  def read
    # 2022年の2月1日から3月31日までの予定を取得
    events = @client.list_events(@google_calendar_id,
                                  time_min: (Time.new(2022, 2, 1)).iso8601,
                                  time_max: (Time.new(2022, 3, 31)).iso8601,
                                  )
    events.items.each do |event|
      puts '-------------------------------'
      puts_event(event)
    end
  end

  # 指定したイベントを更新
  def update(event_id)
    event = build_google_calender_event(
      'GoogleCloudAPI入門勉強会', # summary(タイトル)
      'WebAPIでGoogleカレンダーを操作してみよう！', # description(説明文),
      'オンライン', # location(開催場所)
      DateTime.new(2022, 2, 24, 12),
      DateTime.new(2022, 2, 24, 15)
    )
    # Googleカレンダーに、イベント更新のリクエスト
    response =  @client.update_event(
      @google_calendar_id,  # calendarID
      event_id, # 編集したいeventのID
      event # 挿入したいイベント(Google::Apis::CalendarV3::Event)
    )
  end

  # 指定したイベントを削除
  def delete(event_id)
    @client.delete_event(
      @google_calendar_id,
      event_id
    )
  end
end

# 更新したいEventIDを設定してください。EventIDはreadメソッドを呼ぶと確認できます。
event_id = 'xxxxxxxxxxxxxxxxxxxx'

GoogleEventCalendar.new.create
# GoogleEventCalendar.new.update(event_id)
# GoogleEventCalendar.new.delete(event_id)
# GoogleEventCalendar.new.read
