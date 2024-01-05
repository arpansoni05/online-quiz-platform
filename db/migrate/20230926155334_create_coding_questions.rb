class CreateCodingQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :coding_questions do |t|
      t.references :assessment, null: false, foreign_key: true
      t.string :content
      t.string :answer
      t.string :test1
      t.string :test2
      t.string :test3

      t.timestamps
    end
  end
end
