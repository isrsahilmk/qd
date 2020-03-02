class CreateTeacherNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :teacher_notifications do |t|
      t.text :body
      t.boolean :read, default: false
      t.references :teacher_record, null: false, foreign_key: true

      t.timestamps
    end
  end
end
