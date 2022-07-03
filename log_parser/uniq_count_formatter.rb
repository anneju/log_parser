require 'pry'

module LogParser
  class UniqCountFormatter < TotalCountFormatter
    def run
      validate_data_type

      @data.transform_values!(&:size)
      @data = sort_page_visits_desc(@data)
      @data.each { |page_name, count| print_result(page_name, count) }
    end

    private

    def print_result(page_name, count)
      p "#{page_name} #{count} uniq views"
    end
  end
end
