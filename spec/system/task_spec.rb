require 'rails_helper'
RSpec.describe 'Task management function', type: :system do
  describe 'New creation function' do
    context 'When creating a new task' do
      it 'The created task is displayed' do
        task = FactoryBot.create(:task, name: 'task', content: 'some content', status: 'finished', priority: 'middle', limit_date: Date.new(2021,9,9))

        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end
  describe 'List display function' do
    context 'When transitioning to the list screen' do
      it 'The created task list is displayed' do
        task = FactoryBot.create(:task, name: 'task', content: 'some content', status: 'finished', priority: 'middle', limit_date: Date.new(2021,9,9))

        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end
  describe 'Detailed display function' do
    context 'When transitioned to any task details screen' do
      it 'The content of the relevant task is displayed' do
        task = FactoryBot.create(:task, name: 'task', content: 'some content', status: 'finished', priority: 'middle', limit_date: Date.new(2021,9,9))

        visit task_path(task.id)
        expect(page).to have_content 'task'
      end
    end
  end
end