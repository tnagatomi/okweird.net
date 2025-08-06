require "rails_helper"

RSpec.describe "Language Switching", type: :system do
  describe "language switcher" do
    it "displays language switcher with correct links" do
      visit "/"
      within ".language-switcher" do
        expect(page).to have_css(".current-lang", text: "en")
        expect(page).to have_link("ja", href: "/ja/")
      end
      
      visit "/ja/"
      within ".language-switcher" do
        expect(page).to have_css(".current-lang", text: "ja")
        expect(page).to have_link("en", href: "/")
      end
    end

    it "language links have correct href attributes" do
      visit "/"
      expect(page).to have_link("ja", href: "/ja/")
      
      visit "/ja/"
      expect(page).to have_link("en", href: "/")
    end

    it "navigation links maintain language context" do
      visit "/ja/"
      expect(page).to have_link("Blog", href: "/ja/blog/")
      expect(page).to have_link("History", href: "/ja/history/")
      
      visit "/"
      expect(page).to have_link("Blog", href: "/posts/")
      expect(page).to have_link("History", href: "/history/")
    end

    it "language switcher adapts to current page" do
      visit "/posts/"
      expect(page).to have_link("ja", href: "/ja/blog/")
      
      visit "/history/"
      expect(page).to have_link("ja", href: "/ja/history/")
      
      visit "/ja/blog/"
      expect(page).to have_link("en", href: "/posts/")
    end
  end

  describe "URL structure and content" do
    it "serves English content at root paths" do
      visit "/"
      expect(page).to have_content("It's okay to be weird")
      
      visit "/posts/"
      expect(page).to have_content("Blog")
      
      visit "/history/"
      expect(page).to have_content("History")
      expect(page).to have_content("Birth to High School Dropout")
    end

    it "serves Japanese content at /ja paths" do
      visit "/ja/"
      expect(page).to have_content("It's okay to be weird")
      
      visit "/ja/blog/"
      expect(page).to have_content("Blog")
      
      visit "/ja/history/"
      expect(page).to have_content("略歴")
      expect(page).to have_content("生誕から高校中退まで")
    end
  end
end
