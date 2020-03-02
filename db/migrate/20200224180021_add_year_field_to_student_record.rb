class AddYearFieldToStudentRecord < ActiveRecord::Migration[6.0]
  def change
    add_column :student_records, :year, :integer
  end
end
