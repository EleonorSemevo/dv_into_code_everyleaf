require 'rails_helper'
RSpec.describe 'User management', type: :system do
  describe 'New creation user function' do
    context 'When registering a new user' do
      it 'The created user is connected' do
        visit tasks_path
        click_on 'Sign up'
        fill_in 'Name' , with: 'Loren'
        fill_in 'Email' , with: 'lore@gmail.com'
        fill_in 'Password' , with: '123456'
        fill_in 'Password confirmation' , with: '123456'
        click_on 'Register'

        expect(page).to have_content 'My page'
      end
    end
  end

  describe 'Access tasks list' do
    context 'When accessing tasks list without being connected' do
      it 'The user is redirected to login page' do
        visit tasks_path
        expect(page).to have_content 'Login'
      end
    end
  end

  describe 'Session management fonctionnalities' do
    before do
      # USER LOGIN BEFORE ANYTHING HERE
      FactoryBot.create(:user1, name: 'Loren', email: 'lora@gmail.com', password: '123456')
      visit tasks_path
      click_on 'Login'
      fill_in 'Email' , with: 'loren@gmail.com'
      fill_in 'Password' , with: '123456'
      click_on 'Se connecter'
      #FactoryBot.create(:second_task, title: "sample")
    end
    context 'When user logged in' do
      it 'shows the tasks list' do
        # login already
        expect(page).to have_content 'general tasks list'
      end
      end

      context 'when user logged in and jump to an other person page' do
        it 'redirect to tasks list' do
          # login already
          user2 = FactoryBot.create(:user2, name: 'Fleur', email: 'fleur@gmail.com', password: '123456')
          visit user_path(user2)
          expect(page).to have_content 'general tasks list'
        end
    end

    context 'User can jump to his details screen' do
      it 'shows the profil of the connected user' do
        # login already
        click_on 'account'
        expect(page).to have_content 'My page'
    end

    context 'User logged out' do
      it 'log user out by showing login forms' do
        click_on 'Logout'
        expect(page).to have_content 'Login'
      end
    end
  end

end
end
