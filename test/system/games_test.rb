require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "Give random letters and word not in the grid" do
    visit new_url
    fill_in 'word', with: 'RANDOM'
    click_button 'submit'
    assert test: "Sorry but RANDOM can't be build out of"
  end
end
