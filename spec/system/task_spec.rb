require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        task = FactoryBot.create(:task, title: 'task', content: 'task詳細')
        visit tasks_path
        expect(page).to have_content 'task'
        expect(page).to have_content 'task詳細'
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_task_path
        fill_in 'タスク名', with: '会議の準備'
        fill_in 'タスク詳細', with: '資料の作成'
        click_on "登録する"
        expect(page).to have_content '資料の作成'
      end
    end
  end

  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移する' do
         task_a = FactoryBot.create(:task, title: '訪問', content: '企画書作成')
         visit task_path(task_a)
         expect(page).to have_content '訪問', '企画書作成'
       end
     end
  end

end
