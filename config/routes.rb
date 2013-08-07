Beatech::Application.routes.draw do
  #
  # Entries
  #
  get ":url" => "entries#show"
  
  root to: "entries#frontpage"
end
