class Answer < ApplicationRecord
  belongs_to :question

  validates :short_answer, presence: { message: "Short answer can't be blank" }
  validates :descriptive_answer, presence: { message: "Descriptive answer can't be blank" }
end
