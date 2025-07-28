require "rails_helper"

RSpec.describe "About", type: :system do
  it "visits the homepage" do
    visit "/"
    expect(page).to have_title "It's okay to be weird"
  end
end
