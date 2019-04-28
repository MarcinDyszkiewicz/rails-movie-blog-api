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

ActiveRecord::Schema.define(version: 2019_04_28_151350) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actors", force: :cascade do |t|
    t.string "slug", null: false
    t.string "full_name", null: false
    t.string "poster"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "actors_movies", id: false, force: :cascade do |t|
    t.bigint "actor_id", null: false
    t.bigint "movie_id", null: false
    t.index ["actor_id", "movie_id"], name: "index_actors_movies_on_actor_id_and_movie_id"
    t.index ["movie_id", "actor_id"], name: "index_actors_movies_on_movie_id_and_actor_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_posts", id: false, force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "post_id", null: false
    t.index ["category_id", "post_id"], name: "index_categories_posts_on_category_id_and_post_id"
    t.index ["post_id", "category_id"], name: "index_categories_posts_on_post_id_and_category_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id"
    t.string "commentable_type"
    t.bigint "commentable_id"
    t.integer "comment_parent_id"
    t.text "body"
    t.boolean "is_spoiler", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "directors", force: :cascade do |t|
    t.string "slug", null: false
    t.string "full_name", null: false
    t.string "poster"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "directors_movies", id: false, force: :cascade do |t|
    t.bigint "director_id", null: false
    t.bigint "movie_id", null: false
    t.index ["director_id", "movie_id"], name: "index_directors_movies_on_director_id_and_movie_id"
    t.index ["movie_id", "director_id"], name: "index_directors_movies_on_movie_id_and_director_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres_movies", id: false, force: :cascade do |t|
    t.bigint "genre_id", null: false
    t.bigint "movie_id", null: false
    t.index ["genre_id", "movie_id"], name: "index_genres_movies_on_genre_id_and_movie_id"
    t.index ["movie_id", "genre_id"], name: "index_genres_movies_on_movie_id_and_genre_id"
  end

  create_table "jwt_blacklists", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_blacklists_on_jti"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "comment_id"
    t.integer "like_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_likes_on_comment_id"
    t.index ["user_id", "comment_id"], name: "index_likes_on_user_id_and_comment_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

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
    t.text "imdb_id"
    t.index ["title", "year"], name: "index_movies_on_title_and_year", unique: true
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "movie_id"
    t.string "slug", null: false
    t.text "title", null: false
    t.text "body", null: false
    t.string "image", null: false
    t.string "meta_title"
    t.text "meta_description"
    t.text "summary"
    t.text "short_description"
    t.text "catchy_title"
    t.boolean "is_published", default: false
    t.date "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_posts_on_movie_id"
    t.index ["title", "is_published"], name: "index_posts_on_title_and_is_published", unique: true
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "posts_tags", id: false, force: :cascade do |t|
    t.bigint "post_id", null: false
    t.bigint "tag_id", null: false
    t.index ["post_id", "tag_id"], name: "index_posts_tags_on_post_id_and_tag_id"
    t.index ["tag_id", "post_id"], name: "index_posts_tags_on_tag_id_and_post_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "rate", limit: 2
    t.string "ratingable_type"
    t.bigint "ratingable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ratingable_type", "ratingable_id"], name: "index_ratings_on_ratingable_type_and_ratingable_id"
    t.index ["user_id", "ratingable_id", "ratingable_type"], name: "index_ratings_on_user_id_and_ratingable_id_and_ratingable_type", unique: true
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "likes", "comments"
  add_foreign_key "likes", "users"
  add_foreign_key "ratings", "users"
end
