require 'rails_helper'

describe Gist do
  before(:all) do
    @user = User.new({"email" => "test@test.test"})
  end
  
  it 'get error if gist.file_name is empty' do
    @gist = Gist.new({"text" => "same gist text", "user" => @user})
    
    expect(@gist.valid?).to eq(false)
  end
  
  it 'get error if gist.text is empty' do
    @gist = Gist.new({"file_name" => "file.rb", "user" => @user})
    
    expect(@gist.valid?).to eq(false)
  end
  
  it 'get error if gist.user is empty' do
    @gist = Gist.new({"file_name" => "file.rb", "text" => "same gist text"})
    
    expect(@gist.valid?).to eq(false)
  end
  
  it 'gist is valid' do
    @gist = Gist.new({"file_name" => "file.rb", "text" => "same gist text", "user" => @user})
    
    expect(@gist.valid?).to eq(true)
  end
end