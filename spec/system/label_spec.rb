require 'rails_helper'
RSpec.describe 'label機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user: user) }
  let!(:second_task) { FactoryBot.create(:second_task, user: user) }
  let!(:label) { FactoryBot.create(:label) }
  let!(:second_label) { FactoryBot.create(:second_label) }
  let!(:labelling) {FactoryBot.create(:labelling, task: task, label: label)}
  let!(:labelling) {FactoryBot.create(:labelling, task: second_task, label: second_label)}
  describe 'label登録' do
    context 'ログインした場合' do
    before do
      visit new_session_path
      fill_in 'Email', with: "xxxx@test.com"
      fill_in 'Password', with: "123456"
      click_button 'Log in'
    end
      it 'ラベルも同時に新規登録できる' do
        sleep(4)
        click_button '新規タスクを作成'
        fill_in 'task[task_name]', with: 'ハリー'
        fill_in 'task[detail]', with: 'ポッター'
        sleep(1)
        fill_in 'task[expired_at]', with:'2023/06/19/16:30'
        select '完了', from: 'task[status]'
        select '高', from: 'task[priority]'
        check 'check_id', match: :first
        click_button '登録する'
        expect(page).to have_content '新規タスクを作成しました!'
      end
      it '編集画面からラベルをつけることができる' do
        click_button '編集', match: :first
        check 'check_id', match: :first
        click_button '更新'
        expect(page).to have_content '編集しました'
        sleep(1)
      end
      it 'ラベルを絞り込める' do
        select '保留', from: 'label_id'
        click_button 'ラベル付きのタスクを絞り込むことができる'
        task_list = all('td')
        expect(page).to have_content '保留'
      end
    end
  end
end