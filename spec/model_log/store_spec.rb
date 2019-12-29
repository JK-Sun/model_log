RSpec.describe ModelLog::Store do
  let(:current_user) { 'my user' }
  let(:current_requester) { 'my requester' }
  subject { ModelLog::Store }

  it 'test store write current_user' do
    subject.current_user = current_user
    expect(subject.store).to eq({
      current_user: current_user
    })
  end

  it 'test store write requester' do
    subject.current_requester = current_requester
    expect(subject.store).to eq({
      current_user: current_user,
      requester: current_requester
    })
  end

  it 'test store read current_user' do
    expect(subject.current_user).to eq current_user
  end

  it 'test store read requester' do
    expect(subject.current_requester).to eq current_requester
  end

  it 'test store delete current_user' do
    subject.clear_current_user!
    expect(subject.store).to eq ({
      requester: current_requester
    })
  end

  it 'test store delete requester' do
    subject.clear_current_requester!
    expect(subject.store).to eq ({})
  end
end

