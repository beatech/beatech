module ApplicationHelper
  def page_title
    title = "BEATECH"
    title = title + " - " + @page_title if @page_title
    title
  end
end
