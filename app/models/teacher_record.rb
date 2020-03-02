class TeacherRecord < ApplicationRecord
	validates :lab_id, presence: { message: "Lab Id cant be blank" }, uniqueness: { message: "Lab Id already exists" }
	validates :branch, presence: { message: "Branch cant be blank" }
	validates :branch, inclusion: { in: ["cse", "me", "etc"] }

	has_many :teacher_notifications
end
