# RailsAdminComments DEVELOPMENT VERSION

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/rails_admin_comments`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_admin_comments'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_admin_comments

## Usage

Add in model what you need to be commentable

```ruby
  include RailsAdminComments::Commentable # comments for objects
  include RailsAdminComments::ModelCommentable # comments for model (from v.0.2.0)
```

And add action available for this model_name

```ruby
  comments do
    visible do
      [
        "SomeModel"
      ].include? bindings[:abstract_model].model_name
    end
  end

  # from v.0.2.0
  model_comments do
    visible do
      [
        "SomeModel"
      ].include? bindings[:abstract_model].model_name
    end
  end
```

Also you need to add method name_for_rails_admin_comments for user model_name

```ruby
  def name_for_rails_admin_comments
    #some code
  end
```

It's temporary decision. Will be removed!


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/red-rocks/rails_admin_comments.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
