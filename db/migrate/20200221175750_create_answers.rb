class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.text :short_answer
      t.text :descriptive_answer
      t.string :lab_id
      t.string :name
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
