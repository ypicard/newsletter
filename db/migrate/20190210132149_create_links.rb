class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.string :url, null: false
      # Link preview fields (https://www.linkpreview.net/docs)
      t.string :title
      t.string :description
      t.string :image

      t.belongs_to :user, index: true
      t.belongs_to :community, index: true
      # t.belongs_to :newsletter, index: true

      t.timestamps
    end
    add_index :links, [:url, :user_id, :community_id], unique: true

  end
end
