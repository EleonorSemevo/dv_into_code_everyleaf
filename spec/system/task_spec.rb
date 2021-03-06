require 'rails_helper'
RSpec.describe 'Task management function', type: :system do
  describe 'New creation function' do
    context 'When creating a new task' do
      it 'The created task is displayed' do
        user =   FactoryBot.create(:user2, name: 'Loren', email: 'odette@gmail.com', password: '123456')
        task = FactoryBot.create(:task, name: 'task', content: 'some content', status: 'unstarted', priority: 1, limit_date: Date.new(2021,9,9), user_id: user.id)

        visit tasks_path
        expect(page).to have_content 'task'
      end
    end

    context 'When creating a new task ' do
      it ' shows up at top' do
         user = FactoryBot.create(:user2, name: 'Loren', email: 'odette@gmail.com', password: '123456')
         FactoryBot.create(:task, name: 'task1', content: 'some content1', status: 'unstarted', priority: 1, limit_date: Date.new(2021,9,9), user_id: user.id)
         FactoryBot.create(:task, name: 'task2', content: 'some content2', status: 'unstarted', priority: 1, limit_date: Date.new(2021,9,9), user_id: user.id)

         visit tasks_path
         tasks= all('.task_row')

         expect(tasks[0]).to have_content 'task2'
      end
    end
  end
  describe 'List display function' do
    context 'When transitioning to the list screen' do
      it 'The created task list is displayed' do
        user = FactoryBot.create(:user2, name: 'Loren', email: 'odette@gmail.com', password: '123456')
        task = FactoryBot.create(:task, name: 'task', content: 'some content', status: 'unstarted', priority: 1, limit_date: Date.new(2021,9,9), user_id: user.id)

        visit tasks_path
        expect(page).to have_content 'task'
      end
    end

    context 'When tasks are listed in descending order of creation date and time' do
      it 'displayed a list of created tasks' do
        user = FactoryBot.create(:user2, name: 'Loren', email: 'odette@gmail.com', password: '123456')
        FactoryBot.create(:task, name: 'task1', content: 'some content', status: 'unstarted', priority: 1, limit_date: Date.new(2021,9,9), user_id: user.id)
        FactoryBot.create(:task, name: 'task2', content: 'some content', status: 'unstarted', priority: 2, limit_date: Date.new(2021,9,9), user_id: user.id)
        visit tasks_path
        tasks = all('.task_row')
        expect(tasks[0]).to have_content 'task2'
      end

    end

    context 'If you click the link to sort by end deadline' do
      it 'display a list of tasks sorted in descending order of end deadlines' do
        user = FactoryBot.create(:user2, name: 'Loren', email: 'odette@gmail.com', password: '123456')
        FactoryBot.create(:task, name: 'task', content: 'some content', status: 'unstarted', priority: 1, limit_date: Date.new(2021,9,9), user_id: user.id)
        FactoryBot.create(:task, name: 'task1', content: 'some content', status: 'unstarted', priority: 1, limit_date: Date.today, user_id: user.id)

        visit tasks_path
        click_on 'Deadline'
        tasks = all('.task_row')


          expect(tasks[0]).to have_content 'task1'

      end
    end

  end
  describe 'Detailed display function' do
    context 'When transitioned to any task details screen' do
      it 'The content of the relevant task is displayed' do
        task = FactoryBot.create(:task, name: 'task', content: 'some content', status: 'unstarted', priority: 1, limit_date: Date.new(2021,9,9), user_id: user.id)

        visit task_path(task.id)
        expect(page).to have_content 'task'
      end
    end
  end

  #nouveau tests
  describe 'Search function' do
    before do
      task = FactoryBot.create(:task, name: 'task', content: 'some content', status: 'in progress', priority: 1, limit_date: Date.new(2021,9,9), user_id: user.id)
      task1 = FactoryBot.create(:task, name: 'task1', content: 'some content', status: 'unstarted', priority: 1, limit_date: Date.new(2021,9,9), user_id: user.id)

      #FactoryBot.create(:second_task, title: "sample")
    end
    context 'If you do a fuzzy search by Name' do
      it "Filter by tasks that include search keywords" do
        visit tasks_path
        fill_in 'task_name' , with: 'task'
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
        fill_in 'task_name' , with: 'task'
        select 'in progress', from: 'Status'
        click_on 'Chercher'

        expect(page).to have_content 'task'
        expect(page).to have_content 'in progress'
      end
    end
  end


end
