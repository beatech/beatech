User.destroy_all
Beatech::API::User.all.each do |user|
  user[:icon] = user.delete(:profile_image)

  User.create!(user)
end
