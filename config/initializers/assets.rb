Rails.application.config.assets.version = (ENV["ASSETS_VERSION"] || "1.0")
Rails.application.config.assets.precompile += %w( jquery.js )
Rails.application.config.assets.precompile += %w( singapore_lion.png )
Rails.application.config.assets.precompile += %w( hive-logo.png )
