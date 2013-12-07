# MultiNotifier

MultiNotifier provides a minimal, modular and adaptable interface for sending notifications in Ruby.
It unifies and distills the API for sending notifications to multiple sources with [middlewares](http://en.wikipedia.org/wiki/Middleware).

## Installation

Add this line to your application's Gemfile:

    gem 'multi_notifier'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install multi_notifier

## Usage

```ruby
MultiNotifier.build do |builder|
  builder.use :mail, :from => "from@owenou.com", :to => "to@owenou.com", :subject => "MultiNotifier notification"
  builder.use :campfire, :access_token => "123", :room => "123", :message => "Hello world"
end.notify_all!
```

## Middlewares

### Mail

The [mail middleware](https://github.com/jingweno/multi_notifier/blob/master/lib/multi_notifier/middlewares/mail.rb) sends email with the provided settings.

```ruby
builder.adapter :mail,
  :delivery => {
    :method => Rails.configuration.action_mailer.delivery_method, # delivery method
    :settings => Rails.configuration.action_mailer.send("#{Rails.configuration.action_mailer.delivery_method}_settings") # deivery settings
  },
  :from => "notifications@aclgrc.com", # from email
  :to => "devs@workpapers.com", # to email
  :subject => "subject", # email subject
  :text_body => mail_text_body, # email body in text
  :html_body => mail_html_body # email body in html
```

### Travis

The [travis middleware](https://github.com/jingweno/multi_notifier/blob/master/lib/multi_notifier/middlewares/travis.rb) restarts the latest build with the provided repo.

```ruby
builder.adapter :travis,
  :access_token => "123", # travis-ci access token
  :repo => "jingweno/multiple_notifier", # travis-ci repo in the format of OWNER/REPO
  :travis_pro => true # whether this repo is built in travis-ci pro
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
