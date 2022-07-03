require 'rspec'
require './log_parser/total_count_formatter'

RSpec.describe LogParser::TotalCountFormatter do
  subject { described_class.new(data) }

  describe '#run' do
    context 'when data is valid format (hash)' do
      let(:data) do
        {
          'url_1' => 1,
          'url_2' => 2,
          'url_3' => 3
        }
      end

      it 'sort data by count desc' do
        expected_results = {
          'url_3' => 3,
          'url_2' => 2,
          'url_1' => 1
        }

        subject.run

        data = subject.data
        expect(data.to_h).to eq(expected_results)
      end

      it 'prints visits summary' do
        expect { subject.run }.to output(/#{Regexp.quote('visits')}/).to_stdout
      end
    end

    context 'when data is not valid format' do
      let(:data) { '"url_1" => 1,"url_2" => 2,"url_3" => 3' }

      it 'returns error message' do
        expect { subject.run }.to raise_error(TypeError, 'data format should be a hash')
      end
    end
  end
end
