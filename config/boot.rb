ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
require "dotenv"

dotenv_root = File.expand_path("../../", __FILE__)
dotenv_env = ENV.fetch("RAILS_ENV", ENV.fetch("RACK_ENV", "development"))
dotenv_files = ["#{dotenv_root}/.env.#{dotenv_env}", "#{dotenv_root}/.env"]

if ENV.include? "DOTENV_LOADED"
  ENV["DOTENV_LOADED"].split(":").each do |key|
    ENV.delete(key)
  end
end

dotenv_loaded = Dotenv.load(*dotenv_files)

ENV["DOTENV_LOADED"] = dotenv_loaded.keys.join(":")