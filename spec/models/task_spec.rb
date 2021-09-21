require 'rails_helper'
RSpec.describe Task, type: :model do

  it "is valid with name, limit_date, status" do
    user =   FactoryBot.create(:user2, name: 'Loren', email: 'damy@gmail.com', password: '123456')
    task = Task.new(name: 'Move tables', content: 'some content', limit_date: Date.new(2021,9,30), status: "finished", priority: 1, user_id: user.id)
    task.valid?
    expect(task).to be_valid
  end

  it "is invalid without a name" do
    user =   FactoryBot.create(:user2, name: 'Loren', email: 'tago@gmail.com', password: '123456')
    task = Task.new(name: nil, content: 'some content', limit_date: Date.new(2021,9,30), status: "finished", priority: 1, user_id: user.id)
    task.valid?
    expect(task.errors[:name]).to include("doit être rempli(e)")

  end

  it "is invalid without a content" do
    user =   FactoryBot.create(:user2, name: 'Loren', email: 'tagolol@gmail.com', password: '123456')
    task = Task.new(name: 'Move tables', content: nil, limit_date: Date.new(2021,9,30), status: "finished", priority: 1, user_id: user.id)
    task.valid?
    expect(task.errors[:content]).to include("doit être rempli(e)")

  end

  it "is invalid without a limit_date" do
    user =   FactoryBot.create(:user2, name: 'Loren', email: 'taglo@gmail.com', password: '123456')
    task = Task.new(name: 'Move tables', content: 'some content', limit_date: nil , status: "finished", priority: 1, user_id: user.id)
    task.valid?
    expect(task.errors[:limit_date]).to include("doit être rempli(e)")
  end
  it "is invalid without a status" do
    user =   FactoryBot.create(:user2, name: 'Loren', email: 'tagmoo@gmail.com', password: '123456')
    task = Task.new(name: 'Move tables', content: 'some content', limit_date: Date.new(2021,9,30), status: nil , priority: 1, user_id: user.id)
    task.valid?
    expect(task.errors[:status]).to include("doit être rempli(e)")
  end
  it "is invalid without a priority" do
    user =   FactoryBot.create(:user2, name: 'Loren', email: 'tagil@gmail.com', password: '123456')
    task = Task.new(name: 'Move tables', content: 'some content', limit_date: Date.new(2021,9,30), status: "finished", priority: nil , user_id: user.id)
    task.valid?
    expect(task.errors[:priority]).to include("doit être rempli(e)")
  end

  describe 'Search function' do
    # 必要に応じて、testデータの内容を変更して構わない
      user1 =   FactoryBot.create(:user2, name: 'Loren', email: 'eleonori@gmail.com', password: '123456')
    let!(:task) { FactoryBot.create(:task, name: 'task', content: 'some content', status: 'in progress', priority: 1, limit_date: Date.new(2021,9,9), user_id: user1.id)}
    let!(:second_task) { FactoryBot.create(:task, name: 'task1', content: 'some content', status: 'unstarted', priority: 1, limit_date: Date.new(2021,9,9), user_id: user1.id) }
    context 'Title is performed by scope method' do
      it "Tasks containing search keywords are narrowed down" do
        # title_seach is a Title search method presented by scope. The method name can be arbitrary.
        expect(Task.search_name('task')).to include(task)
        expect(Task.search_name('task')).not_to include(second_task)
        expect(Task.search_name('task').count).to eq 1
      end
    end
    context 'When the status is searched with the scope method' do
      it "Tasks that exactly match the status are narrowed down" do
        # Write content here
         expect(Task.search_status('in progress')).to include(task)
        expect(Task.search_status('in progress')).not_to include(second_task)
        expect(Task.search_status('in progress').count).to eq 1
      end
    end
    context 'When performing fuzzy search and status search Title' do
      it "Narrow down tasks that include search keywords in the Title and exactly match the status" do
        # Write content here
        expect(Task.name_status_search('task','in progress')).to include(task)
        expect(Task.name_status_search('task','in progress')).not_to include(second_task)
        expect(Task.name_status_search('task','in progress').count).to eq 1
      end
    end
  end

end
