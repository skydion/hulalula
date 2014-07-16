# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140714131904) do

  create_table "comments", force: true do |t|
    t.text     "body"
    t.datetime "created_at"
    t.integer  "ticket_id"
    t.integer  "owner_id"
    t.datetime "updated_at"
  end

  add_index "comments", ["ticket_id"], name: "index_comments_on_ticket_id"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "support_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["support_id"], name: "index_roles_on_support_id"

  create_table "supports", force: true do |t|
    t.string   "login"
    t.string   "password"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "role_id"
    t.integer  "ticket_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "supports", ["ticket_id"], name: "index_supports_on_ticket_id"

  create_table "tickets", force: true do |t|
    t.integer  "customer_id"
    t.string   "uuid"
    t.datetime "created_at"
    t.integer  "owner_id"
    t.integer  "status_id"
    t.string   "username"
    t.string   "email"
    t.string   "subject"
    t.text     "problem"
    t.datetime "updated_at"
  end

end
