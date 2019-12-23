# ModelLog

It's designed to be used to record all changes of the models to a log file for Rails. You can also use it to record who made the changes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'model_log', '~> 2.0.0'
```

And then execute:

    $ bundle install

## Usage

Simply call `model_log` on your models:

```ruby
class User < ActiveRecord::Base
  model_log
end
```

## Log File Path

The log is saved in the `log/` section of your rails app.

The log in development environment is in `model_log_development.log`.

The log in production environment is in `model_log_production.log`.

## Configure

By default, ModelLog uses the `current_user` method in your controller. The default identity field is `id`.

To use a method other than `current_user` and an identity field other than `id`, put the following in an initializer:

```ruby
# config/initializers/model_log.rb
ModelLog.configure do |config|
  config.current_user_fn = :current_manager     # default: :current_user
  config.identity_field  = :username            # default: :id
  config.separator       = ' '                  # default: "\t"
end
```
