module ApplicationHelper
  require "redcarpet"

  def markdown(text)
    unless text
      ''
    else
      options = { autolink: true,
                  fenced_code_blocks: true,
                  tables: true,
                  superscript: true,
                  highlight: true,
                  quote: true,
                  strikethrough: true }
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
      markdown.render(text)
    end
  end
end
