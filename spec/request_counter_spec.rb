require './request_counter'

RSpec.describe RequestCounter do
  subject(:counter) { RequestCounter.new }

  it 'stores IP occurrences' do
    counter.request_handled('1.1.1.1')
    counter.request_handled('1.1.1.1')
    counter.request_handled('2.2.2.2')

    expect(counter['1.1.1.1']).to eq 2
    expect(counter['2.2.2.2']).to eq 1
    expect(counter.count).to eq 2
  end

  it 'can be cleared' do
    counter.request_handled('1.1.1.1')
    expect(counter.count).to eq 1

    counter.clear
    expect(counter.count).to eq 0
  end

  describe 'top100' do
    it 'returns [] if empty' do
      expect(subject.top100).to eq []
    end

    it 'returns element ordered by occurrences' do
      # elements do not have to be IP address
      items = [10, 20, 20, 20, 20, 30, 30].shuffle
      items.each { |i| subject.request_handled(i) }

      expect(subject.top100).to eq [20, 30, 10]
    end

    it 'limit to 100 records' do
      110.times{ |i| counter.request_handled(i) }

      expect(subject.top100.count).to eq 100
    end
  end
end
