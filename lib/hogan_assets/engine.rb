module HoganAssets
  class Engine < ::Rails::Engine
    initializer 'sprockets.hogan', group: :all do |_app|
      HoganAssets::Config.load_yml! if HoganAssets::Config.yml_exists?
      Rails.application.config.assets.configure do |env|
        HoganAssets::Config.template_extensions.each do |ext|
          env.register_engine(".#{ext}", Tilt, silence_deprecation: true)
        end
      end
    end
  end
end
