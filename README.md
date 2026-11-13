# any_mail_finder

An unofficial Ruby client for the [Anymailfinder](https://anymailfinder.com/) API: find a person's or a company's
email addresses and check whether an address is valid.

Every call returns the API's JSON as a nested struct, so you read fields with dot syntax (`response.email`).

> Not affiliated with Anymailfinder. The gem is at version 0.1.0 and its tests are minimal.

## Install

```ruby
gem 'any_mail_finder'
```

Then `bundle`, or `gem install any_mail_finder`. The gem uses `httparty` and `recursive-open-struct`, and expects
ActiveSupport to be loaded (any Rails app has it).

## Configure

In a Rails app, `config/initializers/any_mail_finder.rb`:

```ruby
AnyMailFinder.configure do |config|
  config.api_key = ENV.fetch("ANYMAILFINDER_API_KEY")
end
```

Keep the key in an environment variable or your credentials store, never in the repository.

## Use

### Account and API status

```ruby
AnyMailFinder::Health.new.execute      # => response.healthy, response.status
AnyMailFinder::HitsLeft.new.execute    # => response.credits_left, response.status
```

### Find one person's email

Give a `domain` (better results) or a `company_name`, and either a `full_name` or both `first_name` and `last_name`.

```ruby
person = AnyMailFinder::Person.new(full_name: "John Doe", domain: "example.com")
response = person.find_email

response.email          # => "jdoe@example.com"
response.email_class    # => "verified"
response.alternatives   # => ["john@example.com", "doej@example.com"]
response.status         # => "success"
```

You can also set the fields one at a time (`person.first_name = "John"`) before calling `find_email`.

### Find all emails at a company

A `domain` or a `company_name` is required.

```ruby
response = AnyMailFinder::Company.new(domain: "example.com").find_emails

response.emails         # => ["john@example.com", "mark@example.com"]
response.email_class    # => "not_verified"
```

### Check an email address

```ruby
response = AnyMailFinder::Email.new("johndoe@example.com").validate

response.email_verified # => true
```

### Check what the API knows about a domain

`Domain` is not loaded by default, so require it first. It takes the domain as a string:

```ruby
require "any_mail_finder/domain"

response = AnyMailFinder::Domain.new("example.com").execute

response.is_blacklisted # => false
response.person_search  # => true
response.domain_search  # => true
response.domain_count   # => 3
```

## Errors

Network and API failures raise `AnyMailFinder::Error` with the underlying message.

## Development

```
bin/setup        # install dependencies
bundle exec rake spec
bin/console      # a console with the gem loaded
```

Releases: bump `lib/any_mail_finder/version.rb`, then `bundle exec rake release`.

## Contributing

Bug reports and pull requests are welcome at https://github.com/mohitjain/any_mail_finder. Contributors are expected
to follow the [Code of Conduct](CODE_OF_CONDUCT.md).

## License

[MIT](LICENSE.txt).
