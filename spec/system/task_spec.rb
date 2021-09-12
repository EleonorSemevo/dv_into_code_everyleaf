require 'rails_helper'
RSpec.describe 'Task management function', type: :system do
  describe 'New creation function' do
    context 'When creating a new task' do
      it 'The created task is displayed' do
        task = FactoryBot.create(:task, name: 'task', content: 'some content', status: 'finished', priority: 1, limit_date: Date.new(2021,9,9))

        visit tasks_path
        expect(page).to have_content 'task'
      end
    end

    context 'When creating a new task ' do
      it ' shows up at top' do
         FactoryBot.create(:task, name: 'task1', content: 'some content1', status: 'finished', priority: 1, limit_date: Date.new(2021,9,9))
         FactoryBot.create(:task, name: 'task2', content: 'some content2', status: 'finished', priority: 1, limit_date: Date.new(2021,9,9))

         visit tasks_path
         tasks= all('.task_row')

         expect(tasks[0]).to have_content 'task2'
      end
    end
  end
  describe 'List display function' do
    context 'When transitioning to the list screen' do
      it 'The created task list is displayed' do
        task = FactoryBot.create(:task, name: 'task', content: 'some content', status: 'finished', priority: 1, limit_date: Date.new(2021,9,9))

        visit tasks_path
        expect(page).to have_content 'task'
      end
    end

  end
  describe 'Detailed display function' do
    context 'When transitioned to any task details screen' do
      it 'The content of the relevant task is displayed' do
        task = FactoryBot.create(:task, name: 'task', content: 'some content', status: 'finished', priority: 1, limit_date: Date.new(2021,9,9))

        visit task_path(task.id)
        expect(page).to have_content 'task'
      end
    end
  end
  
  #nouveau tests
  describe 'Search function' do
    before do
      task = FactoryBot.create(:task, name: 'task', content: 'some content', status: 'in progress', priority: 1, limit_date: Date.new(2021,9,9))
      task1 = FactoryBot.create(:task, name: 'task1', content: 'some content', status: 'finished', priority: 1, limit_date: Date.new(2021,9,9))

      #FactoryBot.create(:second_task, title: "sample")
    end
    context 'If you do a fuzzy search by Name' do
      it "Filter by tasks that include search keywords" do
        visit tasks_path
        fill_in 'Name' , with: 'task'
        click_on 'Chercher'
        tasks = all('.task_row')
      
        expect(tasks[0]).to have_content 'task'

      end
    end
    context 'When you search for status' do
      it "Tasks that exactly match the status are narrowed down" do
        visit tasks_path
        select 'in progress', from: 'Status'
        click_on 'Chercher'
        tasks = all('.task_status')

        tasks.each do |task|
          expect(task).to have_content 'in progress'
        end

      end
    end
    context 'Name performing fuzzy search of name and status search' do
      it "Narrow down tasks that include search keywords in the Title and exactly match the status" do
        
        visit tasks_path
        fill_in 'Name' , with: 'task'
        select 'in progress', from: 'Status'
        click_on 'Chercher'

        expect(page).to have_content 'task'
        expect(page).to have_content 'in progress'
      end
    end
  end
  
 
end