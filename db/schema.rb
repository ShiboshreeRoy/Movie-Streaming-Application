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

ActiveRecord::Schema[8.1].define(version: 2026_02_12_002539) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "ads", force: :cascade do |t|
    t.boolean "active"
    t.datetime "created_at", null: false
    t.integer "duration"
    t.bigint "movie_id", null: false
    t.string "position"
    t.text "script"
    t.string "title"
    t.datetime "updated_at", null: false
    t.string "url"
    t.index ["movie_id"], name: "index_ads_on_movie_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.datetime "created_at"
    t.string "scope"
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "genres", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "slug"
    t.datetime "updated_at", null: false
  end

  create_table "movies", force: :cascade do |t|
    t.integer "ad_frequency"
    t.text "cast"
    t.string "country"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "director"
    t.decimal "download_price"
    t.string "download_quality"
    t.integer "duration"
    t.boolean "enable_ads"
    t.boolean "enable_download"
    t.string "genre"
    t.bigint "genre_id"
    t.decimal "imdb_rating"
    t.string "poster_url"
    t.integer "release_year"
    t.string "slug"
    t.string "title"
    t.string "trailer_url"
    t.datetime "updated_at", null: false
    t.index ["country"], name: "index_movies_on_country"
    t.index ["genre"], name: "index_movies_on_genre"
    t.index ["genre_id"], name: "index_movies_on_genre_id"
    t.index ["imdb_rating"], name: "index_movies_on_imdb_rating"
    t.index ["release_year"], name: "index_movies_on_release_year"
    t.index ["slug"], name: "index_movies_on_slug", unique: true
    t.index ["title"], name: "index_movies_on_title"
  end

  create_table "tv_shows", force: :cascade do |t|
    t.string "country"
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "episodes"
    t.string "genre"
    t.bigint "genre_id"
    t.decimal "imdb_rating"
    t.string "poster_url"
    t.integer "release_year"
    t.integer "seasons"
    t.string "slug"
    t.string "title"
    t.string "trailer_url"
    t.datetime "updated_at", null: false
    t.index ["country"], name: "index_tv_shows_on_country"
    t.index ["genre"], name: "index_tv_shows_on_genre"
    t.index ["genre_id"], name: "index_tv_shows_on_genre_id"
    t.index ["imdb_rating"], name: "index_tv_shows_on_imdb_rating"
    t.index ["release_year"], name: "index_tv_shows_on_release_year"
    t.index ["slug"], name: "index_tv_shows_on_slug", unique: true
    t.index ["title"], name: "index_tv_shows_on_title"
  end

  create_table "user_favorites", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "is_favorite"
    t.bigint "movie_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["movie_id"], name: "index_user_favorites_on_movie_id"
    t.index ["user_id", "movie_id"], name: "index_user_favorites_on_user_id_and_movie_id", unique: true
    t.index ["user_id"], name: "index_user_favorites_on_user_id"
  end

  create_table "user_movie_ratings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "movie_id", null: false
    t.integer "rating"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["movie_id"], name: "index_user_movie_ratings_on_movie_id"
    t.index ["rating"], name: "index_user_movie_ratings_on_rating"
    t.index ["user_id", "movie_id"], name: "index_user_movie_ratings_on_user_id_and_movie_id", unique: true
    t.index ["user_id"], name: "index_user_movie_ratings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "ads", "movies"
  add_foreign_key "movies", "genres"
  add_foreign_key "tv_shows", "genres"
  add_foreign_key "user_favorites", "movies"
  add_foreign_key "user_favorites", "users"
  add_foreign_key "user_movie_ratings", "movies"
  add_foreign_key "user_movie_ratings", "users"
end
