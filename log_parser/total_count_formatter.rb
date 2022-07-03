module LogParser
  class TotalCountFormatter
    def initialize(data)
      @data = data
    end

    def run
      @data = sort_page_visits_desc(@data)
      print_page_visits(@data)
    end

    private

    def sort_page_visits_desc(data)
      data.sort_by { |_page_name, count| -count }
    end

    def print_page_visits(data)
      data.each do |page_name, count|
        p page_name + " #{count} views"
      end
    end
  end
end
