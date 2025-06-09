require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  given!(:user) { create(:user) }
  given!(:task) { create(:task, user: user) }

  scenario "User can see tasks" do
    sign_in(user)

    visit "/tasks"

    expect(page).to have_text("Your Tasks")
  end

  scenario "User can create task" do
    sign_in(user)

    visit "/tasks"
    fill_in "Title", with: "Anything"
    click_on "Create Task"

    visit "/tasks"
    expect(page).to have_content("Anything")
  end

  scenario "User can edit task" do
    sign_in(user)

    visit tasks_path(task)
    click_on "Edit"

    within "form[action='/tasks/#{task.id}']" do
      fill_in "task_title", with: "New task"
      click_on "Update"
    end

    expect(page).to have_content("New task")
  end

  scenario "User can delete task" do
    sign_in(user)

    visit "/tasks"
    click_on "Delete"

    expect(page).to have_no_content("MyString")
  end
end
