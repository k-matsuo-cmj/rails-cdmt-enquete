require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EnqApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.i18n.default_locale = :ja
    config.time_zone = "Asia/Tokyo"
    # config.eager_load_paths << Rails.root.join("extras")

    # validation
    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      if instance.kind_of? ActionView::Helpers::Tags::Label
        # skip when label
        html_tag.html_safe
      else
        html_fragment = Nokogiri::HTML::DocumentFragment.parse(html_tag)
        html_fragment.children.add_class 'is-invalid'
        name = instance.instance_variable_get(:@method_name)
        error = instance.object.errors.full_messages_for(name).first
        "<div class='has-error'>#{html_fragment.to_s}<span class='invalid-feedback'>#{error}</span></div>".html_safe
      end
    end
  end
end
