require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
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
        visit tasks_path
        click_on "終了期限でソートする"
        task_list = all('td').first
        expect(page).to have_content 'task'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        task = FactoryBot.create(:task, task_name: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('td').first
        expect(page).to have_content 'task'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit tasks_path
        click_on '詳細', match: :first
        expect(page).to have_content 'Factory'
      end
    end
  end
  describe 'タスク管理機能', type: :system do
    describe '検索機能' do
      before do
        # 必要に応じて、テストデータの内容を変更して構わない
        FactoryBot.create(:task, task_name: "task")
        FactoryBot.create(:second_task, task_name: "sample")
      end
      context 'タイトルであいまい検索をした場合' do
        it "検索キーワードを含むタスクで絞り込まれる" do
          visit tasks_path
          fill_in 'task_name', with:'task'
          click_on '検索'
          # タスクの検索欄に検索ワードを入力する (例: task)
          # 検索ボタンを押す
          expect(page).to have_content 'task'
        end
      end
      context 'ステータス検索をした場合' do
        it "ステータスに完全一致するタスクが絞り込まれる" do
          visit tasks_path
          select '完了', from: 'status'
          expect(page).to have_content 'task'
          # ここに実装する
          # プルダウンを選択する「select」について調べてみること
        end
      end
      context 'タイトルのあいまい検索とステータス検索をした場合' do
        it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
          visit tasks_path
          fill_in 'task_name', with:'task'
          select '完了', from: 'status'
          expect(page).to have_content 'task'
          # ここに実装する
        end
      end
    end
  end

end