module SpreeBanner
  class Engine < Rails::Engine
    engine_name 'spree_banner'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer 'spree_banner.preferences', :before => :load_config_initializers do |app|
      SpreeBanner::Config = Spree::BannerConfiguration.new
    end

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end