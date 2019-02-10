class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.string :url, null: false
      # Link preview fields (https://www.linkpreview.net/docs)
      t.string :lp_title
      t.string :lp_description
      t.string :lp_image
      t.string :lp_url

      t.belongs_to :user, index: true
      t.belongs_to :community, index: true

      t.timestamps
    end
    add_index :links, [:url, :user_id, :community_id], unique: true

  end
end
