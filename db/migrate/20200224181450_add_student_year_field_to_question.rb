class AddStudentYearFieldToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :student_year, :integer
  end
end
