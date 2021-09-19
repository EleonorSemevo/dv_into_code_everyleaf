require 'rails_helper'
RSpec.describe 'User management', type: :system do
  # let!(:user1) { FactoryBot.create(:user1) }
  # let!(:task) { FactoryBot.create(:task, user: user) }
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
      fill_in 'Email' , with: 'lora@gmail.com'
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
  end
    context 'User logged out' do
      it 'log user out by showing login forms' do
        click_on 'Logout'
        expect(page).to have_content 'Login'
      end
    end
  end

  describe 'Admin screen test' do
    before do
        FactoryBot.create(:admin1, name: 'Loren', email: 'admin1@gmail.com', password: '123456', admin: true)
    end
    context 'when admin log in' do
      it 'shows admin panel' do
        visit tasks_path
        click_on 'Login'
        fill_in 'Email' , with: 'admin1@gmail.com'
        fill_in 'Password' , with: '123456'
        click_on 'Se connecter'

        expect(page).to have_content('Admin page')
      end
    end

    context 'when general try to access management screen' do
      it 'shows tasks list of user with notice' do
        FactoryBot.create(:user2, name: 'Loren', email: 'mora@gmail.com', password: '123456')
        visit tasks_path
        click_on 'Login'
        fill_in 'Email' , with: 'mora@gmail.com'
        fill_in 'Password' , with: '123456'
        click_on 'Se connecter'

        visit admin_users_path
        expect(page).to have_content 'general tasks list'
        expect(page).to have_content 'Only admin can access this page'
      end
    end

    context 'Admin register new users' do
      it 'shows user registered in users list page' do
        visit tasks_path
        click_on 'Login'
        fill_in 'Email' , with: 'admin1@gmail.com'
        fill_in 'Password' , with: '123456'
        click_on 'Se connecter'

        click_on 'New User'
        fill_in 'Name' , with: 'Loren'
        fill_in 'Email' , with: 'lore@gmail.com'
        fill_in 'Password' , with: '123456'
        fill_in 'Password confirmation' , with: '123456'
        click_on 'Enregistrer'

        expect(page).to have_content 'Loren'

      end
    end

    context 'When admin consult user detail' do
      it 'shows user detail' do
        visit tasks_path
        click_on 'Login'
        fill_in 'Email' , with: 'admin1@gmail.com'
        fill_in 'Password' , with: '123456'
        click_on 'Se connecter'

        user = FactoryBot.create(:user1, name: 'Loren', email: 'doda@gmail.com', password: '123456')
        visit admin_user_path(user)
        expect(page).to have_content('doda@gmail.com')
      end
    end

    context 'Admin can edit user detail' do
      it 'shows user detail updated' do
        visit tasks_path
        click_on 'Login'
        fill_in 'Email' , with: 'admin1@gmail.com'
        fill_in 'Password' , with: '123456'
        click_on 'Se connecter'

        user = FactoryBot.create(:user1, name: 'Loren', email: 'doda@gmail.com', password: '123456')
        visit edit_admin_user_path(user)
        fill_in 'Name', with: 'Lola'
        fill_in 'Password' , with: '1234567'
        fill_in 'Password confirmation' , with: '1234567'
        click_on 'Enregistrer'
        expect(page).to have_content('Lola')
      end
    end

    context 'Admin can delete user' do
      it 'deleted user' do
        visit tasks_path
        click_on 'Login'
        fill_in 'Email' , with: 'admin1@gmail.com'
        fill_in 'Password' , with: '123456'
        click_on 'Se connecter'

        #user = FactoryBot.create(:user1, name: 'Lory', email: 'doda@gmail.com', password: '123456')
        click_on 'destroy'
        expect(page).not_to have_content('Lory')
      end
    end



  end
end
