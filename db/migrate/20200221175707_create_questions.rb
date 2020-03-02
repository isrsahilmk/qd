class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.text :title
      t.text :body
      t.string :lab_id
      t.string :name
      t.string :branch

      t.timestamps
    end
  end
end
