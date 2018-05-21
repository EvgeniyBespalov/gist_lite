require 'rails_helper'

describe Comment do

  it 'comment error if comment.user is empty' do
    @comment = Comment.new({gist: Gist.new(), text: "custom text"})
    expect(@comment.valid?).to eql(false)
  end
  
  it 'comment error if comment.gist is empty' do
    @comment = Comment.new({user: User.new(), text: "custom text"})
    expect(@comment.valid?).to eql(false)
  end
  
  it 'comment valid if all property is set' do
    @comment = Comment.new({user: User.new(), gist: Gist.new(), text: "custom text"})
    expect(@comment.valid?).to eql(true)
  end
  


end