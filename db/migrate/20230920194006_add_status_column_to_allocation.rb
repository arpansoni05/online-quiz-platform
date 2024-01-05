class AddStatusColumnToAllocation < ActiveRecord::Migration[7.0]
  def change
    # remove_column :allocations, :status
    add_column :allocations, :status, :string, null: true
    add_column :allocations, :score, :string, null: true
  end
end
