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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121211154305) do

  create_table "client_salons", :force => true do |t|
    t.integer  "client_id"
    t.integer  "salon_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "client_services", :force => true do |t|
    t.integer  "duration"
    t.integer  "client_id"
    t.integer  "service_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "client_id"
    t.integer  "professional_id"
    t.string   "status",          :default => "Agendado"
    t.datetime "start_at"
    t.integer  "duration"
    t.boolean  "changeable"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.datetime "end_at"
    t.integer  "service_id"
    t.integer  "salon_id"
    t.string   "created_by"
    t.boolean  "reschedule",      :default => false
  end

  create_table "favorites", :force => true do |t|
    t.integer  "salon_id"
    t.integer  "client_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "payments", :force => true do |t|
    t.string   "description"
    t.string   "status"
    t.date     "due_date"
    t.date     "payment_date"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "subscription_id"
    t.float    "price"
    t.string   "payment_mode"
    t.string   "payment_type"
    t.string   "moip_code"
    t.boolean  "locked",          :default => false
  end

  create_table "phones", :force => true do |t|
    t.string   "type"
    t.string   "number"
    t.integer  "salon_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "main"
  end

  create_table "professional_services", :force => true do |t|
    t.integer  "service_id"
    t.integer  "professional_id"
    t.integer  "duration"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "salons", :force => true do |t|
    t.string   "name"
    t.string   "username"
    t.string   "landphone"
    t.string   "celphone"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "complement"
    t.string   "email"
    t.string   "logo"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "neighborhood"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "number"
    t.integer  "professional_id"
  end

  create_table "services", :force => true do |t|
    t.string   "name"
    t.integer  "duration"
    t.float    "price"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "salon_id"
  end

  create_table "settings", :force => true do |t|
    t.boolean  "work_on_sundays"
    t.boolean  "work_on_saturdays"
    t.datetime "opening_time"
    t.datetime "closing_time"
    t.boolean  "searchable"
    t.boolean  "client_can_schedule"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "subscriptions", :force => true do |t|
    t.string   "description"
    t.decimal  "price"
    t.boolean  "status",       :default => true
    t.date     "initial_date"
    t.date     "end_date"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "salon_id"
    t.integer  "trial_period"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "encrypted_password",     :default => "",       :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "address"
    t.string   "complement"
    t.string   "region"
    t.string   "state"
    t.string   "landphone"
    t.string   "celphone"
    t.string   "type",                   :default => "Client", :null => false
    t.integer  "salon_id"
    t.string   "role"
    t.string   "zipcode"
    t.string   "house_number"
    t.string   "city"
    t.integer  "created_by"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "working_times", :force => true do |t|
    t.integer  "day"
    t.datetime "from"
    t.datetime "to"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "professional_id"
  end

end
