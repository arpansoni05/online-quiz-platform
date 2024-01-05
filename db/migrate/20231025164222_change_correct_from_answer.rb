class ChangeCorrectFromAnswer < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        change_column :answers, :correct, :boolean, default: false
      end
      dir.down do
        change_column :answers, :correct, :boolean, default: nil
      end
    end
  end
end
