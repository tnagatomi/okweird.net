class Post < ApplicationModel
  attribute :filepath, :string
  attribute :frontmatter, default: -> { {} }
  attribute :body, :string

  def self.all
    cache[:all] ||= Dir.glob("#{Rails.root}/_posts/**/*.*").map do |filepath|
      Post.from_file(filepath)
    end
  end

  def self.from_file(path)
    parsed = FrontMatterParser::Parser.parse_file(path)
    new(filepath: path, frontmatter: parsed.front_matter, body: parsed.content)
  end

  def filename
    File.basename(filepath, ".*")
  end

  def title
    frontmatter.fetch("title", "")
  end

  def content
    @_content ||= Kramdown::Document.new(body, input: "GFM").to_html.html_safe
  end

  def published_at
    @_published_at ||= Time.zone.parse(frontmatter["date"])
  end

  def to_param
    filename
  end
end
