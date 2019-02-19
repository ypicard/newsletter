# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_02_10_164831) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "communities", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.bigint "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_communities_on_creator_id"
    t.index ["name"], name: "index_communities_on_name", unique: true
  end

  create_table "invitations", force: :cascade do |t|
    t.string "email"
    t.string "token", null: false
    t.string "status", default: "PENDING", null: false
    t.bigint "sender_id"
    t.bigint "user_id"
    t.bigint "community_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_invitations_on_community_id"
    t.index ["sender_id"], name: "index_invitations_on_sender_id"
    t.index ["token"], name: "index_invitations_on_token", unique: true
    t.index ["user_id"], name: "index_invitations_on_user_id"
  end

  create_table "links", force: :cascade do |t|
    t.string "url", null: false
    t.string "title"
    t.string "description"
    t.string "image"
    t.bigint "user_id"
    t.bigint "community_id"
    t.bigint "newsletter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_links_on_community_id"
    t.index ["newsletter_id"], name: "index_links_on_newsletter_id"
    t.index ["url", "user_id", "community_id"], name: "index_links_on_url_and_user_id_and_community_id", unique: true
    t.index ["user_id"], name: "index_links_on_user_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "community_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_memberships_on_community_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "newsletter_links", id: false, force: :cascade do |t|
    t.bigint "link_id"
    t.bigint "newsletter_id"
    t.index ["link_id"], name: "index_newsletter_links_on_link_id"
    t.index ["newsletter_id"], name: "index_newsletter_links_on_newsletter_id"
  end

  create_table "newsletter_users", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "newsletter_id"
    t.index ["newsletter_id"], name: "index_newsletter_users_on_newsletter_id"
    t.index ["user_id"], name: "index_newsletter_users_on_user_id"
  end

  create_table "newsletters", force: :cascade do |t|
    t.string "period", null: false
    t.boolean "delivered", default: false, null: false
    t.integer "week"
    t.integer "month"
    t.integer "year"
    t.bigint "community_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_newsletters_on_community_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "communities", "users", column: "creator_id"
  add_foreign_key "invitations", "users", column: "sender_id"
end
