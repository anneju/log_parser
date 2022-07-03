require 'pry'

module LogParser
  class TotalCountFormatter
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def run
      validate_data_type

      @data = sort_page_visits_desc(@data)
      @data.each { |page_name, count| print_result(page_name, count) }
    end

    private

    def validate_data_type
      raise TypeError, 'data format should be a hash' unless @data.is_a?(Hash)
    end

    def sort_page_visits_desc(data)
      data.sort_by { |_page_name, count| -count }
    end

    def print_result(page_name, count)
      p "#{page_name} #{count} visits"
    end
  end
end
