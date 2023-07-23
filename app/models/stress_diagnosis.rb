class StressDiagnosis < ApplicationRecord
  belongs_to :diary

  def calculate_stress_count
    true_answer_counts = self.attributes.select { |k, v| v == true }.size
    true_answer_counts == 0 ? total_scores = 0 : total_scores = true_answer_counts * 4

    self.stress_count = total_scores
  end
end
