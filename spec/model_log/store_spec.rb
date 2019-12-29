RSpec.describe ModelLog::Store do
  it 'test store write current_user' do
    ModelLog::Store.current_user = 'my user'
    expect(ModelLog::Store.store).to eq({
      current_user: 'my user'
    })
  end

  it 'test store write requester' do
    ModelLog::Store.current_requester = 'my requester'
    expect(ModelLog::Store.store).to eq({
      current_user: 'my user',
      requester: 'my requester'
    })
  end

  it 'test store read current_user' do
    expect(ModelLog::Store.current_user).to eq 'my user'
  end

  it 'test store read requester' do
    expect(ModelLog::Store.current_requester).to eq 'my requester'
  end

  it 'test store delete current_user' do
    ModelLog::Store.clear_current_user!
    expect(ModelLog::Store.store).to eq ({
      requester: 'my requester'
    })
  end

  it 'test store delete requester' do
    ModelLog::Store.clear_current_requester!
    expect(ModelLog::Store.store).to eq ({})
  end
end

