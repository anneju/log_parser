#!/usr/bin/env ruby

# frozen_string_literal: true

require './log_parser/client'

LogParser::Client.new(ARGV[0]).process
