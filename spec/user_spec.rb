require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/user'

RSpec.describe User do
  let(:user_1) { User.new("Matt") }
  
  it 'exists' do 

    expect(user_1).to be_instance_of(User)
    expect(user_1.name).to eq("Matt")
  end 

  it 'can setup a user board' do

    expect(user.setup_board)
  end
end
