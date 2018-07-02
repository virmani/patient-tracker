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

ActiveRecord::Schema.define(version: 20180702104928) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "doctors", force: :cascade do |t|
    t.text "name"
  end

  create_table "emails", force: :cascade do |t|
    t.string "email_address"
    t.integer "email_owner"
    t.bigint "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_emails_on_patient_id"
  end

  create_table "google_drive_folders", force: :cascade do |t|
    t.string "google_id"
    t.bigint "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_google_drive_folders_on_patient_id"
  end

  create_table "notes", force: :cascade do |t|
    t.text "note"
    t.bigint "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "visit_date"
    t.string "diagnosis"
    t.string "surgery"
    t.index ["patient_id"], name: "index_notes_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "last_name", null: false
    t.string "given_name", null: false
    t.date "date_of_birth", null: false
    t.string "fathers_name"
    t.string "fathers_occupation"
    t.string "mothers_name"
    t.string "mothers_occupation"
    t.text "permanent_address", null: false
    t.string "permanent_district", null: false
    t.boolean "present_permanent_same"
    t.text "present_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "doctors_id"
    t.index ["doctors_id"], name: "index_patients_on_doctors_id"
  end

  create_table "phones", force: :cascade do |t|
    t.string "number"
    t.integer "phone_type"
    t.integer "phone_owner"
    t.bigint "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_phones_on_patient_id"
  end

  add_foreign_key "emails", "patients"
  add_foreign_key "google_drive_folders", "patients"
  add_foreign_key "notes", "patients"
  add_foreign_key "phones", "patients"
end
