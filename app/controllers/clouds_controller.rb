class CloudsController < ApplicationController

  rescue_from Twitter::Error::NotFound, Twitter::Error::ClientError, Twitter::Error::BadGateway, :with => :http_404

  def create
    if params['cloud']
      @tweets = Array.new
      @tweet_2 = Array.new
      last_tweet_id = nil
      10.times do
        unless last_tweet_id.nil?
          @tweets_round = Twitter.user_timeline(params['cloud']['twitter_handle'], :exclude_replies => true, :count => 100, :max_id => last_tweet_id)
        else
          @tweets_round = Twitter.user_timeline(params['cloud']['twitter_handle'], :exclude_replies => true, :count => 100)
        end
        last_tweet_id = @tweets_round.last.id
        @tweets_round.map(&:text).each { |tweet| @tweets.push(tweet.strip.split.count) }
      end
#      @tweets = Twitter.user_timeline(params['cloud']['twitter_handle'], :exclude_replies => true, :count => 200).map(&:text).map{ |y| y.split.count }
      # @tweets = @tweets.join(' ').gsub('#', '').split.map(&:capitalize)
      @tweets_count = @tweets.count
      @tweets_hash = Hash.new(0)
      if @tweets
        @tweets.each { |tweet| @tweets_hash[tweet] += 1 }
        @tweets_hash = @tweets_hash.sort_by { |k, v| v}.reverse
        gon.tweets = @tweets_hash
      end
      respond_to do |format|
        format.html
        format.js
      end
    end
  end


  def http_404
    render 'home_pages/not_found', :status => 404
  end
end
