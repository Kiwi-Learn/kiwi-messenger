require 'config_env'
require 'aws-sdk'

ConfigEnv.path_to_config("#{__dir__}/config/config_env.rb")
sqs = Aws::SQS::Client.new()

resp = sqs.send_message({
  queue_url: ENV['QUEUE_URL'], # required
  message_body: 'Hello World at' + Time.now.to_s # required
})

if resp.successful?
  puts 'successful'
else
  puts 'failed'
end
