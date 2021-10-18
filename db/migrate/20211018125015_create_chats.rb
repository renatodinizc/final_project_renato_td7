class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.string :commenter
      t.text :message

      t.timestamps
    end
  end
end
