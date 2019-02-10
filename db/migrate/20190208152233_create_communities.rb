# frozen_string_literal: true

class CreateCommunities < ActiveRecord::Migration[5.2]
  def change
    create_table :communities do |t|
      t.string :name, null: false
      t.belongs_to :creator, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end
    add_index :communities, :name, unique: true
  end
end
