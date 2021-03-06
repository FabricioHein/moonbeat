require 'test_helper'

class UserCreateTest < ActiveSupport::TestCase

  test 'create user' do
    result = User::Create.(email: 'hello@example.com', password: 'fakePassword')
    model = result['model']

    assert result.success?
    assert model.email.present?
    assert model.password.present?
    assert model.token.present?
  end

  test 'password is encrypted' do
    result = User::Create.(email: 'hello@example.com', password: 'fakePassword')
    model = result['model']

    assert model.password != 'fakePassword'
  end

  test 'cannot create user with same email' do
    user1 = User::Create.(email: 'hello@example.com', password: 'fakePassword')
    user2 = User::Create.(email: 'hello@example.com', password: 'fakePassword')

    assert user1.success?
    assert !user2.success?
  end

end
