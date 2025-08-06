require "rails_helper"

RSpec.describe "Redirects", type: :system do
  describe "legacy blog URLs" do
    it "redirects /blog to Japanese blog" do
      visit "/blog"
      expect(page).to have_current_path("/ja/blog/")
      expect(page).to have_css("h2", text: "Blog")
      expect(page).to have_content("Claude Codeで生成した")
    end

    it "redirects /blog posts with full date to Japanese version" do
      visit "/blog/2025/08/how-i-abandoned-claude-code-generated-oss"
      expect(page).to have_current_path("/ja/blog/2025/08/how-i-abandoned-claude-code-generated-oss/")
      expect(page).to have_css("h2", text: "Claude Codeで生成した「動く」OSSのフレームワークを公開せずに捨てた話")
      expect(page).to have_content("Agentic coding全盛のいま")
    end

    it "redirects /blog posts with slug only to Japanese version" do
      visit "/blog/how-i-abandoned-claude-code-generated-oss"
      expect(page).to have_current_path("/ja/blog/2025/08/how-i-abandoned-claude-code-generated-oss/")
      expect(page).to have_css("h2", text: "Claude Codeで生成した「動く」OSSのフレームワークを公開せずに捨てた話")
      expect(page).to have_content("Agentic coding全盛のいま")
    end
  end
end
