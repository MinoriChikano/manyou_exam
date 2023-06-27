require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    let!(:second_task) { FactoryBot.create(:second_task, user: user) }
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_session_path
        fill_in 'Email', with: "xxxx@test.com"
        fill_in 'Password', with: "123456"
        click_button "Log in"
        visit new_task_path
        fill_in 'task[task_name]', with: 'task1'
        fill_in 'task[detail]', with:'task1'
        fill_in 'task[expired_at]', with:'2023/06/19/16:30'
        select '完了', from: 'task[status]'
        click_on '登録する'
        expect(page).to have_content 'task'
      end
    end
    context '作成されたタスクが表示された場合' do
      it '終了期限の降順で表示される' do
        visit new_session_path
        fill_in 'Email', with: "xxxx@test.com"
        fill_in 'Password', with: "123456"
        click_button "Log in"
        visit tasks_path
        click_on "締切"
        task_list = all('td').first
        expect(page).to have_content 'タスク'
      end
    end
    context '作成されたタスクが表示された場合' do
      it '優先順で表示される' do
        visit new_session_path
        fill_in 'Email', with: "xxxx@test.com"
        fill_in 'Password', with: "123456"
        click_button "Log in"
        sleep(1)
        click_on "優先順位"
        task_list = all('td').first
        expect(page).to have_content '高'
      end
    end
  end
  describe '一覧表示機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    let!(:second_task) { FactoryBot.create(:second_task, user: user) }
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit new_session_path
        fill_in 'Email', with: "xxxx@test.com"
        fill_in 'Password', with: "123456"
        click_button "Log in"
        expect(page).to have_content 'タスク'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit new_session_path
        fill_in 'Email', with: "xxxx@test.com"
        fill_in 'Password', with: "123456"
        click_button "Log in"
        sleep (2)
        task_list = all('td')
        expect(task_list.first).to have_content 'タスク2'
      end
    end
  end
  describe '詳細表示機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    let!(:second_task) { FactoryBot.create(:second_task, user: user) }
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit new_session_path
        fill_in 'Email', with: "xxxx@test.com"
        fill_in 'Password', with: "123456"
        click_button "Log in"
        click_on '詳細', match: :first
        expect(page).to have_content 'タスク'
      end
    end
  end
  describe 'タスク管理機能', type: :system do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    let!(:second_task) { FactoryBot.create(:second_task, user: user) }
    describe '検索機能' do
      context 'タイトルであいまい検索をした場合' do
        it "検索キーワードを含むタスクで絞り込まれる" do
          visit new_session_path
          fill_in 'Email', with: "xxxx@test.com"
          fill_in 'Password', with: "123456"
          click_button "Log in"
          fill_in 'task_name', with:'タスク'
          click_on '検索'
          expect(page).to have_content 'タスク1'
        end
      end
      context 'ステータス検索をした場合' do
        it "ステータスに完全一致するタスクが絞り込まれる" do
          visit new_session_path
          fill_in 'Email', with: "xxxx@test.com"
          fill_in 'Password', with: "123456"
          click_button "Log in"
          sleep(2)
          select '着手中', from: 'status'
          click_on '検索'
          expect(page).to have_content '着手中'
        end
      end
      context 'タイトルのあいまい検索とステータス検索をした場合' do
        it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
          visit new_session_path
          fill_in 'Email', with: "xxxx@test.com"
          fill_in 'Password', with: "123456"
          click_button "Log in"
          sleep(2)
          fill_in 'task_name', with:'タスク'
          select '未着手', from: 'status'
          click_on '検索'
          expect(page).to have_content ('タスク1')
        end
      end
    end
  end
end