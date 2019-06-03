module UsersHelper
  def image_url_for(user)
    user.profile.profile_picture.attached? ? user.profile.profile_picture : "https://api.adorable.io/avatars/300/#{user.email}.png"
  end

  def age_for(user)
    user.profile.age.nil? ? 'No age yet' : pluralize(user.profile.age, 'year')
  end
end
