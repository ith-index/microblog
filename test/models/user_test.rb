require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      username: 'foobarbaz',
      email: 'foobarbaz@example.com',
      password: 'foobarbaz',
      password_confirmation: 'foobarbaz'
    )
  end

  test 'minimum valid object should be valid' do
    assert @user.valid?
  end

  test 'username should be present' do
    @user.username = '    '
    assert_not @user.valid?
  end

  test 'username should be unique' do
    dupUser = @user.dup
    @user.save
    assert_not dupUser.valid?
  end

  test 'username length should be 50 characters or less' do
    @user.username = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '    '
    assert_not @user.valid?
  end

  test 'email should be unique' do
    dupUser = @user.dup
    @user.save
    assert_not dupUser.valid?
  end

  test 'email length should be 255 characters or less' do
    @user.email = 'a' * 256 + '@example.com'
    assert_not @user.valid?
  end

  test 'email format should be valid' do
    invalidEmails = [
      'user@', '@example', 'user@example'
    ]
    invalidEmails.each do |invalidEmail|
      @user.email = invalidEmail
      assert_not @user.valid?, "#{invalidEmail} should be invalid"
    end
  end

  test 'password should be present' do
    @user.password = @user.password_confirmation = '     '
    assert_not @user.valid?
  end

  test 'password length should be 6 characters or more' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end
end
