class CreateStudentLabIds < ActiveRecord::Migration[6.0]
  def change
    create_table :student_lab_ids do |t|
      t.string :lab_id
      t.string :name
      t.string :branch
      t.boolean :taken, default: false

      t.timestamps
    end
  end
end
