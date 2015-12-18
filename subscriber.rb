require 'config_env'
require 'aws-sdk'

ConfigEnv.path_to_config("#{__dir__}/config/config_env.rb")
sqs = Aws::SQS::Client.new()

resp = sqs.receive_message({queue_url: ENV['QUEUE_URL']})

if not resp.messages.empty?
  sqs.delete_message({
    queue_url: ENV['QUEUE_URL'],
    receipt_handle: resp.messages[0].receipt_handle
  })
  puts 'pop out message: ' + resp.messages[0].body
else
  puts 'SQS is empty!'
end
