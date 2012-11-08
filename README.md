# is_publishable

Adds publishing capabilities to a model.  Supports marking a model as published/unpublished as well as publishing models in the future.

## Installation

Add this line to your application's Gemfile:

    gem 'is_publishable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install is_publishable

## Usage

To add publishing to a model, first run the generator. Let's assume the model's name is Article

    $ rails generate publishable Article

This will create the following migration:

    class AddPublishingToArticles < ActiveRecord::Migration
      def up
        add_column :articles, :published, :boolean, default: false
        add_column :articles, :published_at, :datetime
      end
      def down
        remove_column :articles, :published
        remove_column :articles, :published_at
      end 
    end

After this, simply add `publishable` to your model (be sure to add published and published_at to your attr_accessible)

    class Article < ActiveRecord::Base
      attr_accessible ...
      publishable
    end

After this, when you first mark an Article as published and published_at is not set, published_at will automatically be set to now.  If published_at is already set, it will not be changed.

### Scopes

* published -- returns all Article that published=true and published_at is a date in the past
* unpublished -- returns all Articles that are published=false or published=true and published_at is a date in the future


### Instance Methods

* published? -- returns true if published=true and published_at is a date in the past
* unpublished? -- returns true if published=false or published=true and published_at is a date in the future


## TODO

* Write tests for generator

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
