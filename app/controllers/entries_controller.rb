class EntriesController < ApplicationController
  def index
  end

  def frontpage
    render text: "No entries given"
  end
end
