class EditUserViewModel
  def initialize(user)
    @user = user
  end

  def record
    user
  end

  private

  attr_reader :user
end
