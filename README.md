###A disabled version of C0elevation.com
_replace zero with 'o' for true site url_  
Sole designer and developer, as well as co-founder.  
Last contribution: August 2014.

###App Setup
Ruby version - 2.0.0
Rails - 4.0

1. Use correct Ruby version

```ruby
$ rvm use 2.0.0
```


2. Get imageMagick

```ruby
$ brew install imagemagick
```

3. Run bundle

```ruby
$ bundle install
```

4. Create a database
  1 Set up with PostgresqlApp 9.2
  2 brew install pg
  3 configure database.yml
  4 rake db:setup

5. Manually Transfer:
  1 Initializers: stripe.rb
  2 Database.yml
