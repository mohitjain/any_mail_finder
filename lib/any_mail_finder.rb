require_relative "any_mail_finder/version"
require_relative "any_mail_finder/configuration/base"
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


require_relative 'any_mail_finder/clients/base'
require_relative "any_mail_finder/clients/email"
require_relative "any_mail_finder/error"
require "breaker"
