class AdminReport
  include ActiveModel::SerializerSupport

  def initialize(users: [])
    @users = users
  end

  def non_admin_users
    @users.select { |u| !Admins.verify?(u.github_id) }
  end

  def admin_users
    @users.select { |u| Admins.verify?(u.github_id) }
  end

  def quick_stats
    {
      total_users: non_admin_users.length,
      notes: 'None of these include admin users'
    }
  end
end
