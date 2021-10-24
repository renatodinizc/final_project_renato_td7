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

ActiveRecord::Schema.define(version: 2021_10_24_122805) do

  create_table "chats", force: :cascade do |t|
    t.string "commenter"
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "proposal_id", null: false
    t.index ["proposal_id"], name: "index_chats_on_proposal_id"
  end

  create_table "contractors", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_contractors_on_email", unique: true
    t.index ["reset_password_token"], name: "index_contractors_on_reset_password_token", unique: true
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "proposal_id", null: false
    t.index ["proposal_id"], name: "index_feedbacks_on_proposal_id"
  end

  create_table "freelancer_expertises", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "freelancers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "full_name"
    t.string "social_name"
    t.date "birth_date"
    t.string "degree"
    t.string "description"
    t.string "experience"
    t.integer "freelancer_expertise_id"
    t.index ["email"], name: "index_freelancers_on_email", unique: true
    t.index ["freelancer_expertise_id"], name: "index_freelancers_on_freelancer_expertise_id"
    t.index ["reset_password_token"], name: "index_freelancers_on_reset_password_token", unique: true
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "desired_skills"
    t.decimal "top_hourly_wage"
    t.date "proposal_deadline"
    t.boolean "remote"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "contractor_id", null: false
    t.integer "freelancer_expertise_id", null: false
    t.index ["contractor_id"], name: "index_projects_on_contractor_id"
    t.index ["freelancer_expertise_id"], name: "index_projects_on_freelancer_expertise_id"
  end

  create_table "proposals", force: :cascade do |t|
    t.string "proposal_description"
    t.decimal "hourly_wage"
    t.integer "weekly_hours"
    t.date "expected_conclusion"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "project_id", null: false
    t.integer "freelancer_id", null: false
    t.integer "status", default: 0
    t.integer "contractor_id", null: false
    t.boolean "archived", default: false, null: false
    t.index ["contractor_id"], name: "index_proposals_on_contractor_id"
    t.index ["freelancer_id"], name: "index_proposals_on_freelancer_id"
    t.index ["project_id"], name: "index_proposals_on_project_id"
  end

  add_foreign_key "chats", "proposals"
  add_foreign_key "feedbacks", "proposals"
  add_foreign_key "freelancers", "freelancer_expertises"
  add_foreign_key "projects", "contractors"
  add_foreign_key "projects", "freelancer_expertises"
  add_foreign_key "proposals", "contractors"
  add_foreign_key "proposals", "freelancers"
  add_foreign_key "proposals", "projects"
end
