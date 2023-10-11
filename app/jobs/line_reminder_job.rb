require 'line_notify'

class LineReminderJob < ApplicationJob
  queue_as :default

  def perform
    line_notify = LineNotify.new(ENV['LINE_NOTIFY_TOKEN'])
    options = { message: "指定した時間です！今日あった出来事などを日記に書きましょう！", stickerPackageId: 1, stickerId: 113 }
    line_notify.ping(options)
    puts "LINE botの動作が正常に終了しました。"
  end
end
