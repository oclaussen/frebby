require 'json'
require 'open3'

describe 'frebby' do
  Dir.glob('spec/fixtures/*.frb') do |file|
    describe File.basename(file, '.frb') do
      before do
        @input = File.read(file)
        expected_file = "#{File.dirname(file)}/#{File.basename(file, '.frb')}.json"
        @expected = File.read(expected_file)
      end

      it 'creates the correct output' do
        Open3.popen3('frebby') do |stdin, stdout, stderr, wait_thr|
          stdin.write(@input)
          stdin.close

          expect(stderr.read).to be_empty
          expect(wait_thr.value).to eq(0)

          result = JSON.parse(stdout.read)
          expected = JSON.parse(@expected)
          expect(result).to eq(expected)
        end
      end
    end
  end
end
