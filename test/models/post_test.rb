require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    user = User.create(
      username: 'foobarbaz',
      email: 'foobarbaz@example.com',
      password: 'foobarbaz',
      password_confirmation: 'foobarbaz'
    )
    @post = user.posts.build(
      content: 'Foobarbaz...'
    )
  end

  test 'minimum valid object should be valid' do
    assert @post.valid?
  end

  test 'content should be present' do
    @post.content = '    '
    assert_not @post.valid?
  end

  test 'content length should be 140 characters or less' do
    @post.content = 'a' * 141
    assert_not @post.valid?
  end
end
