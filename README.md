# ModelLog

It's designed to be used to record all changes of the models to a log file for Rails. You can also use it to record who made the changes.

## Supported Versions

- Ruby 2.0.0+
- Rails 3.0.0+

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
  config.current_user_method    = :current_manager     # default: :current_user
  config.identity_field         = :username            # default: :id
  config.separator              = ' '                  # default: "\t"
  config.logger_datetime_format = '%Y-%m-%d %H:%M:%S'
end
```

## Custom Log Formatter

There are default log formatter. You can also custom them here. For example:

```ruby
# config/initializers/model_log.rb
class Myformatter
  include ModelLog::Helpers::Context
  # Some methods are provided here. You can use them directly.
  # current_user    The information about the current user, which could be nil.
  # requester       The infomation about the current network request, which could be nil.
  # resource        Current resource.
  # changes         The changes to the current resource.
  # changed?        Whether the current resource has been changed.
  # action          update|create|destroy
  # is_update?      If the action is update.
  # is_create?      If the action is create.
  # is_destroy?     If the action is destroy.

  def call
    return unless changed?
    content = []
    content += requester_content if requester
    content += user_content if current_user
    content += resource_content
    content.join(' ')
  end

  private

  def user_content
    [
      current_user.id,
      current_user.username
    ]
  end

  def requester_content
    [
      requester.request_method,
      requester.url,
    ]
  end

  def resource_content
    [
      changes
    ]
  end
end

ModelLog.configure do |config|
  config.formatter = MyFormatter
end
```

## Copyright

Copyright (c) 2018- jk-sun. See LICENSE.tet for further details.
