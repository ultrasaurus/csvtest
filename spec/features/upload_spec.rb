require "rails_helper"

RSpec.feature "User uploads", :type => :feature do
  scenario "simple csv" do
    visit "/"

    attach_file('datafile', File.join(Rails.root, '/spec/fixtures/three-sentences.csv'))

    click_button('Upload')

    expect(page).to have_text("success")
    expect(page).to have_text("3 rows")
    expect(page).to have_text("fields: id,content")

  end
end
