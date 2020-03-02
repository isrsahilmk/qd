class CreateTeacherRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :teacher_records do |t|
      t.string :lab_id
      t.string :name
      t.string :branch

      t.timestamps
    end
  end
end
