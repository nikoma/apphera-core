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

ActiveRecord::Schema.define(version: 20140629043046) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "account_types", force: true do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accounts", force: true do |t|
    t.string "name"
    t.string "firstname"
    t.string "lastname"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "account_type_id"
    t.text "organization_list"
    t.integer "reseller_id"
    t.string "street"
    t.string "street1"
    t.integer "country_code_id"
    t.string "city"
    t.string "state"
    t.string "postalcode"
    t.string "web"
    t.integer "country_id"
    t.integer "api_partner_id"
  end

  add_index "accounts", ["api_partner_id"], name: "index_accounts_on_api_partner_id", using: :btree
  add_index "accounts", ["city"], name: "index_accounts_on_city", using: :btree
  add_index "accounts", ["country_code_id"], name: "index_accounts_on_country_code_id", using: :btree
  add_index "accounts", ["name"], name: "index_accounts_on_name", using: :btree
  add_index "accounts", ["reseller_id"], name: "index_accounts_on_reseller_id", using: :btree

  create_table "accounts_keywords", id: false, force: true do |t|
    t.integer "account_id", null: false
    t.integer "keyword_id", null: false
  end

  create_table "accounts_resellers", id: false, force: true do |t|
    t.integer "account_id"
    t.integer "reseller_id"
  end

  create_table "active_admin_comments", force: true do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_id", null: false
    t.string "resource_type", null: false
    t.integer "author_id"
    t.string "author_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "aggregate_results", force: true do |t|
    t.integer "organization_id"
    t.integer "photos"
    t.integer "videos"
    t.integer "score"
    t.integer "reviews"
    t.float "review_avg"
    t.integer "tweets"
    t.integer "tweets_new"
    t.integer "fb_likes"
    t.integer "fb_likes_new"
    t.integer "mentions"
    t.integer "mentions_new"
    t.integer "blog_posts"
    t.integer "blog_posts_new"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "followers"
    t.integer "following"
    t.integer "listed"
    t.integer "reviews_new"
    t.integer "negative_reviews"
    t.integer "negative_reviews_new"
    t.integer "neutral_reviews"
    t.integer "neutral_reviews_new"
    t.integer "positive_reviews"
    t.integer "positive_reviews_new"
    t.string "competitor_results"
    t.integer "fs_checkins_count"
    t.integer "fs_users_count"
    t.integer "fs_tip_count"
  end

  create_table "api_partners", force: true do |t|
    t.string "name"
    t.string "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "callback_url"
  end

  add_index "api_partners", ["name"], name: "index_api_partners_on_name", using: :btree
  add_index "api_partners", ["token"], name: "index_api_partners_on_token", using: :btree

  create_table "categories", force: true do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "catgroup"
    t.integer "category_id"
    t.integer "country_id"
  end

  add_index "categories", ["category_id"], name: "index_categories_on_category_id", using: :btree
  add_index "categories", ["catgroup"], name: "index_categories_on_group", using: :btree

  create_table "categories_organizations", id: false, force: true do |t|
    t.integer "category_id"
    t.integer "organization_id"
  end

  create_table "cities", force: true do |t|
    t.integer "country_id", null: false
    t.integer "division_id"
    t.integer "geonames_id", null: false
    t.string "name", null: false
    t.string "ascii_name"
    t.text "alternate_name"
    t.decimal "latitude", precision: 14, scale: 8, null: false
    t.decimal "longitude", precision: 14, scale: 8, null: false
    t.string "country_iso_code_two_letters"
    t.string "admin_1_code"
    t.string "admin_2_code"
    t.string "admin_3_code"
    t.string "admin_4_code"
    t.integer "population"
    t.integer "elevation"
    t.integer "geonames_timezone_id"
  end

  add_index "cities", ["geonames_id"], name: "index_cities_on_geonames_id", unique: true, using: :btree

  create_table "command_items", force: true do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "competitors_organizations", id: false, force: true do |t|
    t.integer "organization_a_id", null: false
    t.integer "organization_b_id", null: false
  end

  create_table "contacts", force: true do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "city"
    t.string "country"
    t.string "subject"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "content_providers", force: true do |t|
    t.string "name"
    t.string "description"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "content_providers_proxies", id: false, force: true do |t|
    t.integer "content_provider_id", null: false
    t.integer "proxy_id", null: false
  end

  create_table "countries", force: true do |t|
    t.string "iso_code_two_letter", null: false
    t.string "iso_code_three_letter", null: false
    t.integer "iso_number", null: false
    t.string "name", null: false
    t.string "capital"
    t.integer "area_in_square_km"
    t.integer "population"
    t.string "continent"
    t.string "currency_code"
    t.string "currency_name"
    t.string "phone"
    t.string "languages"
    t.integer "geonames_id"
  end

  add_index "countries", ["geonames_id"], name: "index_countries_on_geonames_id", using: :btree
  add_index "countries", ["iso_code_two_letter"], name: "index_countries_on_iso_code_two_letter", unique: true, using: :btree

  create_table "country_codes", force: true do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "country_codes", ["code"], name: "index_country_codes_on_code", using: :btree
  add_index "country_codes", ["name"], name: "index_country_codes_on_name", using: :btree

  create_table "crawler_jobs", force: true do |t|
    t.string "token"
    t.string "keywords"
    t.boolean "processed"
    t.string "city"
    t.string "country"
    t.string "provider"
    t.integer "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "credit_cards", force: true do |t|
    t.integer "user_id", null: false
    t.string "stripe_customer_id"
    t.string "card_zip"
    t.string "card_cvc"
    t.string "card_type"
    t.date "next_bill_on"
    t.integer "month_expiration"
    t.integer "year_expiration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "database_counts", force: true do |t|
    t.integer "tweets"
    t.integer "twitter_users"
    t.integer "keywords"
    t.integer "users"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "divisions", force: true do |t|
    t.integer "country_id"
    t.string "code"
    t.string "full_code"
    t.string "name"
    t.string "ascii_name"
    t.integer "geonames_id"
  end

  add_index "divisions", ["code"], name: "index_divisions_on_code", using: :btree
  add_index "divisions", ["full_code"], name: "index_divisions_on_full_code", unique: true, using: :btree
  add_index "divisions", ["geonames_id"], name: "index_divisions_on_geonames_id", unique: true, using: :btree

  create_table "facebook_urls", force: true do |t|
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "facebook_urls_organizations", id: false, force: true do |t|
    t.integer "organization_id", null: false
    t.integer "facebook_url_id", null: false
  end

  create_table "facebookpages", force: true do |t|
    t.integer "organization_id"
    t.string "url"
    t.string "title"
    t.integer "likes"
    t.integer "talking"
    t.integer "where_here"
    t.integer "posts"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "failed_jobs", force: true do |t|
    t.integer "organization_id"
    t.integer "schedule_id"
    t.integer "retry_count"
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "failed_jobs", ["organization_id"], name: "index_failed_jobs_on_organization_id", using: :btree
  add_index "failed_jobs", ["schedule_id"], name: "index_failed_jobs_on_schedule_id", using: :btree

  create_table "folders", force: true do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "folders", ["name"], name: "index_folders_on_name", using: :btree

  create_table "foursquare_counts", force: true do |t|
    t.integer "foursquare_venue_id"
    t.integer "checkins_count"
    t.integer "users_count"
    t.integer "tip_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "foursquare_counts", ["foursquare_venue_id"], name: "index_foursquare_counts_on_foursquare_venue_id", using: :btree

  create_table "foursquare_users", force: true do |t|
    t.string "name"
    t.string "first_name"
    t.string "city"
    t.string "gender"
    t.string "foursquare_user_id"
    t.string "photo"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "foursquare_users", ["city"], name: "index_foursquare_users_on_city", using: :btree
  add_index "foursquare_users", ["foursquare_user_id"], name: "index_foursquare_users_on_foursquare_user_id", using: :btree

  create_table "foursquare_venues", force: true do |t|
    t.string "foursquare_id"
    t.string "name"
    t.string "phone"
    t.string "category"
    t.integer "organization_id"
    t.string "top_category"
    t.string "address"
    t.string "city"
    t.string "postalcode"
    t.string "state"
    t.string "lat"
    t.string "lng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "foursquare_venues", ["category"], name: "index_foursquare_venues_on_category", using: :btree
  add_index "foursquare_venues", ["foursquare_id"], name: "index_foursquare_venues_on_foursquare_id", using: :btree
  add_index "foursquare_venues", ["name"], name: "index_foursquare_venues_on_name", using: :btree
  add_index "foursquare_venues", ["organization_id"], name: "index_foursquare_venues_on_organization_id", using: :btree

  create_table "foursquare_venues_users", id: false, force: true do |t|
    t.integer "foursquare_venue_id", null: false
    t.integer "foursquare_user_id", null: false
  end

  create_table "geodata", force: true do |t|
    t.string "country"
    t.string "region"
    t.string "city"
    t.string "postalcode"
    t.string "latitude"
    t.string "longitude"
    t.string "metrocode"
    t.string "areacode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "geodata", ["city"], name: "index_geodata_on_city", using: :btree
  add_index "geodata", ["country"], name: "index_geodata_on_country", using: :btree
  add_index "geodata", ["postalcode"], name: "index_geodata_on_postalcode", using: :btree
  add_index "geodata", ["region"], name: "index_geodata_on_region", using: :btree

  create_table "google_plus_users", force: true do |t|
    t.string "display_name"
    t.string "gender"
    t.string "kind"
    t.string "url"
    t.string "image_url"
    t.hstore "places_lived"
    t.hstore "organizations"
    t.boolean "verified"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "google_plus_users", ["display_name"], name: "index_google_plus_users_on_display_name", using: :btree
  add_index "google_plus_users", ["gender"], name: "index_google_plus_users_on_gender", using: :btree

  create_table "history_items", force: true do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "organization_id"
  end

  add_index "history_items", ["organization_id"], name: "index_history_items_on_organization_id", using: :btree
  add_index "history_items", ["user_id"], name: "index_history_items_on_user_id", using: :btree

  create_table "items", force: true do |t|
    t.string "subject"
    t.text "body"
    t.float "rating"
    t.integer "kind_id"
    t.integer "folder"
    t.boolean "visible"
    t.integer "source"
    t.datetime "reminder"
    t.boolean "new"
    t.integer "organization_id"
    t.integer "reviewer_id"
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.hstore "properties"
  end

  add_index "items", ["completed"], name: "index_items_on_completed", using: :btree
  add_index "items", ["folder"], name: "index_items_on_folder", using: :btree
  add_index "items", ["kind_id"], name: "index_items_on_type", using: :btree
  add_index "items", ["organization_id"], name: "index_items_on_organization_id", using: :btree
  add_index "items", ["properties"], name: "items_properties", using: :gin
  add_index "items", ["reviewer_id"], name: "index_items_on_reviewer_id", using: :btree
  add_index "items", ["source"], name: "index_items_on_source", using: :btree
  add_index "items", ["visible"], name: "index_items_on_visible", using: :btree

  create_table "job_observers", force: true do |t|
    t.integer "schedule_id"
    t.integer "retry_count"
    t.integer "organization_id"
    t.boolean "failed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "job_observers", ["failed"], name: "index_job_observers_on_failed", using: :btree
  add_index "job_observers", ["organization_id"], name: "index_job_observers_on_organization_id", using: :btree
  add_index "job_observers", ["schedule_id"], name: "index_job_observers_on_schedule_id", using: :btree

  create_table "jobs", force: true do |t|
    t.integer "org_id"
    t.integer "stage"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "keywords", force: true do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "keywords_organizations", id: false, force: true do |t|
    t.integer "keyword_id"
    t.integer "organization_id"
  end

  create_table "kinds", force: true do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: true do |t|
    t.integer "count"
    t.integer "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "listings", force: true do |t|
    t.integer "organization_id"
    t.string "name"
    t.string "content_provider"
    t.string "phone"
    t.string "street"
    t.string "zip"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "listings", ["content_provider"], name: "index_listings_on_content_provider", using: :btree
  add_index "listings", ["organization_id"], name: "index_listings_on_org_id", using: :btree

  create_table "mercury_images", force: true do |t|
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "my_competitors", force: true do |t|
    t.string "name"
    t.string "street"
    t.string "zipcode"
    t.string "city"
    t.string "phone"
    t.string "short_profile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "organization_id"
  end

  add_index "my_competitors", ["name"], name: "index_my_competitors_on_name", using: :btree

  create_table "network_weathers", force: true do |t|
    t.float "sentiment"
    t.integer "public_keyword_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organization_links", force: true do |t|
    t.string "bing_id"
    t.integer "organization_id"
    t.string "bing_display_url"
    t.string "url"
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "organization_links", ["bing_id"], name: "index_organization_links_on_bing_id", using: :btree
  add_index "organization_links", ["organization_id"], name: "index_organization_links_on_organization_id", using: :btree
  add_index "organization_links", ["url"], name: "index_organization_links_on_url", using: :btree

  create_table "organizations", force: true do |t|
    t.string "name"
    t.string "street"
    t.string "street2"
    t.string "postalcode"
    t.string "state"
    t.string "phone1"
    t.string "phone2"
    t.text "competitors"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.string "yahooslug"
    t.integer "account_id"
    t.boolean "scheduled"
    t.string "facebook"
    t.string "twitter"
    t.float "latitude"
    t.float "longitude"
    t.integer "category_id"
    t.integer "country_code_id"
    t.text "reviewers_list"
    t.boolean "gmaps"
    t.string "cat_name"
    t.integer "city_id"
    t.string "city"
    t.string "geopoint", limit: nil
    t.float "loc", array: true
  end

  add_index "organizations", ["account_id"], name: "account_id_idx", using: :btree
  add_index "organizations", ["cat_name"], name: "index_organizations_on_cat_name", using: :btree
  add_index "organizations", ["category_id"], name: "index_organizations_on_category_id", using: :btree
  add_index "organizations", ["country_code_id"], name: "index_organizations_on_country_code_id", using: :btree
  add_index "organizations", ["gmaps"], name: "index_organizations_on_gmaps", using: :btree
  add_index "organizations", ["postalcode"], name: "index_organizations_on_postalcode", using: :btree
  add_index "organizations", ["scheduled"], name: "index_organizations_on_scheduled", using: :btree

  create_table "organizations_twitter_urls", id: false, force: true do |t|
    t.integer "organization_id", null: false
    t.integer "twitter_url_id", null: false
  end

  create_table "plans", force: true do |t|
    t.string "name"
    t.decimal "price", precision: 10, scale: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "plans", ["name"], name: "index_plans_on_name", using: :btree

  create_table "provider_slugs", force: true do |t|
    t.integer "content_provider_id"
    t.integer "organization_id"
    t.string "slug"
    t.boolean "bad"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "provider_slugs", ["content_provider_id"], name: "index_provider_slugs_on_content_provider_id", using: :btree
  add_index "provider_slugs", ["organization_id"], name: "index_provider_slugs_on_organization_id", using: :btree

  create_table "proxies", force: true do |t|
    t.string "ip"
    t.string "port"
    t.boolean "tested"
    t.boolean "bad"
    t.string "country"
    t.datetime "last_used"
    t.integer "content_provider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "public_keywords", force: true do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchases", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rankings", force: true do |t|
    t.integer "rank"
    t.integer "content_provider_id"
    t.integer "organization_id"
    t.integer "keyword_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.string "name"
    t.string "token"
    t.hstore "results"
    t.json "ranks"
  end

  add_index "rankings", ["results"], name: "rankings_results", using: :gin

  create_table "ratings", force: true do |t|
    t.integer "ratingcount"
    t.float "rating"
    t.integer "content_provider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "organization_id"
  end

  create_table "recommendations", force: true do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "kind"
  end

  create_table "reseller_categories", force: true do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reseller_commissions", force: true do |t|
    t.string "name"
    t.integer "percentage"
    t.string "notes"
    t.integer "reseller_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reseller_commissions", ["reseller_id"], name: "index_reseller_commissions_on_reseller_id", using: :btree

  create_table "resellers", force: true do |t|
    t.string "company"
    t.string "name"
    t.string "first_name"
    t.string "street"
    t.string "street2"
    t.string "city"
    t.string "state"
    t.string "postalcode"
    t.integer "reseller_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sub_domain"
    t.string "logo"
    t.integer "country_code_id"
    t.string "email"
    t.string "website"
    t.string "twitter"
    t.string "facebook"
    t.string "phone"
  end

  add_index "resellers", ["sub_domain"], name: "index_resellers_on_sub_domain", using: :btree

  create_table "resellers_users", id: false, force: true do |t|
    t.integer "reseller_id", null: false
    t.integer "user_id", null: false
  end

  create_table "reviewers", force: true do |t|
    t.string "name"
    t.integer "content_provider_id"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "imageurl"
    t.integer "review_count"
    t.float "average_review"
  end

  add_index "reviewers", ["content_provider_id"], name: "index_reviewers_on_content_provider_id", using: :btree
  add_index "reviewers", ["name"], name: "index_reviewers_on_name", using: :btree
  add_index "reviewers", ["slug"], name: "index_reviewers_on_slug", using: :btree

  create_table "reviewers_reviews", id: false, force: true do |t|
    t.integer "reviewer_id"
    t.integer "review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: true do |t|
    t.integer "organization_id"
    t.integer "content_provider_id"
    t.string "reviewer"
    t.string "reviewer_slug"
    t.date "review_date"
    t.text "body"
    t.float "rating"
    t.boolean "processed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reviewer_id"
    t.string "review_provider_id"
    t.string "title"
    t.string "review_url"
  end

  add_index "reviews", ["rating"], name: "rating_idx", using: :btree
  add_index "reviews", ["review_url"], name: "index_reviews_on_review_url", using: :btree
  add_index "reviews", ["reviewer_id"], name: "index_reviews_on_reviewer_id", using: :btree

  create_table "roles", force: true do |t|
    t.string "name"
    t.integer "resource_id"
    t.string "resource_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "schedules", force: true do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "organization_id"
    t.integer "sequence_id"
    t.boolean "in_progress"
    t.datetime "scheduled"
    t.string "payload"
  end

  add_index "schedules", ["in_progress"], name: "index_schedules_on_in_progress", using: :btree
  add_index "schedules", ["organization_id"], name: "index_schedules_on_organization_id", using: :btree
  add_index "schedules", ["scheduled"], name: "index_schedules_on_scheduled", using: :btree
  add_index "schedules", ["sequence_id"], name: "index_schedules_on_sequence_id", using: :btree

  create_table "sentiment", id: false, force: true do |t|
    t.integer "id", limit: 8, null: false
    t.integer "version", limit: 8, null: false
    t.string "language", null: false
    t.float "value", null: false
    t.string "word", null: false
  end

  create_table "sentiments", force: true do |t|
    t.string "word"
    t.string "language", limit: 2
    t.float "value"
    t.string "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "tested"
    t.boolean "correct"
  end

  add_index "sentiments", ["correct"], name: "index_sentiments_on_correct", using: :btree
  add_index "sentiments", ["language"], name: "language_idx", using: :btree
  add_index "sentiments", ["tested"], name: "index_sentiments_on_tested", using: :btree
  add_index "sentiments", ["word", "language"], name: "word_language_mm_idx", unique: true, using: :btree
  add_index "sentiments", ["word"], name: "word_idx", using: :btree

  create_table "sequence_items", force: true do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sequence_items_sequences", id: false, force: true do |t|
    t.integer "sequence_item_id"
    t.integer "sequence_id"
  end

  create_table "sequences", force: true do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: true do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "subscriptions", force: true do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "plan_id"
  end

  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "targets", force: true do |t|
    t.string "name"
    t.string "street"
    t.string "postalcode"
    t.string "phone"
    t.string "city"
    t.string "state"
    t.string "url"
    t.integer "reviews"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
  end

  add_index "targets", ["category"], name: "index_targets_on_category", using: :btree

  create_table "task_results", force: true do |t|
    t.integer "organization_id"
    t.integer "task_id"
    t.boolean "relevant"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "task_results", ["organization_id"], name: "index_task_results_on_organization_id", using: :btree
  add_index "task_results", ["relevant"], name: "index_task_results_on_relevant", using: :btree
  add_index "task_results", ["status"], name: "index_task_results_on_status", using: :btree
  add_index "task_results", ["task_id"], name: "index_task_results_on_task_id", using: :btree

  create_table "task_translations", force: true do |t|
    t.integer "task_id"
    t.integer "language_id"
    t.string "header"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "task_translations", ["language_id"], name: "index_task_translations_on_language_id", using: :btree
  add_index "task_translations", ["task_id"], name: "index_task_translations_on_task_id", using: :btree

  create_table "tasks", force: true do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "weight"
  end

  add_index "tasks", ["name"], name: "index_tasks_on_name", using: :btree

  create_table "timer_options", force: true do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tweets", force: true do |t|
    t.string "tweet_id"
    t.string "content"
    t.string "in_reply_to"
    t.integer "re_tweets"
    t.datetime "created_at", null: false
    t.float "sentiment"
    t.datetime "updated_at", null: false
    t.string "twitter_user_id"
    t.integer "favorites_count"
  end

  add_index "tweets", ["created_at"], name: "index_tweets_on_created_at", using: :btree
  add_index "tweets", ["in_reply_to"], name: "index_tweets_on_in_reply_to", using: :btree
  add_index "tweets", ["tweet_id"], name: "index_tweets_on_tweet_id", using: :btree
  add_index "tweets", ["twitter_user_id"], name: "index_tweets_on_twitter_user_id", using: :btree

  create_table "twitter_counts", force: true do |t|
    t.integer "twitter_url_id"
    t.integer "followers"
    t.integer "following"
    t.integer "tweets"
    t.integer "listed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "twitter_counts", ["twitter_url_id"], name: "index_twitter_counts_on_twitter_url_id", using: :btree

  create_table "twitter_urls", force: true do |t|
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "twitter_users", force: true do |t|
    t.integer "twitter_id"
    t.string "screen_name"
    t.string "name"
    t.integer "followers"
    t.integer "following"
    t.integer "listed"
    t.integer "total_statuses"
    t.string "image_url"
    t.string "language", limit: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "from"
    t.date "user_since"
  end

  add_index "twitter_users", ["from"], name: "index_twitter_users_on_from", using: :btree
  add_index "twitter_users", ["language"], name: "index_twitter_users_on_language", using: :btree
  add_index "twitter_users", ["name"], name: "index_twitter_users_on_name", using: :btree
  add_index "twitter_users", ["screen_name"], name: "index_twitter_users_on_screen_name", using: :btree
  add_index "twitter_users", ["twitter_id"], name: "index_twitter_users_on_twitter_id", using: :btree

  create_table "uptime_monitors", force: true do |t|
    t.integer "organization_id"
    t.float "load_time"
    t.datetime "time_stamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
  end

  add_index "uptime_monitors", ["organization_id"], name: "index_uptime_monitors_on_organization_id", using: :btree
  add_index "uptime_monitors", ["time_stamp"], name: "index_uptime_monitors_on_time_stamp", using: :btree

  create_table "users", force: true do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "account_id"
    t.string "api_key"
    t.string "name"
    t.integer "reseller_id"
    t.boolean "is_reseller"
    t.integer "referred_by"
    t.string "authentication_token"
  end

  add_index "users", ["account_id"], name: "index_users_on_account_id", using: :btree
  add_index "users", ["api_key"], name: "index_users_on_api_key", using: :btree
  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["is_reseller"], name: "index_users_on_is_reseller", using: :btree
  add_index "users", ["referred_by"], name: "index_users_on_referred_by", using: :btree
  add_index "users", ["reseller_id"], name: "index_users_on_reseller_id", using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "versions", force: true do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "web_contents", force: true do |t|
    t.integer "user_id"
    t.integer "job_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "web_contents", ["job_id"], name: "index_web_contents_on_job_id", using: :btree
  add_index "web_contents", ["user_id"], name: "index_web_contents_on_user_id", using: :btree

  create_table "work_queues", force: true do |t|
    t.integer "schedule_id"
    t.integer "retry_count"
    t.string "queue_name"
    t.string "url"
    t.integer "org_id"
    t.string "content_provider"
    t.string "keywords"
    t.string "misc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "invisible"
  end

  add_index "work_queues", ["content_provider"], name: "index_work_queues_on_content_provider", using: :btree
  add_index "work_queues", ["invisible"], name: "index_work_queues_on_invisible", using: :btree
  add_index "work_queues", ["org_id"], name: "index_work_queues_on_org_id", using: :btree
  add_index "work_queues", ["queue_name"], name: "index_work_queues_on_queue_name", using: :btree
  add_index "work_queues", ["retry_count"], name: "index_work_queues_on_retry_count", using: :btree
  add_index "work_queues", ["schedule_id"], name: "index_work_queues_on_schedule_id", using: :btree

end
