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
end
