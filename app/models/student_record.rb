class StudentRecord < ApplicationRecord
	validates :lab_id, presence: { message: "Lab Id can't be blank" }, uniqueness: { message: "Lab Id already exists" }
	validates :branch, presence: { message: "Branch can't be blank" }
	validates :branch, inclusion: { in: ["cse", "me", "etc"] }
	validates :year, presence: { message: "Year can't be blank" }, inclusion: { in: [1, 2, 3, 4] }
end
