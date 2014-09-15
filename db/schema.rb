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

ActiveRecord::Schema.define(version: 20140915113941) do

  create_table "comments", force: true do |t|
    t.text     "body"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.integer  "ticket_id"
    t.datetime "updated_at"
  end

  add_index "comments", ["ticket_id"], name: "index_comments_on_ticket_id"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supports", force: true do |t|
    t.string   "login",      default: ""
    t.string   "password"
    t.string   "first_name", default: ""
    t.string   "last_name",  default: ""
    t.string   "email",      default: ""
    t.integer  "role_id"
    t.integer  "ticket_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "supports", ["role_id"], name: "index_supports_on_role_id"
  add_index "supports", ["ticket_id"], name: "index_supports_on_ticket_id"

  create_table "tabs", force: true do |t|
    t.string   "name",       default: ""
    t.text     "states",     default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_states", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", force: true do |t|
    t.integer  "customer_id"
    t.string   "uuid"
    t.datetime "created_at"
    t.integer  "support_id"
    t.integer  "ticket_state_id"
    t.string   "username",        default: ""
    t.string   "email",           default: ""
    t.string   "subject",         default: ""
    t.text     "problem",         default: ""
    t.datetime "updated_at"
  end

  add_index "tickets", ["support_id"], name: "index_tickets_on_support_id"
  add_index "tickets", ["ticket_state_id"], name: "index_tickets_on_ticket_state_id"

end
