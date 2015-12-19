require 'config_env'
require 'aws-sdk'

ConfigEnv.path_to_config("#{__dir__}/config/config_env.rb")
sqs = Aws::SQS::Client.new()

q_url = sqs.get_queue_url(queue_name: 'Kiwi_messenger').queue_url

resp = sqs.receive_message({queue_url: q_url})
msg = resp.messages.first

if msg
  sqs.delete_message({
    queue_url: q_url,
    receipt_handle: resp.messages[0].receipt_handle
  })
  puts 'pop out message: ' + resp.messages[0].body
else
  puts 'SQS is empty!'
end
