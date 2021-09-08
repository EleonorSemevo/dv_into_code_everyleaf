require 'rails_helper'
RSpec.describe Task, type: :model do
  it "is valid with name, limit_date, status" do
    task = Task.new(name: 'Move tables', content: 'some content', limit_date: Date.new(2021,9,30), status: "finished", priority: 'middle')
    task.valid?
    expect(task).to be_valid
  end

  it "is invalid without a name" do
    task = Task.new(name: nil, content: 'some content', limit_date: Date.new(2021,9,30), status: "finished", priority: 'middle')
    task.valid?
    expect(task.errors[:name]).to include("can't be blank")

  end

  it "is invalid without a content" do
    task = Task.new(name: 'Move tables', content: nil, limit_date: Date.new(2021,9,30), status: "finished", priority: 'middle')
    task.valid?
    expect(task.errors[:content]).to include("can't be blank")

  end

  it "is invalid without a limit_date" do
    task = Task.new(name: 'Move tables', content: 'some content', limit_date: nil , status: "finished", priority: 'middle')
    task.valid?
    expect(task.errors[:limit_date]).to include("can't be blank")
  end
  it "is invalid without a status" do
    task = Task.new(name: 'Move tables', content: 'some content', limit_date: Date.new(2021,9,30), status: nil , priority: 'middle')
    task.valid?
    expect(task.errors[:status]).to include("can't be blank")
  end
  it "is invalid without a priority" do
    task = Task.new(name: 'Move tables', content: 'some content', limit_date: Date.new(2021,9,30), status: "finished", priority: nil )
    task.valid?
    expect(task.errors[:priority]).to include("can't be blank")
  end

end