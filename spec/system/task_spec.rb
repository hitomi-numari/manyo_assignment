require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    @user1 = create(:user)
    @user2 = create(:second_user)
    @task1 = create(:task, user: @user1)
    @task2 = create(:second_task, user: @user1)
    @task3 = create(:third_task, user: @user1)
    @label1 = create(:label)
    @label2 = create(:second_label)
    @label3 = create(:third_label)
    create(:labeling, task: @task1, label: @label1)
    create(:labeling, task: @task1, label: @label2)
    create(:labeling, task: @task1, label: @label3)
    visit root_path
    fill_in 'session_email', with: 'test_user_01@sample.com'
    fill_in "session_password", with: '00000000'
    find('input.click2').click
  end
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        visit tasks_path
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル２'
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル３'
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいる' do
        visit tasks_path
        task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content 'Factoryで作ったデフォルトのタイトル３'
        expect(task_list[1]).to have_content 'Factoryで作ったデフォルトのタイトル２'
        expect(task_list[2]).to have_content 'Factoryで作ったデフォルトのタイトル１'
      end
    end
    context '終了期限でソートをした場合' do
      it 'タスクが終了期限順に並んでいる' do
        visit tasks_path
        click_on '終了期限'
        visit tasks_path(sort_expired: "true")
        task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content 'Factoryで作ったデフォルトのタイトル３'
        expect(task_list[1]).to have_content 'Factoryで作ったデフォルトのタイトル２'
        expect(task_list[2]).to have_content 'Factoryで作ったデフォルトのタイトル１'
      end
    end
    context 'scopeメソッドで検索をした場合' do
      it "scopeメソッドでタイトル検索ができる" do
        visit tasks_path
        fill_in 'search_title', with: 'Factoryで作ったデフォルトのタイトル１'
        click_on '検索'
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
      end
      it "scopeメソッドでステータス検索ができる" do
        visit tasks_path
        select "着手中", from: "search_status"
        click_on '検索'
        expect(page).to have_content '着手中'
      end
      it "scopeメソッドでタイトルとステータスの両方が検索できる" do
        visit tasks_path
        fill_in 'search_title', with: "Factoryで作ったデフォルトのタイトル３"
        select "未着手", from: "search_status"
        click_on '検索'
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル３', "未着手"
      end
      it "scopeメソッドでラベル検索ができる" do
        visit tasks_path
        select "Factoryで作ったデフォルトのラベル２", from: "search_label_id"
        click_on '検索'
        expect(page).to have_content 'Factoryで作ったデフォルトのラベル２'
      end
      it "scopeメソッドでタイトル、ステータス、ラベル検索ができる" do
        visit tasks_path
        fill_in 'search_title', with: "Factoryで作ったデフォルトのタイトル１"
        select "着手中", from: "search_status"
        select "Factoryで作ったデフォルトのラベル１", from: "search_label_id"
        click_on '検索'
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１', "着手中"
        expect(page).to have_content "Factoryで作ったデフォルトのラベル１"
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_task_path
        fill_in '名前', with: '会議の準備'
        fill_in '詳細', with: '資料の作成'
        check "Factoryで作ったデフォルトのラベル１"
        check "Factoryで作ったデフォルトのラベル３"
        select '2020', from: 'task_deadline_1i'
        select '10', from: 'task_deadline_2i'
        select '5', from: 'task_deadline_3i'
        select '未着手', from: 'task_status'
        select '高', from: 'task_priority'
        click_on "登録"
        expect(page).to have_content '会議の準備'
        expect(page).to have_content '資料の作成'
        expect(page).to have_content "Factoryで作ったデフォルトのラベル１"
        expect(page).to have_content 'Factoryで作ったデフォルトのラベル３'
        expect(page).to have_content '2020/10/5'
        expect(page).to have_content '未着手'
        expect(page).to have_content '高'
      end
    end
  end

  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移する' do
         visit task_path(@task1.id)
         expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
         expect(page).to have_content 'Factoryで作ったデフォルトのコンテント１'
       end
     end
  end

end
