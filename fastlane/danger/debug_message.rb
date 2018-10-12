IS_LOCAL = ENV['IS_LOCAL'] == 'true'
IS_DEBUGGING = false

def debug_message(message)
  message "[Debug] #{message}" if IS_DEBUGGING && IS_LOCAL
end
