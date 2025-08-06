require "rails_helper"

RSpec.describe Post, type: :model do
  describe ".japanese" do
    it "returns only Japanese posts" do
      japanese_posts = Post.japanese

      expect(japanese_posts).not_to be_empty
      japanese_posts.each do |post|
        expect(post.filepath).to include("/_posts/ja/")
        expect(post.language).to eq(:ja)
      end
    end
  end

  describe ".english" do
    it "returns only English posts" do
      english_posts = Post.english

      english_posts.each do |post|
        expect(post.filepath).not_to include("/_posts/ja/")
        expect(post.language).to eq(:en)
      end
    end
  end

  describe "#language" do
    it "identifies Japanese posts correctly" do
      post = Post.new(filepath: "/path/_posts/ja/2024/test.md")
      expect(post.language).to eq(:ja)
    end

    it "identifies English posts correctly" do
      post = Post.new(filepath: "/path/_posts/en/2024/test.md")
      expect(post.language).to eq(:en)

      post = Post.new(filepath: "/path/_posts/2024/test.md")
      expect(post.language).to eq(:en)
    end
  end
end
