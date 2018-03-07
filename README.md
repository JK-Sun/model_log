# ModelLog

User operation data saves log files and records user information.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'model_log'
```

And then execute:

    $ bundle

## Usage

Simply call `model_log` on your models:

```ruby
class User < ActiveRecord::Base
  model_log
end
```

## Log Path

The log is saved in the `log/` section of your rails app.

The development environment file is called `model_log_development.log`.

The product environment file is called `model_log_product.log`.

## Current User Tracking

If you're using ModelLog in a Rails application, all audited changes made within a request will automatically be attributed to the current user. By default, ModelLog uses the `current_passport` method in your controller.

The username field default to `username`.

To use a method other than `current_passport` and a field other than `username`, put the following in an initializer:

```ruby
# config/initializers/model_log.rb

ModelLog.current_user_method = :current_user
ModelLog.user_name_field = :name
```

## Other Settings

If you have multiple platforms, and the tag data changes belong to that platform, put the following in an initializer:

```ruby
# config/initializers/model_log.rb

ModelLog.platform = :CPM
```

## Gem Update

If you want to update the gem, run:

    $ bundle update model_log

