class WardenMock
  attr_reader :user

  def set_user(user)
    @user = user
  end

  def logout; end
end
