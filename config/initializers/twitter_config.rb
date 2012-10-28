#Added app's credentials in YAML and git ignored the file for safety.
#Define the below mentioned variables in secret_credentials.yaml in your Rails.root.
data = YAML.load(File.open(File.expand_path(Rails.root + 'secret_credentials.yaml')))

Twitter.configure do |config|
  config.consumer_key       = data['TWITTER_CONSUMER_KEY']
  config.consumer_secret    = data['TWITTER_CONSUMER_SECRET']
  config.oauth_token        = data['TWITTER_OAUTH_TOKEN']
  config.oauth_token_secret = data['TWITTER_OAUTH_TOKEN_SECRET']
end


