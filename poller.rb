require 'config_env'
require 'aws-sdk'

ConfigEnv.path_to_config("#{__dir__}/config/config_env.rb")
sqs = Aws::SQS::Client.new()

poller = Aws::SQS::QueuePoller.new(ENV['QUEUE_URL'])

# loop to get messages sequentially (message invisible to other subscribers)
# wait_time_seconds: how long to wait before requesting next message 
# idle_timeout: if no more messages, how long to wait until exiting loop

begin
  poller.poll(wait_time_seconds:nil, idle_timeout:5) do |msg|
    puts msg.body
  end
rescue AWS::SQS::Error::ServiceError
end
