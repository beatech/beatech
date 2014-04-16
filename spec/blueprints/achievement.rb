Achievement.blueprint do
  date { Date.today }
  text { '皆伝合格しました！' }
  user { User.make! }
end
