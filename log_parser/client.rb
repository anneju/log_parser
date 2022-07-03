# frozen_string_literal: true

require 'set'
require 'pry'
require_relative './total_count_formatter'
require_relative './uniq_count_formatter'

module LogParser
  class Client
    def initialize(log_file)
      @file_name = log_file
      @logs_total = Hash.new(0)
      @logs_uniq = Hash.new { |h, key| h[key] = Set.new }
    end

    def process
      validate_args

      logs = File.read(@file_name).split("\n")
      return 'No logs to investigate' if logs.empty?

      logs.each do |log|
        page_name, ip = log.split(' ')
        @logs_total[page_name] += 1
        @logs_uniq[page_name] << ip
      end

      TotalCountFormatter.new(@logs_total).run
      UniqCountFormatter.new(@logs_uniq).run
    end

    private

    def validate_args
      raise ArgumentError, 'File name missing' if @file_name.nil?
    end
  end
end
