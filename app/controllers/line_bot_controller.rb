require 'line/bot'
require 'line_notify'
require 'dotenv/load'

class LineBotController < ApplicationController
  protect_from_forgery :except => [:callback, :reminder_notify]
  skip_before_action :require_login, only: [:callback, :reminder_notify]

  def callback
    body = request.body.read
    events = client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          case event.message['text']

          when "リマインド" 
            reply_text(event, "リマインドする時間を次の形で入力してください。(例)1996-05-25 12:00")
          when /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}$/
            remind_time_str = event.message['text']
            Reminder.save_reminder(remind_time_str)
            reply_text(event, "リマインダーを保存しました。")
          when "リマインドを起動"
            remind_time = Reminder.extract_remind_time
            LineReminderJob.set(wait_until: remind_time).perform_later
            reply_text(event, "リマインダーを起動しました。時間になったら、メッセージを送信します。")
          when "時間を教えて"
            reminders = Reminder.tell_recent_reminders(10)
            reminder_list = reminders.map { |reminder| "・#{reminder}" }.join("\n")
            message = "過去に設定したリマインダーの時間は以下の通りです。\n#{reminder_list}"
            reply_text(event, message)
          when "リマインド削除"
            reply_text(event, "削除したい、リマインダーの時間を次の形で教えてください。(例)1996-05-25 12:00削除")
          when /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}削除$/
            delete_message = event.message['text']
            delete_time_str = delete_message.match(/^\d{4}-\d{2}-\d{2} \d{2}:\d{2}/)[0]
            Reminder.delete_reminder(delete_time_str)
            reply_text(event, "リマインドを削除しました。")
          when "時間を全部消去"
            Reminder.delete_reminder_all
            reply_text(event, "過去に設定したリマインドを全て削除しました。")
          else
            reply_text(event, "正しい形式で時間を入力してください。また、時間を設定するには、「リマインド」と入力してください。")
          end     
        end
      end
    end
    head :ok
  end

  private

  def reply_text(event, text)
    message = {
      type: 'text',
      text: text
    }
  
    client.reply_message(event['replyToken'], message)
  end
end
