class CreateNewsletters < ActiveRecord::Migration[5.2]
  def change
    create_table :newsletters do |t|
      t.string :period, null: false
      t.boolean :delivered, null: false, default: false
      t.integer :week
      t.integer :month
      t.integer :year

      t.belongs_to :community, index: true

      t.timestamps
    end

    create_table :newsletter_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :newsletter, index: true
    end

    create_table :newsletter_links, id: false do |t|
      t.belongs_to :link, index: true
      t.belongs_to :newsletter, index: true
    end

  end
end
