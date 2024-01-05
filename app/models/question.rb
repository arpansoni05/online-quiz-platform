class Question < ApplicationRecord
  belongs_to :assessment
  has_many :answers, dependent: :destroy
  validates :content, presence: true
  validates :number_of_options, presence: true, numericality: { only_integer: true }
  validate :validate_max_questions_per_assessment

  private

  def validate_max_questions_per_assessment
    # byebug
    if assessment && assessment.total_mcqs_questions.present?
      max_mcqs_question = assessment.total_mcqs_questions
      if assessment.questions.count >= max_mcqs_question
        errors.add(:base, "An assessment can have a maximum of #{max_mcqs_question} questions.")
      end
    end
  end
end
