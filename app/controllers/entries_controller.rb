class EntriesController < ApplicationController
  def show
  end

  def frontpage
    render text: "No entries given"
  end
end
