require './log_parser/client'

LogParser::Client.new(ARGV[0]).process
