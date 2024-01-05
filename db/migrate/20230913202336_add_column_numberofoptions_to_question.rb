class AddColumnNumberofoptionsToQuestion < ActiveRecord::Migration[7.0]
  def change
    rename_column :questions, :Number_of_options, :number_of_options
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
