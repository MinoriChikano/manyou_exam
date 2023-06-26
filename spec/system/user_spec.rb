require 'rails_helper'
RSpec.describe 'ユーザ管理機能', type: :system do
  describe 'ユーザ新規登録' do
    context 'ユーザを新規作成した場合' do
      it '新規登録できる' do
        visit new_user_path
        fill_in 'user[name]', with: 'user1'
        fill_in 'user[email]', with: 'user1@test.com'
        fill_in 'user[password]', with: '123456'
        fill_in 'user[password_confirmation]', with: '123456'
        click_button 'Create my account'
        expect(current_path).to eq root_path
      end
    end
    context 'ログインせず一覧画面に飛ぼうとした時' do
      it 'ログイン画面が表示される' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end
  describe 'ログイン機能に関するテスト' do
    before do
      @first_user=FactoryBot.create(:user)
      @second_user=FactoryBot.create(:second_user)
    end
    context 'ログインしようとした時' do
      it 'ログインできる' do
        visit new_session_path
        fill_in 'Email', with: @first_user.email
        fill_in 'Password', with: @first_user.password
        click_button "Log in"
        expect(current_path).to eq root_path
      end
    end
    context 'ログイン中の時' do
      before do
        visit new_session_path
        fill_in 'Email', with: @second_user.email
        fill_in 'Password', with: @second_user.password
        click_button "Log in"
      end
      it '自分の詳細画面に飛べる' do
        sleep(3)
        visit user_path(@second_user.id)
        expect(current_path).to eq user_path(@second_user.id)
      end
      it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧に遷移' do
        visit user_path(@first_user.id)
        expect(current_path).to eq root_path
      end
      it 'ログアウトができる' do
        visit root_path
        click_on "Logout"
        expect(current_path).to eq new_session_path
      end
    end
  end
  describe '管理画面' do
    before do
      @first_user=FactoryBot.create(:user)
      @second_user=FactoryBot.create(:second_user)
      @third_user=FactoryBot.create(:third_user)
    end
    context '管理ユーザの場合' do
      before do
        visit new_session_path
        fill_in 'Email', with: @third_user.email
        fill_in 'Password', with: @third_user.password
        click_button "Log in"
      end
      it '管理画面にアクセスできる' do
        sleep(2)
        visit admin_users_path
        expect(current_path).to eq admin_users_path
      end
      it '管理画面ユーザは新規登録ができる' do
        sleep(2)
        visit admin_users_path
        click_button "新規ユーザ登録"
        fill_in 'user[name]', with: 'tadao'
        fill_in 'user[email]', with: 'tadao@test.com'
        fill_in 'user[password]', with: '123456'
        fill_in 'user[password_confirmation]', with: '123456'
        select '一般', from: 'user[admin]'
        click_on '登録する'
        expect(page).to have_content '作成しました!'
        sleep(2)
      end
      it '管理ユーザはユーザの詳細画面にアクセスできる' do
        visit admin_users_path
        sleep(2)
        user_list = all('td')
        sleep(2)
        click_button '詳細', match: :first
        sleep(2)
        expect(current_path).to eq admin_user_path(@first_user.id)
        sleep(2)
      end
      it '管理ユーザは詳細画面からユーザを編集できる' do
        visit admin_users_path
        sleep(2)
        user_list = all('td')
        sleep(2)
        click_on '編集', match: :first
        sleep(2)
        fill_in 'user[password]', with: '654321'
        fill_in 'user[password_confirmation]', with: '654321'
        click_on '更新する'
        sleep(2)
        expect(current_path).to eq admin_users_path
        sleep(2)
      end
      it '管理者ユーザはユーザの削除ができる' do
        visit admin_users_path
        user_list = all('td')
        click_on '削除', match: :first
        sleep(2)
        page.accept_confirm
        expect(current_path).to eq admin_users_path
      end
    end
    context '一般ユーザの場合' do
      before do
        visit new_session_path
        fill_in 'Email', with: @second_user.email
        fill_in 'Password', with: @second_user.password
        click_button "Log in"
      end
      it '管理画面にアクセスできない' do
        visit admin_users_path
        expect(current_path).not_to eq admin_users_path
      end
    end
  end
end