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

ActiveRecord::Schema.define(version: 20171010054058) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "costs", force: :cascade do |t|
    t.integer "left_id"
    t.integer "right_id"
    t.decimal "distance"
    t.decimal "haversine"
    t.decimal "time"
    t.text "polyline"
    t.integer "mode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scores", force: :cascade do |t|
    t.integer "station_id"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at", "score"], name: "index_scores_on_created_at_and_score"
    t.index ["created_at"], name: "index_scores_on_created_at"
  end

  create_table "stations", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.decimal "lat"
    t.decimal "lon"
    t.integer "region_id"
    t.integer "capacity"
    t.text "rental_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.geography "geog", limit: {:srid=>0, :type=>"geometry"}
    t.index ["geog"], name: "index_stations_on_geog", using: :gist
    t.index ["name"], name: "index_stations_on_name"
    t.index ["region_id"], name: "index_stations_on_region_id"
  end

end
