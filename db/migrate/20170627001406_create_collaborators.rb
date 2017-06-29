class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.integer :user_id, index: true, foreign_key: true
      t.integer :wiki_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
