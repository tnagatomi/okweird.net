require "rails_helper"

RSpec.describe "Posts", type: :system do
  it "can visit blog list and move to blog post" do
    visit "/blog"
    expect(page).to have_content "Blog"

    first("ul > li").click
    expect(page).to have_content "Takayuki Nagatomi"
  end
end
