require 'config_env'
require 'aws-sdk'

ConfigEnv.path_to_config("#{__dir__}/config/config_env.rb")
sqs = Aws::SQS::Client.new()

q_url = sqs.get_queue_url(queue_name: 'Kiwi_messenger').queue_url

msg = {results: 'Hello World at' + Time.now.to_s}

resp = sqs.send_message({
  queue_url: q_url, # required
  message_body: msg.to_json # required
})

if resp.successful?
  puts 'successful'
else
  puts 'failed'
end
