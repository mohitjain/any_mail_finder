# AnyMailFinder

The un-official AnyMailFinder(https://anymailfinder.com/) API Client for Ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'any_mail_finder'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install any_mail_finder

## Usage

Create a configuration file and put it in your initializers config/initializers/any_mail_finder.rb

```ruby
AnyMailFinder.configure do |config|
  config.api_key = "-----Api ----- key -----"
end
```

All response will be nested struct object.

### Check the status of the API

```ruby
  response = AnyMailFinder::Health.new.execute
  #response.healthy => true
  #response.status => "success"
```

### Checking how many searches you have left

```ruby
  response = AnyMailFinder::HitsLeft.new.execute
  #response.credits_left => 5000
  #response.status => "success"
```

### Performing an email search (Personal email)
To perform an email search of a specific person. You can pass the arguments as hash like mentioned below.

>You must provide either a `domain` or a `company_name`. Providing a `domain` will yield better results than a `company_name`.

> You must provide either a `full_name`, or both a `first_name` and a `last_name`.

```ruby
  options = {
    full_name: "John Doe",
    first_name: "John",
    last_name: "Doe",
    domain: "facebook.com",
    company_name: "Facebook",
  }

  person = AnyMailFinder::Person.new(options)
  response = person.find_email

  #response.email => "jsmith@acme.com",
  #response.email_class => "verified",
  #response.alternatives => [ "john@acme.com", "smithj@acme.com" ]
  #response.input.full_name => "John Smith"
  #response.input.company_name => "Acme Inc"  
  #response.domain => "acme.com",
  #response.status => "success"
```
  or also set them one by one

```ruby
  person = AnyMailFinder::Person.new
  person.full_name = "John Doe"
  person.first_name = "John"
  person.last_name = "Doe"
  person.domain = "facebook.com"
  person.company_name = "Facebook"
  response = person.find_email
  #response.email => "jsmith@acme.com",
  #response.email_class => "verified",
  #response.alternatives => [ "john@acme.com", "smithj@acme.com" ]
  #response.input.full_name => "John Smith"
  #response.input.company_name => "Acme Inc"  
  #response.domain => "acme.com",
  #response.status => "success"
```

### Performing an email search (All emails)
To retrieve a list of emails at a particular domain/company

> A domain or a company_name is required.

```ruby
options = {
  domain: "facebook.com",
  company_name: "Facebook",
}

response = AnyMailFinder::Company.new(options).find_emails

#response.emails => ["john@acme.net", "mark@acme.com", "joe@acme.com"],
#response.email_class => "not_verified",
#response.input.domain => "acme.com"
#response.domain => nil
#response.status => "success"

```

or
```ruby
  domain_emails = AnyMailFinder::Company.new
  domain_emails.domain = "facebook.com"
  domain_emails.company_name = "facebook.com"
  #response.emails => ["john@acme.net", "mark@acme.com", "joe@acme.com"],
  #response.email_class => "not_verified",
  #response.input.domain => "acme.com"
  #response.domain => nil
  #response.status => "success"
```

### Validating an email
To validate an email address

```ruby
email = "johndoe@example.com"
response = AnyMailFinder::Email.new(email).validate
#response.email_verified => true
#response.input.email => "johndoe@example.com"
#response.status => "success"
```

or

```ruby
email = "johndoe@example.com"
email_validator = AnyMailFinder::Email.new
email_validator.email = email
response = email_validator.validate
#response.email_verified => true
#response.input.email => "johndoe@example.com"
#response.status => "success"
```

### Check domain status
To check what kind of info we have on a particular domain

```ruby
AnyMailFinder::Domain.new({
  domain: "facebook.com",
})
#response.status => "success"
#response.is_blacklisted => false
#response.person_search => true
#response.domain_search => true
#response.domain_count => 3
#response.input.domain => "acme.com"
```

or

```ruby
domain_check = AnyMailFinder::Domain.new
domain_check.domain = "facebook.com"
domain_check.execute
#response.status => "success"
#response.is_blacklisted => false
#response.person_search => true
#response.domain_search => true
#response.domain_count => 3
#response.input.domain => "acme.com"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/any_mail_finder. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AnyMailFinder project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/any_mail_finder/blob/master/CODE_OF_CONDUCT.md).
