require "open-uri"

# delete nonexistent url
def check_icon_url(icon_url)
  return "" unless icon_url.present?
  begin
    open(icon_url)
  rescue OpenURI::HTTPError
    icon_url = ""
  end
  icon_url
end

User.destroy_all
Beatech::API::User.all.each do |user|
  user[:icon_url] = user.delete(:profile_image)
  user[:icon_url] = check_icon_url(user[:icon_url])
  password_digest = user.delete(:password_digest)

  user = User.create!(
    # to pass has_secure_password
    user.merge(password: "password", password_confirmation: "password")
  )

  # force update password_digest
  user.password_digest = password_digest
  user.save
end
