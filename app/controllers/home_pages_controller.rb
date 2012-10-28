class HomePagesController < ApplicationController

  # def create
  #   @tweets = Twitter.user_timeline(params['twitter']['handle'], :exclude_replies => true, :count => 200).map{ |x| x.text }.map{ |y| y.split.count }
  #   @tweets_hash = Hash.new(0)
  #   if @tweets
  #     @tweets.each { |tweet| @tweets_hash[tweet] += 1 }
  #     @tweets_hash = @tweets_hash.sort_by{ |k, v| v}.reverse
  #   end

  #   respond_to do |format|
  #     format.html { redirect_to home_pages_path }
  #   end
  # end

  def index
    if params['twitter']
      @tweets = Twitter.user_timeline(params['twitter']['handle'], :exclude_replies => true, :count => 200).map{ |x| x.text }.map{ |y| y.split.count }
      @tweets_hash = Hash.new(0)
      if @tweets
        @tweets.each { |tweet| @tweets_hash[tweet] += 1 }
        @tweets_hash = @tweets_hash.sort_by { |k, v| v}.reverse
        hash = @tweets_hash.inject(Hash.new) { |hash, arr| hash[arr[0]] = arr[1]; hash }.to_json
        gon.hash = hash
      end

    end
  end

  def about
  end
end
