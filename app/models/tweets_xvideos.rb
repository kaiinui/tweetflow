require 'aws-sdk'
require 'dynamoid'

AWS.config({
               :access_key_id => 'AKIAIKGYCMXWX2MW4CRQ',
               :secret_access_key => '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',
               :dynamo_db_endpoint => 'dynamodb.ap-southeast-1.amazonaws.com'
           })

Dynamoid.configure do |config|
  config.adapter = 'aws_sdk' # This adapter establishes a connection to the DynamoDB servers using Amazon's own AWS gem.
  config.warn_on_scan = true # Output a warning to the logger when you perform a scan rather than a query on a table.
  config.partitioning = true # Spread writes randomly across the database. See "partitioning" below for more.
  config.partition_size = 200  # Determine the key space size that writes are randomly spread across.
  config.read_capacity = 100 # Read capacity for your tables
  config.write_capacity = 20 # Write capacity for your tables
end

class TweetsXvideos
  include Dynamoid::Document
  table :name => :tweets_xvideos

  field :text
  field :urls, :set
  field :user_name
  field :user_id
  field :user_description
  field :user_follower, :integer
  field :user_created_at, :datetime
  field :hashtags, :set
  field :created_at, :datetime
  field :lang

  def self.new_with_tweet_object(object)
    hash = object.to_h
    tweet = TweetsXvideos.new
    tweet.text = hash[:text]
    tweet.urls = hash[:entities][:urls].map {|url| url[:expanded_url]} if hash[:entities][:urls]
    tweet.user_name = hash[:user][:name]
    tweet.user_id = hash[:user][:screen_name]
    tweet.user_description = hash[:user][:description]
    tweet.user_follower = hash[:user][:followers_count]
    tweet.user_created_at = hash[:user][:created_at]
    tweet.hashtags = hash[:entities][:hashtags].map {|hashtag| hashtag[:text]} if hash[:entities] and hash[:entities][:hashtags]
    tweet.created_at = hash[:created_at]
    tweet.lang = hash[:lang]
    tweet.save
  end
end