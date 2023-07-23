class HappyDiagnosis < ApplicationRecord
  belongs_to :diary

  def calculate_happy_count
    true_question_counts = self.attributes.select { |k, v| v == true }.size
    true_question_counts == 0 ? total_scores = 0 : total_scores = true_question_counts * 10

    self.happy_count = total_scores
  end
end
