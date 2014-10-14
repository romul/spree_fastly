namespace :spree_fastly do
  desc "Call #purge_all for all cached models"
  task :purge_all => :environment do
    Spree::Fastly::Config.purge_all!
    puts "Done!"
  end
end