module LogParser
  class UniqCountFormatter < TotalCountFormatter
    def run
      @data.transform_values!(&:size)
      super
    end

    private

    def print_page_visits(data)
      data.each do |page_name, count|
        p "#{page_name} #{count} uniq views"
      end
    end
  end
end
