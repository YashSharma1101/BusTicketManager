# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_02_21_054916) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "email_notifications", force: :cascade do |t|
    t.date "date"
    t.time "time"
    t.string "from_city"
    t.string "to_city"
    t.string "seat_number"
    t.string "email"
    t.string "subject"
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "bus_no"
    t.string "boarding_location"
    t.string "drop_location"
    t.string "operator"
    t.string "operator_contact"
  end

  create_table "make_my_trip_bookings", force: :cascade do |t|
    t.string "boarding_location"
    t.string "drop_location"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "paid_by_id", null: false
    t.bigint "paid_to_id", null: false
    t.decimal "amount"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["paid_by_id"], name: "index_payments_on_paid_by_id"
    t.index ["paid_to_id"], name: "index_payments_on_paid_to_id"
  end

  create_table "ticket_bookings", force: :cascade do |t|
    t.bigint "ticket_id", null: false
    t.string "day"
    t.time "time"
    t.text "journey_location"
    t.string "journey_date"
    t.string "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "seat_number"
    t.index ["ticket_id"], name: "index_ticket_bookings_on_ticket_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "booked_by"
    t.integer "booked_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "amount_paid"
    t.decimal "extra_charges"
    t.date "week_date"
    t.bigint "booked_by_id", null: false
    t.bigint "booked_for_id", null: false
    t.string "week_number"
    t.string "year"
    t.decimal "price_per_ticket", default: "85.0"
    t.index ["booked_by_id"], name: "index_tickets_on_booked_by_id"
    t.index ["booked_for_id"], name: "index_tickets_on_booked_for_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "relationship"
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "payments", "users", column: "paid_by_id"
  add_foreign_key "payments", "users", column: "paid_to_id"
  add_foreign_key "ticket_bookings", "tickets"
  add_foreign_key "tickets", "users"
  add_foreign_key "tickets", "users", column: "booked_by_id"
  add_foreign_key "tickets", "users", column: "booked_for_id"
end
