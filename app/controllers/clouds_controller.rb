class CloudsController < ApplicationController

  rescue_from Twitter::Error::NotFound, Twitter::Error::ClientError, Twitter::Error::BadGateway, :with => :http_404
  @@exclusion_list = YAML.load(File.open(File.join(Rails.root, 'config', 'exclude_phrases')))

  def index
    redirect_to root_path
  end

  def create
    if params['cloud']
      #Strategy: Use cursoring to extract desired number of tweets.
      #Then based on preference, send json for visualization.
      @tweets = fetch_tweets
      @tweets_hash = Hash.new(0)
      @tweets_hash = frequency_or_count_hash(params['cloud']['type'], @tweets)
      gon.tweets = @tweets_hash if @tweets_hash
      @image_url = Twitter.user(params['cloud']['twitter_handle']).profile_image_url

      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def fetch_tweets
    tweets = Array.new
    last_tweet_id = nil
    not_to_iterate_again = false
    20.times do
      unless last_tweet_id.nil?
        @tweets_round = Twitter.user_timeline(params['cloud']['twitter_handle'], :exclude_replies => true, :count => 100, :max_id => last_tweet_id)
      else
        @tweets_round = Twitter.user_timeline(params['cloud']['twitter_handle'], :exclude_replies => true, :count => 100)
      end
      last_tweet_id = @tweets_round.last.id if @tweets_round.last
      @tweets_round.map(&:text).each do |tweet|
        if tweets.count != params['cloud']['tweets_count'].to_i
          tweets.push(tweet.strip)
        else
          not_to_iterate_again = true
          break
        end
      end
      break if not_to_iterate_again
    end
    tweets
  end


  def frequency_or_count_hash(choice, tweets)
    @tweet_hash = Hash.new(0)
    if choice.eql?('frequency')
      @tweets = tweets.map { |x| x.split.count }
      @tweets_count = @tweets.count

      if @tweets
        @tweets.each { |tweet| @tweets_hash[tweet] += 1 }
        @tweets_hash = @tweets_hash.sort_by { |k, v| v }.reverse
      end

    else
      @tweets_count = @tweets.count
      @tweets = @tweets.map { |x| x.split.map(&:capitalize) }.flatten
      @@exclusion_list.each { |word| @tweets.delete(word) }
      @tweets.each { |tweet| @tweets_hash[tweet] += 1 }
      @tweets_hash = @tweets_hash.sort_by { |k, v| v }.reverse
    end
    @tweets_hash
  end


  def http_404
    render 'home_pages/not_found', :status => 404
  end
end

