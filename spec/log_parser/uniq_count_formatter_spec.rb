require 'rspec'
require 'set'
require './log_parser/total_count_formatter'
require './log_parser/uniq_count_formatter'

RSpec.describe LogParser::UniqCountFormatter do
  subject { described_class.new(data) }

  describe '#run' do
    context 'when data is valid format (hash)' do
      let(:ip_1) { '111.111.111.111' }
      let(:ip_2) { '222.222.222.222' }
      let(:ip_3) { '333.333.333.333' }
      let(:data) do
        {
          'url_1' => Set[ip_1],
          'url_2' => Set[ip_1, ip_2],
          'url_3' => Set[ip_1, ip_2, ip_3]
        }
      end

      it 'count by ips and sort data by count desc' do
        expected_results = {
          'url_3' => 3,
          'url_2' => 2,
          'url_1' => 1
        }

        subject.run

        data = subject.data
        expect(data.to_h).to eq(expected_results)
      end

      it 'prints unique views summary' do
        expect { subject.run }.to output(/#{Regexp.quote('uniq views')}/).to_stdout
      end
    end

    context 'when data is not valid format' do
      let(:data) { '"url_1" => ["000.000.000.000", "111.111.111.111"]' }

      it 'returns error message' do
        expect { subject.run }.to raise_error(TypeError, 'data format should be a hash')
      end
    end
  end
end
