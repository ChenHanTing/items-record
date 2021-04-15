require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Template
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.assets.initialize_on_precompile = false

    # 設定 slim 為預設模板
    config.generators do |g|
      g.template_engine :slim
    end

    # 設定語系與時區
    config.i18n.default_locale = 'zh-TW'
    config.time_zone = 'Taipei'

    # 寄信方式的選項包括有:test、:sendmail和smtp三種可以選擇。
    #
    # sendmail是使用伺服器的/usr/bin/sendmail程式，不過因為因為不是每台伺服器都有適當安裝sendmail。
    # test代表並不會實際寄信出去，而是存在ActionMailer::Base.deliveries陣列中方便做自動化測試。
    #
    ActionMailer::Base.smtp_settings = {
      :port           => 587,
      :address        => 'smtp.sendgrid.net',
      :user_name      => '<USERNAME>',
      :password       => '<PASSWORD>',
      :domain         => 'smtp.sendgrid.net',
      :authentication => :plain,
      :enable_starttls_auto => true
    }
  end
end
