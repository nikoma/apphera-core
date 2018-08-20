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

ActiveRecord::Schema.define(version: 2018_08_20_185427) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"
  enable_extension "postgis_topology"

  create_table "account_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "description", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accounts", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "firstname", limit: 255
    t.string "lastname", limit: 255
    t.string "phone", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "account_type_id"
    t.text "organization_list"
    t.integer "reseller_id"
    t.string "street", limit: 255
    t.string "street1", limit: 255
    t.integer "country_code_id"
    t.string "city", limit: 255
    t.string "state", limit: 255
    t.string "postalcode", limit: 255
    t.string "web", limit: 255
    t.integer "country_id"
    t.integer "api_partner_id"
    t.index ["api_partner_id"], name: "index_accounts_on_api_partner_id"
    t.index ["city"], name: "index_accounts_on_city"
    t.index ["country_code_id"], name: "index_accounts_on_country_code_id"
    t.index ["name"], name: "index_accounts_on_name"
    t.index ["reseller_id"], name: "index_accounts_on_reseller_id"
  end

  create_table "accounts_keywords", id: false, force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "keyword_id", null: false
  end

  create_table "accounts_resellers", id: false, force: :cascade do |t|
    t.integer "account_id"
    t.integer "reseller_id"
  end

  create_table "active_admin_comments", id: :serial, force: :cascade do |t|
    t.string "namespace", limit: 255
    t.text "body"
    t.string "resource_id", limit: 255, null: false
    t.string "resource_type", limit: 255, null: false
    t.integer "author_id"
    t.string "author_type", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "aggregate_results", id: :serial, force: :cascade do |t|
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
    t.string "competitor_results", limit: 255
    t.integer "fs_checkins_count"
    t.integer "fs_users_count"
    t.integer "fs_tip_count"
  end

  create_table "analytics_ranges", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "api_partner_id"
    t.string "from", limit: 255
    t.string "to", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["api_partner_id"], name: "index_analytics_ranges_on_api_partner_id"
    t.index ["name"], name: "index_analytics_ranges_on_name"
  end

  create_table "analytics_results", id: :serial, force: :cascade do |t|
    t.integer "account_id"
    t.integer "campaign_id"
    t.integer "date_range_id"
    t.json "results"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["account_id"], name: "index_analytics_results_on_account_id"
    t.index ["campaign_id"], name: "index_analytics_results_on_campaign_id"
    t.index ["date_range_id"], name: "index_analytics_results_on_date_range_id"
  end

  create_table "api_partners", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "token", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "callback_url", limit: 255
    t.string "partner_token", limit: 255
    t.index ["name"], name: "index_api_partners_on_name"
    t.index ["token"], name: "index_api_partners_on_token"
  end

  create_table "campaigns", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "account_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["account_id"], name: "index_campaigns_on_account_id"
    t.index ["end_date"], name: "index_campaigns_on_end_date"
    t.index ["start_date"], name: "index_campaigns_on_start_date"
  end

  create_table "campaigns_keywords", id: false, force: :cascade do |t|
    t.integer "campaign_id"
    t.integer "keyword_id"
    t.index ["campaign_id"], name: "index_campaigns_keywords_on_campaign_id"
    t.index ["keyword_id"], name: "index_campaigns_keywords_on_keyword_id"
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "catgroup", limit: 255
    t.integer "category_id"
    t.integer "country_id"
    t.index ["category_id"], name: "index_categories_on_category_id"
    t.index ["catgroup"], name: "index_categories_on_group"
  end

  create_table "categories_organizations", id: false, force: :cascade do |t|
    t.integer "category_id"
    t.integer "organization_id"
  end

  create_table "cities", id: :serial, force: :cascade do |t|
    t.integer "country_id", null: false
    t.integer "division_id"
    t.integer "geonames_id", null: false
    t.string "name", limit: 255, null: false
    t.string "ascii_name", limit: 255
    t.text "alternate_name"
    t.decimal "latitude", precision: 14, scale: 8, null: false
    t.decimal "longitude", precision: 14, scale: 8, null: false
    t.string "country_iso_code_two_letters", limit: 255
    t.string "admin_1_code", limit: 255
    t.string "admin_2_code", limit: 255
    t.string "admin_3_code", limit: 255
    t.string "admin_4_code", limit: 255
    t.integer "population"
    t.integer "elevation"
    t.integer "geonames_timezone_id"
    t.index ["geonames_id"], name: "index_cities_on_geonames_id", unique: true
  end

  create_table "command_items", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "description", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "competitors_organizations", id: false, force: :cascade do |t|
    t.integer "organization_a_id", null: false
    t.integer "organization_b_id", null: false
  end

  create_table "contacts", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "email", limit: 255
    t.string "phone", limit: 255
    t.string "city", limit: 255
    t.string "country", limit: 255
    t.string "subject", limit: 255
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "content_providers", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "description", limit: 255
    t.string "url", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "content_providers_proxies", id: false, force: :cascade do |t|
    t.integer "content_provider_id", null: false
    t.integer "proxy_id", null: false
  end

  create_table "countries", id: :serial, force: :cascade do |t|
    t.string "iso_code_two_letter", limit: 255, null: false
    t.string "iso_code_three_letter", limit: 255, null: false
    t.integer "iso_number", null: false
    t.string "name", limit: 255, null: false
    t.string "capital", limit: 255
    t.integer "area_in_square_km"
    t.integer "population"
    t.string "continent", limit: 255
    t.string "currency_code", limit: 255
    t.string "currency_name", limit: 255
    t.string "phone", limit: 255
    t.string "languages", limit: 255
    t.integer "geonames_id"
    t.index ["geonames_id"], name: "index_countries_on_geonames_id"
    t.index ["iso_code_two_letter"], name: "index_countries_on_iso_code_two_letter", unique: true
  end

  create_table "country_codes", id: :serial, force: :cascade do |t|
    t.string "code", limit: 255
    t.string "name", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_country_codes_on_code"
    t.index ["name"], name: "index_country_codes_on_name"
  end

  create_table "crawler_jobs", id: :serial, force: :cascade do |t|
    t.string "token", limit: 255
    t.string "keywords", limit: 255
    t.boolean "processed"
    t.string "city", limit: 255
    t.string "country", limit: 255
    t.string "provider", limit: 255
    t.integer "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "credit_cards", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "stripe_customer_id", limit: 255
    t.string "card_zip", limit: 255
    t.string "card_cvc", limit: 255
    t.string "card_type", limit: 255
    t.date "next_bill_on"
    t.integer "month_expiration"
    t.integer "year_expiration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "database_counts", id: :serial, force: :cascade do |t|
    t.integer "tweets"
    t.integer "twitter_users"
    t.integer "keywords"
    t.integer "users"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "date_ranges", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "description", limit: 255
    t.string "from", limit: 255
    t.string "to", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "divisions", id: :serial, force: :cascade do |t|
    t.integer "country_id"
    t.string "code", limit: 255
    t.string "full_code", limit: 255
    t.string "name", limit: 255
    t.string "ascii_name", limit: 255
    t.integer "geonames_id"
    t.index ["code"], name: "index_divisions_on_code"
    t.index ["full_code"], name: "index_divisions_on_full_code", unique: true
    t.index ["geonames_id"], name: "index_divisions_on_geonames_id", unique: true
  end

  create_table "facebook_credentials", id: :serial, force: :cascade do |t|
    t.integer "account_id"
    t.string "c_user_id", limit: 255
    t.string "access_token", limit: 255
    t.datetime "expires"
    t.integer "organization_id"
    t.string "facebook_id", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["facebook_id"], name: "index_facebook_credentials_on_facebook_id"
  end

  create_table "facebook_credentials_facebook_page_credentials", id: false, force: :cascade do |t|
    t.integer "facebook_credential_id"
    t.integer "facebook_page_credential_id"
  end

  create_table "facebook_items", id: :serial, force: :cascade do |t|
    t.integer "keyword_id"
    t.json "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float "sentiment"
  end

  create_table "facebook_page_credentials", id: :serial, force: :cascade do |t|
    t.integer "account_id"
    t.json "perms"
    t.integer "organization_id"
    t.string "fb_id", limit: 255
    t.string "name", limit: 255
    t.string "category", limit: 255
    t.boolean "has_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "access_token", limit: 255
    t.string "c_user_id", limit: 255
    t.index ["account_id"], name: "index_facebook_page_credentials_on_account_id"
    t.index ["c_user_id"], name: "index_facebook_page_credentials_on_c_user_id"
    t.index ["category"], name: "index_facebook_page_credentials_on_category"
    t.index ["fb_id"], name: "index_facebook_page_credentials_on_fb_id"
    t.index ["name"], name: "index_facebook_page_credentials_on_name"
    t.index ["organization_id"], name: "index_facebook_page_credentials_on_organization_id"
  end

  create_table "facebook_page_posts", id: :serial, force: :cascade do |t|
    t.integer "api_partner_id"
    t.string "page_id", limit: 255
    t.integer "account_id"
    t.integer "organization_id"
    t.datetime "post_date"
    t.string "body", limit: 255
    t.string "picture", limit: 255
    t.string "link", limit: 255
    t.string "description", limit: 255
    t.boolean "post_as_user"
    t.string "c_user_id", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["account_id"], name: "index_facebook_page_posts_on_account_id"
    t.index ["api_partner_id"], name: "index_facebook_page_posts_on_api_partner_id"
    t.index ["organization_id"], name: "index_facebook_page_posts_on_organization_id"
    t.index ["page_id"], name: "index_facebook_page_posts_on_page_id"
  end

  create_table "facebook_posts", id: :serial, force: :cascade do |t|
    t.integer "account_id"
    t.integer "organization_id"
    t.datetime "post_date"
    t.string "token", limit: 255
    t.string "body", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "api_partner_id"
    t.string "picture", limit: 255
    t.string "link", limit: 255
    t.string "name", limit: 255
    t.string "description", limit: 255
    t.index ["account_id"], name: "index_facebook_posts_on_account_id"
    t.index ["api_partner_id"], name: "index_facebook_posts_on_api_partner_id"
    t.index ["organization_id"], name: "index_facebook_posts_on_organization_id"
    t.index ["post_date"], name: "index_facebook_posts_on_post_date"
  end

  create_table "facebook_urls", id: :serial, force: :cascade do |t|
    t.string "url", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "facebook_urls_organizations", id: false, force: :cascade do |t|
    t.integer "organization_id", null: false
    t.integer "facebook_url_id", null: false
  end

  create_table "facebookpages", id: :serial, force: :cascade do |t|
    t.integer "organization_id"
    t.string "url", limit: 255
    t.string "title", limit: 255
    t.integer "likes"
    t.integer "talking"
    t.integer "where_here"
    t.integer "posts"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "failed_jobs", id: :serial, force: :cascade do |t|
    t.integer "organization_id"
    t.integer "schedule_id"
    t.integer "retry_count"
    t.string "reason", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_failed_jobs_on_organization_id"
    t.index ["schedule_id"], name: "index_failed_jobs_on_schedule_id"
  end

  create_table "folders", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_folders_on_name"
  end

  create_table "foursquare_counts", id: :serial, force: :cascade do |t|
    t.integer "foursquare_venue_id"
    t.integer "checkins_count"
    t.integer "users_count"
    t.integer "tip_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["foursquare_venue_id"], name: "index_foursquare_counts_on_foursquare_venue_id"
  end

  create_table "foursquare_users", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "first_name", limit: 255
    t.string "city", limit: 255
    t.string "gender", limit: 255
    t.string "foursquare_user_id", limit: 255
    t.string "photo", limit: 255
    t.string "url", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city"], name: "index_foursquare_users_on_city"
    t.index ["foursquare_user_id"], name: "index_foursquare_users_on_foursquare_user_id"
  end

  create_table "foursquare_venues", id: :serial, force: :cascade do |t|
    t.string "foursquare_id", limit: 255
    t.string "name", limit: 255
    t.string "phone", limit: 255
    t.string "category", limit: 255
    t.integer "organization_id"
    t.string "top_category", limit: 255
    t.string "address", limit: 255
    t.string "city", limit: 255
    t.string "postalcode", limit: 255
    t.string "state", limit: 255
    t.string "lat", limit: 255
    t.string "lng", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_foursquare_venues_on_category"
    t.index ["foursquare_id"], name: "index_foursquare_venues_on_foursquare_id"
    t.index ["name"], name: "index_foursquare_venues_on_name"
    t.index ["organization_id"], name: "index_foursquare_venues_on_organization_id"
  end

  create_table "foursquare_venues_users", id: false, force: :cascade do |t|
    t.integer "foursquare_venue_id", null: false
    t.integer "foursquare_user_id", null: false
  end

  create_table "geodata", id: :serial, force: :cascade do |t|
    t.string "country", limit: 255
    t.string "region", limit: 255
    t.string "city", limit: 255
    t.string "postalcode", limit: 255
    t.string "latitude", limit: 255
    t.string "longitude", limit: 255
    t.string "metrocode", limit: 255
    t.string "areacode", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city"], name: "index_geodata_on_city"
    t.index ["country"], name: "index_geodata_on_country"
    t.index ["postalcode"], name: "index_geodata_on_postalcode"
    t.index ["region"], name: "index_geodata_on_region"
  end

  create_table "history_items", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "description", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "organization_id"
    t.index ["organization_id"], name: "index_history_items_on_organization_id"
    t.index ["user_id"], name: "index_history_items_on_user_id"
  end

  create_table "instagram_items", id: :serial, force: :cascade do |t|
    t.integer "keyword_id"
    t.json "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["keyword_id"], name: "index_instagram_items_on_keyword_id"
  end

  create_table "job_observers", id: :serial, force: :cascade do |t|
    t.integer "schedule_id"
    t.integer "retry_count"
    t.integer "organization_id"
    t.boolean "failed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["failed"], name: "index_job_observers_on_failed"
    t.index ["organization_id"], name: "index_job_observers_on_organization_id"
    t.index ["schedule_id"], name: "index_job_observers_on_schedule_id"
  end

  create_table "jobs", id: :serial, force: :cascade do |t|
    t.integer "org_id"
    t.integer "stage"
    t.string "name", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "keyword_aggregates", id: :serial, force: :cascade do |t|
    t.integer "keyword_id"
    t.json "aggregates"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["keyword_id"], name: "index_keyword_aggregates_on_keyword_id"
  end

  create_table "keywords", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tracks", limit: 255, array: true
    t.json "markets"
  end

  create_table "keywords_organizations", id: false, force: :cascade do |t|
    t.integer "keyword_id"
    t.integer "organization_id"
  end

  create_table "kinds", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "layer", primary_key: ["topology_id", "layer_id"], force: :cascade do |t|
    t.integer "topology_id", null: false
    t.integer "layer_id", null: false
    t.string "schema_name", null: false
    t.string "table_name", null: false
    t.string "feature_column", null: false
    t.integer "feature_type", null: false
    t.integer "level", default: 0, null: false
    t.integer "child_id"
    t.index ["schema_name", "table_name", "feature_column"], name: "layer_schema_name_table_name_feature_column_key", unique: true
  end

  create_table "likes", id: :serial, force: :cascade do |t|
    t.integer "count"
    t.integer "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "listings", id: :serial, force: :cascade do |t|
    t.integer "organization_id"
    t.string "name", limit: 255
    t.string "content_provider", limit: 255
    t.string "phone", limit: 255
    t.string "street", limit: 255
    t.string "zip", limit: 255
    t.string "city", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_provider"], name: "index_listings_on_content_provider"
    t.index ["organization_id"], name: "index_listings_on_org_id"
  end

  create_table "markets", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "language", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_markets_on_name"
  end

  create_table "mercury_images", id: :serial, force: :cascade do |t|
    t.string "image_file_name", limit: 255
    t.string "image_content_type", limit: 255
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "my_competitors", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "street", limit: 255
    t.string "zipcode", limit: 255
    t.string "city", limit: 255
    t.string "phone", limit: 255
    t.string "short_profile", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "organization_id"
    t.index ["name"], name: "index_my_competitors_on_name"
  end

  create_table "named_queries", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "api_partner_id"
    t.integer "account_id"
    t.string "description", limit: 255
    t.json "query"
    t.json "placeholders"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["account_id"], name: "index_named_queries_on_account_id"
    t.index ["api_partner_id"], name: "index_named_queries_on_api_partner_id"
    t.index ["name"], name: "index_named_queries_on_name"
  end

  create_table "network_weathers", id: :serial, force: :cascade do |t|
    t.float "sentiment"
    t.integer "public_keyword_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "news_items", id: :serial, force: :cascade do |t|
    t.integer "keyword_id"
    t.json "body"
    t.integer "market_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["keyword_id"], name: "index_news_items_on_keyword_id"
    t.index ["market_id"], name: "index_news_items_on_market_id"
  end

  create_table "organization_links", id: :serial, force: :cascade do |t|
    t.string "bing_id", limit: 255
    t.integer "organization_id"
    t.string "bing_display_url", limit: 255
    t.string "url", limit: 255
    t.string "title", limit: 255
    t.string "description", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bing_id"], name: "index_organization_links_on_bing_id"
    t.index ["organization_id"], name: "index_organization_links_on_organization_id"
    t.index ["url"], name: "index_organization_links_on_url"
  end

  create_table "organization_webservers", force: :cascade do |t|
    t.string "server_type"
    t.integer "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_organization_webservers_on_organization_id"
  end

  create_table "organizations", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "street", limit: 255
    t.string "street2", limit: 255
    t.string "postalcode", limit: 255
    t.string "state", limit: 255
    t.string "phone1", limit: 255
    t.string "phone2", limit: 255
    t.text "competitors"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url", limit: 255
    t.string "yahooslug", limit: 255
    t.integer "account_id"
    t.boolean "scheduled"
    t.string "facebook", limit: 255
    t.string "twitter", limit: 255
    t.float "latitude"
    t.float "longitude"
    t.integer "category_id"
    t.integer "country_code_id"
    t.text "reviewers_list"
    t.boolean "gmaps"
    t.string "cat_name", limit: 255
    t.integer "city_id"
    t.string "city", limit: 255
    t.point "geopoint"
    t.float "loc", array: true
    t.string "email"
    t.index ["account_id"], name: "account_id_idx"
    t.index ["cat_name"], name: "index_organizations_on_cat_name"
    t.index ["category_id"], name: "index_organizations_on_category_id"
    t.index ["country_code_id"], name: "index_organizations_on_country_code_id"
    t.index ["gmaps"], name: "index_organizations_on_gmaps"
    t.index ["postalcode"], name: "index_organizations_on_postalcode"
    t.index ["scheduled"], name: "index_organizations_on_scheduled"
  end

  create_table "organizations_twitter_urls", id: false, force: :cascade do |t|
    t.integer "organization_id", null: false
    t.integer "twitter_url_id", null: false
  end

  create_table "plans", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.decimal "price", precision: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_plans_on_name"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "organization_id"
    t.string "title"
    t.string "author"
    t.datetime "published"
    t.string "synopsis"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.index ["organization_id"], name: "index_posts_on_organization_id"
  end

  create_table "provider_slugs", id: :serial, force: :cascade do |t|
    t.integer "content_provider_id"
    t.integer "organization_id"
    t.string "slug", limit: 255
    t.boolean "bad"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_provider_id"], name: "index_provider_slugs_on_content_provider_id"
    t.index ["organization_id"], name: "index_provider_slugs_on_organization_id"
  end

  create_table "proxies", id: :serial, force: :cascade do |t|
    t.string "ip", limit: 255
    t.string "port", limit: 255
    t.boolean "tested"
    t.boolean "bad"
    t.string "country", limit: 255
    t.datetime "last_used"
    t.integer "content_provider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "public_keywords", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchases", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratings", id: :serial, force: :cascade do |t|
    t.integer "ratingcount"
    t.float "rating"
    t.integer "content_provider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "organization_id"
  end

  create_table "recommendations", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "description", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "kind"
  end

  create_table "reseller_categories", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "description", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reseller_commissions", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "percentage"
    t.string "notes", limit: 255
    t.integer "reseller_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reseller_id"], name: "index_reseller_commissions_on_reseller_id"
  end

  create_table "resellers", id: :serial, force: :cascade do |t|
    t.string "company", limit: 255
    t.string "name", limit: 255
    t.string "first_name", limit: 255
    t.string "street", limit: 255
    t.string "street2", limit: 255
    t.string "city", limit: 255
    t.string "state", limit: 255
    t.string "postalcode", limit: 255
    t.integer "reseller_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sub_domain", limit: 255
    t.string "logo", limit: 255
    t.integer "country_code_id"
    t.string "email", limit: 255
    t.string "website", limit: 255
    t.string "twitter", limit: 255
    t.string "facebook", limit: 255
    t.string "phone", limit: 255
    t.index ["sub_domain"], name: "index_resellers_on_sub_domain"
  end

  create_table "resellers_users", id: false, force: :cascade do |t|
    t.integer "reseller_id", null: false
    t.integer "user_id", null: false
  end

  create_table "reviewers", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "content_provider_id"
    t.string "slug", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "imageurl", limit: 255
    t.integer "review_count"
    t.float "average_review"
    t.index ["content_provider_id"], name: "index_reviewers_on_content_provider_id"
    t.index ["name"], name: "index_reviewers_on_name"
    t.index ["slug"], name: "index_reviewers_on_slug"
  end

  create_table "reviewers_reviews", id: false, force: :cascade do |t|
    t.integer "reviewer_id"
    t.integer "review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", id: :serial, force: :cascade do |t|
    t.integer "organization_id"
    t.integer "content_provider_id"
    t.string "reviewer", limit: 255
    t.string "reviewer_slug", limit: 255
    t.date "review_date"
    t.text "body"
    t.float "rating"
    t.boolean "processed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reviewer_id"
    t.string "review_provider_id", limit: 255
    t.string "title", limit: 255
    t.string "review_url", limit: 255
    t.index "to_tsvector('english'::regconfig, body)", name: "review_body", using: :gin
    t.index ["rating"], name: "rating_idx"
    t.index ["review_url"], name: "index_reviews_on_review_url"
    t.index ["reviewer_id"], name: "index_reviews_on_reviewer_id"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "resource_id"
    t.string "resource_type", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "schedules", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "description", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "organization_id"
    t.integer "sequence_id"
    t.boolean "in_progress"
    t.datetime "scheduled"
    t.string "payload", limit: 255
    t.index ["in_progress"], name: "index_schedules_on_in_progress"
    t.index ["organization_id"], name: "index_schedules_on_organization_id"
    t.index ["scheduled"], name: "index_schedules_on_scheduled"
    t.index ["sequence_id"], name: "index_schedules_on_sequence_id"
  end

  create_table "sentiment", id: :bigint, default: nil, force: :cascade do |t|
    t.bigint "version", null: false
    t.string "language", limit: 255, null: false
    t.float "value", null: false
    t.string "word", limit: 255, null: false
  end

  create_table "sentiments", id: :serial, force: :cascade do |t|
    t.string "word", limit: 255
    t.string "language", limit: 2
    t.float "value"
    t.string "position", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "tested"
    t.boolean "correct"
    t.index ["correct"], name: "index_sentiments_on_correct"
    t.index ["language"], name: "language_idx"
    t.index ["tested"], name: "index_sentiments_on_tested"
    t.index ["word", "language"], name: "word_language_mm_idx", unique: true
    t.index ["word"], name: "word_idx"
  end

  create_table "sequence_items", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "description", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sequence_items_sequences", id: false, force: :cascade do |t|
    t.integer "sequence_item_id"
    t.integer "sequence_id"
  end

  create_table "sequences", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "description", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", id: :serial, force: :cascade do |t|
    t.string "session_id", limit: 255, null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id"
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "spatial_ref_sys", primary_key: "srid", id: :integer, default: nil, force: :cascade do |t|
    t.string "auth_name", limit: 256
    t.integer "auth_srid"
    t.string "srtext", limit: 2048
    t.string "proj4text", limit: 2048
  end

  create_table "subscriptions", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "plan_id"
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "targets", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "street", limit: 255
    t.string "postalcode", limit: 255
    t.string "phone", limit: 255
    t.string "city", limit: 255
    t.string "state", limit: 255
    t.string "url", limit: 255
    t.integer "reviews"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category", limit: 255
    t.index ["category"], name: "index_targets_on_category"
  end

  create_table "task_results", id: :serial, force: :cascade do |t|
    t.integer "organization_id"
    t.integer "task_id"
    t.boolean "relevant"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_task_results_on_organization_id"
    t.index ["relevant"], name: "index_task_results_on_relevant"
    t.index ["status"], name: "index_task_results_on_status"
    t.index ["task_id"], name: "index_task_results_on_task_id"
  end

  create_table "task_translations", id: :serial, force: :cascade do |t|
    t.integer "task_id"
    t.integer "language_id"
    t.string "header", limit: 255
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language_id"], name: "index_task_translations_on_language_id"
    t.index ["task_id"], name: "index_task_translations_on_task_id"
  end

  create_table "tasks", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "weight"
    t.index ["name"], name: "index_tasks_on_name"
  end

  create_table "timer_options", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "description", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topology", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.integer "srid", null: false
    t.float "precision", null: false
    t.boolean "hasz", default: false, null: false
    t.index ["name"], name: "topology_name_key", unique: true
  end

  create_table "tracks", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_tracks_on_name"
  end

  create_table "tweets", id: :bigint, default: nil, force: :cascade do |t|
    t.integer "keyword_id"
    t.bigint "twitter_user_id", null: false
    t.string "twitter_user_name", limit: 255
    t.json "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "followers_count"
    t.integer "favorite_count"
    t.integer "retweet_count"
    t.decimal "sentiment"
    t.string "lang", limit: 255
    t.index "to_tsvector('simple'::regconfig, (body ->> 'text'::text))", name: "tweets_body_search_idx", using: :gin
    t.index ["created_at"], name: "created_at_idx_tw"
    t.index ["favorite_count"], name: "index_tweets_on_favorite_count"
    t.index ["followers_count"], name: "index_tweets_on_followers_count"
    t.index ["keyword_id"], name: "index_tweets_on_keyword_id"
    t.index ["sentiment"], name: "index_tweets_on_sentiment"
    t.index ["twitter_user_id"], name: "index_tweets_on_twitter_user_id"
    t.index ["twitter_user_name"], name: "index_tweets_on_twitter_user_name"
  end

  create_table "twitter_analytics", id: :serial, force: :cascade do |t|
    t.integer "api_partner_id"
    t.integer "campaign_id"
    t.datetime "from"
    t.datetime "to"
    t.json "results"
    t.integer "analytics_range_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["analytics_range_id"], name: "index_twitter_analytics_on_analytics_range_id"
    t.index ["api_partner_id"], name: "index_twitter_analytics_on_api_partner_id"
    t.index ["campaign_id"], name: "index_twitter_analytics_on_campaign_id"
    t.index ["from"], name: "index_twitter_analytics_on_from"
    t.index ["to"], name: "index_twitter_analytics_on_to"
  end

  create_table "twitter_app_credentials", id: :serial, force: :cascade do |t|
    t.integer "api_partner_id"
    t.string "consumer_key", limit: 255
    t.string "consumer_secret", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["api_partner_id"], name: "index_twitter_app_credentials_on_api_partner_id"
  end

  create_table "twitter_counts", id: :serial, force: :cascade do |t|
    t.integer "twitter_url_id"
    t.integer "followers"
    t.integer "following"
    t.integer "tweets"
    t.integer "listed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["twitter_url_id"], name: "index_twitter_counts_on_twitter_url_id"
  end

  create_table "twitter_credentials", id: :serial, force: :cascade do |t|
    t.integer "account_id"
    t.string "c_user_id", limit: 255
    t.string "oauth_token", limit: 255
    t.string "oauth_secret", limit: 255
    t.datetime "expires"
    t.string "organization_id", limit: 255
    t.string "twitter_id", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["account_id"], name: "index_twitter_credentials_on_account_id"
  end

  create_table "twitter_tracks", id: :serial, force: :cascade do |t|
    t.integer "account_id"
    t.text "tracks"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["account_id"], name: "index_twitter_tracks_on_account_id"
  end

  create_table "twitter_urls", id: :serial, force: :cascade do |t|
    t.string "url", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uptime_monitors", id: :serial, force: :cascade do |t|
    t.integer "organization_id"
    t.float "load_time"
    t.datetime "time_stamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url", limit: 255
    t.index ["organization_id"], name: "index_uptime_monitors_on_organization_id"
    t.index ["time_stamp"], name: "index_uptime_monitors_on_time_stamp"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "account_id"
    t.string "api_key", limit: 255
    t.string "name", limit: 255
    t.integer "reseller_id"
    t.boolean "is_reseller"
    t.integer "referred_by"
    t.string "authentication_token", limit: 255
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["api_key"], name: "index_users_on_api_key"
    t.index ["authentication_token"], name: "index_users_on_authentication_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["is_reseller"], name: "index_users_on_is_reseller"
    t.index ["referred_by"], name: "index_users_on_referred_by"
    t.index ["reseller_id"], name: "index_users_on_reseller_id"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  create_table "versions", id: :serial, force: :cascade do |t|
    t.string "item_type", limit: 255, null: false
    t.integer "item_id", null: false
    t.string "event", limit: 255, null: false
    t.string "whodunnit", limit: 255
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "web_contents", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "job_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_web_contents_on_job_id"
    t.index ["user_id"], name: "index_web_contents_on_user_id"
  end

  create_table "work_queues", id: :serial, force: :cascade do |t|
    t.integer "schedule_id"
    t.integer "retry_count"
    t.string "queue_name", limit: 255
    t.string "url", limit: 255
    t.integer "org_id"
    t.string "content_provider", limit: 255
    t.string "keywords", limit: 255
    t.string "misc", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "invisible"
    t.index ["content_provider"], name: "index_work_queues_on_content_provider"
    t.index ["invisible"], name: "index_work_queues_on_invisible"
    t.index ["org_id"], name: "index_work_queues_on_org_id"
    t.index ["queue_name"], name: "index_work_queues_on_queue_name"
    t.index ["retry_count"], name: "index_work_queues_on_retry_count"
    t.index ["schedule_id"], name: "index_work_queues_on_schedule_id"
  end

  create_table "youtube_videos", id: :serial, force: :cascade do |t|
    t.integer "keyword_id"
    t.integer "duration"
    t.boolean "widescreen"
    t.boolean "noembed"
    t.integer "position"
    t.boolean "safe_search"
    t.string "video_id", limit: 255
    t.datetime "published_at"
    t.datetime "updated_at"
    t.datetime "uploaded_at"
    t.datetime "recorded_at"
    t.json "categories"
    t.json "keywords"
    t.string "description", limit: 255
    t.string "title", limit: 255
    t.string "html_content", limit: 255
    t.json "thumbnails"
    t.string "player_url", limit: 255
    t.integer "view_count"
    t.integer "favorite_count"
    t.datetime "created_at"
    t.index ["keyword_id"], name: "index_youtube_videos_on_keyword_id"
    t.index ["video_id"], name: "index_youtube_videos_on_video_id"
  end

  add_foreign_key "layer", "topology", name: "layer_topology_id_fkey"
end
