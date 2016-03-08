module BeatechMarkdownHelper
  def markdown(text)
    return "" if text.blank?

    unless @markdown
      beatech_renderer = Redcarpet::Render::BeatechHTML.new(hard_wrap: true, filter_html: true)
      @markdown = Redcarpet::Markdown.new(beatech_renderer, tables: true, lax_spacing: true, no_intra_emphasis: true)
    end

    @markdown.render(text).html_safe
  end

  def render_wiki_content(entry)
    return "" unless entry && entry.content
    markdown(entry.content)
  end
end
