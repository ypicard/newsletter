class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.string :email
      t.string :token, null: false
      t.string :status, null: false, default: 'PENDING'
      t.belongs_to :sender, index: true, foreign_key: { to_table: :users }
      t.belongs_to :user, index: true, foreign_key: { to_table: :users }
      t.belongs_to :community, index: true

      t.timestamps
    end
    add_index :invitations, :token, unique: true
  end
end
