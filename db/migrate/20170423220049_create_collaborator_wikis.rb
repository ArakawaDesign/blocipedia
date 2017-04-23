class CreateCollaboratorWikis < ActiveRecord::Migration
  def change
    create_table :collaborator_wikis do |t|
      t.integer :user_id
      t.integer :wiki_id

      t.timestamps null: false
    end
    add_index :collaborator_wikis, :user_id
    add_index :collaborator_wikis, :wiki_id
  end
end
