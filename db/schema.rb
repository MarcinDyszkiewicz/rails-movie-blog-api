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

ActiveRecord::Schema.define(version: 2019_02_08_175908) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movies", force: :cascade do |t|
    t.string "slug", null: false
    t.string "title", null: false
    t.integer "year"
    t.date "released"
    t.integer "runtime"
    t.text "plot"
    t.text "review"
    t.string "poster"
    t.string "rotten_tomatoes_rating"
    t.string "metacritic_rating"
    t.string "imdb_raiting"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title", "year"], name: "index_movies_on_title_and_year", unique: true
  end

end
