class Redcarpet::Render::BeatechHTML < Redcarpet::Render::HTML
  def header(text, level)
    level += 1
    "<h#{level}>#{text}</h#{level}>"
  end

  def preprocess(full_document)
    full_document.gsub(/(http:\/\/[0-9a-zA-Z.\/?=&]+)/, '[\1](\1)')
  end

  def postprocess(full_document)
    full_document.gsub(/#youtube\(http:\/\/www\.youtube\.com\/watch\?v=(.+?)\)/,
      '<iframe width="560" height="315" src="http://www.youtube.com/embed/\1"' +
      ' frameborder="0" allowfullscreen></iframe>')
  end
end
