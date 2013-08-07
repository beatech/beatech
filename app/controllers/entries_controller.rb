class EntriesController < ApplicationController
  def show
  end

  def frontpage
    render action: "show", url: "frontpage"
  end
end
