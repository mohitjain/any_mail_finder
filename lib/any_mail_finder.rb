require_relative "any_mail_finder/version"
require_relative "any_mail_finder/configuration/base"
require "httparty"
require "recursive-open-struct"
module AnyMailFinder
  def self.configuration
    @configuration ||= AnyMailFinder::Configuration::Base.new
  end

  def self.configuration=(configuration)
    @configuration = configuration
  end

  def self.configure
    yield configuration if block_given?
  end

  def self.reset
    @configuration = nil
  end
end

require_relative "any_mail_finder/base"
require_relative "any_mail_finder/company"
require_relative "any_mail_finder/email"
require_relative "any_mail_finder/error"
require_relative "any_mail_finder/health"
require_relative "any_mail_finder/hits_left"
require_relative "any_mail_finder/person"
