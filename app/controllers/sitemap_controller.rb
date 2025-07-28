class SitemapController < ApplicationController
  layout false

  def index
    @entries = []

    @entries << SitemapEntry.new(loc: root_url)
    @entries << SitemapEntry.new(loc: history_index_url)
    @entries << SitemapEntry.new(loc: posts_url)
    @entries += Post.all.sort_by(&:published_at).map do |post|
      SitemapEntry.new(loc: post_url(post))
    end
  end

  class SitemapEntry
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :loc, :string
    attribute :lastmod, :datetime, default: -> { Time.current }
    attribute :changefreq, :string, default: "daily"
    attribute :priority, :float, default: 1.0
  end
end
