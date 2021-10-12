class AddAttributesToFreelancer < ActiveRecord::Migration[6.1]
  def change
    add_column :freelancers, :full_name, :string
    add_column :freelancers, :social_name, :string
    add_column :freelancers, :birth_date, :date
    add_column :freelancers, :degree, :string
    add_column :freelancers, :description, :string
    add_column :freelancers, :experience, :string
  end
end
