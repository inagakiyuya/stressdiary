require_relative '../controllers/line_bot_controller.rb'
require 'date'

class Reminder < ApplicationRecord
  validates :remind_time, presence: true

  validate :validate_remind_time_format
  validate :validate_remind_time_in_future

  def validate_remind_time_format
    unless remind_time.is_a?(DateTime) || remind_time.is_a?(Time)
      errors.add(:remind_time, "is not in a valid format")
    end
  end

  def validate_remind_time_in_future
    if remind_time && remind_time <= DateTime.now
      errors.add(:remind_time, "must be in the future")
    end
  end

  def self.save_reminder(remind_time_str)
    remind_time = DateTime.parse(remind_time_str)
    reminder = self.new(remind_time: remind_time)
    reminder.save
  end

  def self.delete_reminder(delete_time_str)
    remind_time = DateTime.parse(delete_time_str)
    reminder = Reminder.find_by(remind_time: remind_time)
    reminder.destroy
  end

  def self.delete_reminder_all
    remind_time_all = Reminder.all
    remind_time_all.each(&:destroy)
  end

  def self.extract_remind_time
    current_time = Time.now + 9.hours
    reminder = self.where('remind_time  >= ?', current_time).order(remind_time: :asc).first
    reminder&.remind_time
  end

  def self.tell_recent_reminders(limit)
    recent_reminders = self.order(created_at: :desc).limit(limit).pluck(:remind_time)
    remind_times = []
    recent_reminders.reverse_each do |remind_time|
      remind_times << remind_time.strftime('%Y-%m-%d %H:%M')
    end
    remind_times
  end
end
