# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( scripts.css scripts.js )
Rails.application.config.assets.precompile += %w( concepts.css concepts.js)
Rails.application.config.assets.precompile += %w( quizzes.css quizzes.js)
Rails.application.config.assets.precompile += %w( lists.css lists.js)
Rails.application.config.assets.precompile += %w( prompts.css prompts.js )
Rails.application.config.assets.precompile += %w( organizations.css organizations.js)
Rails.application.config.assets.precompile += %w( frontpage.js frontpage.css)
Rails.application.config.assets.precompile += %w( subscriptions.css subscriptions.js )
Rails.application.config.assets.precompile += %w( results.css results.js )
Rails.application.config.assets.precompile += %w( answers.js  answers.css)
Rails.application.config.assets.precompile += %w( apps.js  apps.css)
Rails.application.config.assets.precompile += %w( country_codes.css  country_codes.js)
Rails.application.config.assets.precompile += %w( registrations.css  registrations.js)
Rails.application.config.assets.precompile += %w( employees.css  employees.js)
Rails.application.config.assets.precompile += %w( questions.css  questions.js)
Rails.application.config.assets.precompile += %w( home.css  home.js)
Rails.application.config.assets.precompile += %w( home_page.css  home_page.js)
Rails.application.config.assets.precompile += %w( companies.js companies.css)
Rails.application.config.assets.precompile += %w( new_frontpage.js new_frontpage.css)