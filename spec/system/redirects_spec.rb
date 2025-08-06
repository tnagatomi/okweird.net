require "rails_helper"

RSpec.describe "Redirects", type: :system do
  describe "legacy blog URLs" do
    it "shows redirect page for /blog" do
      visit "/blog/"
      expect(page).to have_content("Redirecting")
      expect(page).to have_link(href: "/ja/blog/")
      expect(page).to have_css('meta[http-equiv="refresh"]', visible: false)
    end

    it "shows redirect page for /blog posts" do
      visit "/blog/2025/08/how-i-abandoned-claude-code-generated-oss/"
      expect(page).to have_content("Redirecting")
      expect(page).to have_link(href: "/ja/blog/2025/08/how-i-abandoned-claude-code-generated-oss/")
    end
  end

  describe "legacy feed URL" do
    it "shows redirect page for /index.xml" do
      visit "/index.xml"
      expect(page).to have_content("Redirecting")
      expect(page).to have_link(href: "/ja/feed.xml")
      expect(page).to have_css('meta[http-equiv="refresh"]', visible: false)
    end
  end
end
