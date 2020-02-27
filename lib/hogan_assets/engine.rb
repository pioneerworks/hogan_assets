module HoganAssets
  class Engine < ::Rails::Engine
    initializer "sprockets.hogan", :group => :all do |app|
      HoganAssets::Config.load_yml! if HoganAssets::Config.yml_exists?
      Rails.application.config.assets.configure do |env|
        HoganAssets::Config.template_extensions.each do |ext|

          mime_type = 'application/javascript'
          extension = ".#{ext}"

          if env.respond_to?(:register_transformer)
            env.register_mime_type mime_type, extensions: [extension]
            env.register_preprocessor mime_type, Tilt
          elsif env.respond_to?(:register_engine)
            args = [extension, Tilt]
            args << { mime_type: mime_type, silence_deprecation: true } if Sprockets::VERSION.start_with?("3")
            env.register_engine(*args)
          end
        end
      end
    end
  end
end
