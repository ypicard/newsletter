class CreateLinksDigests < ActiveRecord::Migration[5.2]
  def change
    create_table :links_digests do |t|
      #TODO:should i put week month year here ? --> Yes !
      t.string :period, null: false
      t.boolean :delivered, null: false, default: false

      t.belongs_to :community, index: true

      t.timestamps
    end

    create_table :links_digests_users, id: false do |t|
      t.belongs_to :users, index: true
      t.belongs_to :links_digest, index: true
    end
  end
end
