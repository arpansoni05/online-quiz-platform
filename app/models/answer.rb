class Answer < ApplicationRecord
  belongs_to :question
  validates :content, presence: true
  # validates :correct, inclusion: { in: [true, false], message: "must be true or false" }
  validate :validate_max_answers_per_question
  validate :validate_option_combination

  private

  def validate_max_answers_per_question
    if question && question.number_of_options.present?
      # byebug
      max_no_of_answers = question.number_of_options
      if question.answers.count >= max_no_of_answers
        errors.add(:base, "An question can have a maximum of #{max_no_of_answers} answers.")
      end
    end
  end

  def validate_option_combination
      count_true = question.answers.where(correct: true).count
      count_false = question.answers.where(correct: false).count
    if correct && count_true > 0
      errors.add(:correct, 'There can be only one correct answer per question')
    elsif !correct && count_true == 0 && count_false > 2
      errors.add(:correct, 'There must be at least one correct answer per question')
    end
  end
end
