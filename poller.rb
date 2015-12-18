require 'config_env'
require 'aws-sdk'

ConfigEnv.path_to_config("#{__dir__}/config/config_env.rb")
sqs = Aws::SQS::Client.new()

poller = Aws::SQS::QueuePoller.new(ENV['QUEUE_URL'])

poller.poll(wait_time_seconds:20) do |msg|
  puts msg.body
end
