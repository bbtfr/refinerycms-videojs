module Refinery
  class VideosGenerator < Rails::Generators::Base
    source_root File.expand_path('../videos/templates', __FILE__)

    def rake_db
      rake("refinery_videos:install:migrations")
    end

    def generate_videos_initializer
      template "config/initializers/refinery/videos.rb.erb", File.join(destination_root, "config", "initializers", "refinery", "videos.rb")
    end

    def generate_videojs_loader
      template "assets/javascripts/videojs_loader.js", File.join(destination_root, "app", "assets", "javascripts", "videojs_loader.js")
    end

    def append_load_seed_data
      create_file 'db/seeds.rb' unless File.exists?(File.join(destination_root, 'db', 'seeds.rb'))
      append_file 'db/seeds.rb', :verbose => true do
        <<-EOH

# Added by Refinery CMS VideoJS extension
Refinery::Videos::Engine.load_seed
        EOH
      end
  end
end
