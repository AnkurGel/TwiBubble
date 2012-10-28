class CloudsController < ApplicationController

  rescue_from Twitter::Error::NotFound, Twitter::Error::ClientError, :with => :http_404

  def create
    if params['cloud']
      @tweets = Twitter.user_timeline(params['cloud']['twitter_handle'], :exclude_replies => true, :count => 200).map(&:text).map{ |y| y.split.count }
      @tweets_hash = Hash.new(0)
      if @tweets
        @tweets.each { |tweet| @tweets_hash[tweet] += 1 }
        @tweets_hash = @tweets_hash.sort_by { |k, v| v}.reverse
        gon.tweets = @tweets_hash
      end
    end
  end


  def http_404
    render 'home_pages/not_found', :status => 404
  end
end
