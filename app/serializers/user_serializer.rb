class UserSerializer < ActiveModel::Serializer
  attributes(
    :created_at,
    :github_id,
    :github_login,
    :id,
    :name,
    :updated_at
  )

  def created_at
    object.created_at.iso8601 rescue nil
  end

  def updated_at
    object.updated_at.iso8601 rescue nil
  end
end
