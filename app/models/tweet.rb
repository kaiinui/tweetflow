class Tweet
  def self.search(query)
    @search = Tweet.client.search(query, :result_type => "recent").take(20).map {|t| t.text.gsub(/http\:\/\/t\.co\/[1-9a-zA-Z]*/, "")}
  end

  def self.client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = "mXcGZLKYbVoCisebgD2bCHcVX"
      config.consumer_secret = "d07TH8JuTVJgBLOcVyJwCyT0dxw2av88Y6qnPrB09FgidnDKc3"
    end
  end
end