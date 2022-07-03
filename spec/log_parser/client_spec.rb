require 'rspec'
require './log_parser/client'

RSpec.describe LogParser::Client do
  subject { described_class.new(file_name) }

  describe '#process' do
    context 'when argument is valid' do
      let(:file_name) { 'webserver.log' }

      context 'when file has logs' do
        before do
          logs = "/help_page/1 126.318.035.038\n/contact 184.123.665.067\n/home 184.123.665.067\n"
          allow(File).to receive(:read).and_return(logs)
        end

        it 'calls TotalCountFormatter and UniqCountFormatter' do
          expect(LogParser::TotalCountFormatter).to receive(:new).and_call_original
          expect(LogParser::UniqCountFormatter).to receive(:new).and_call_original
          subject.process
        end
      end

      context 'when file does not have logs' do
        before { allow(File).to receive(:read).and_return('') }

        it 'returns alertung message' do
          expect(subject.process).to eq('No logs to investigate')
        end
      end
    end

    context 'when argument is not valid' do
      let(:file_name) { nil }

      it 'returns error message' do
        expect { subject.process }.to raise_error(ArgumentError, 'File name missing')
      end
    end
  end
end
