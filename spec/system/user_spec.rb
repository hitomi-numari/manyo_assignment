require 'rails_helper'
RSpec.describe 'ユーザ登録・ログイン・ログアウト機能', type: :system do
  before do
    @user1 = create(:user)
    @user2 = create(:second_user)
  end
  describe 'ユーザ登録のテスト' do
    context 'ユーザのデータがなくログインしていない場合' do
      it 'ユーザ新規登録のテスト' do
        visit new_session_path
        visit new_user_path
        fill_in 'user[name]', with: 'taro'
        fill_in 'user[email]', with: 'taro@taro.com'
        fill_in 'user[password]', with: '12345678'
        fill_in 'user[password_confirmation]', with: '12345678'
        click_on '登録'
        expect(page).to have_content 'マイページ'
        expect(page).to have_content 'taroのページ'
      end
      it 'ログインしていない時はログイン画面に飛ぶテスト' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end
  describe 'セッション機能テスト' do
    before do
      visit root_path
      fill_in 'session_email', with: 'test_user_01@sample.com'
      fill_in "session_password", with: '00000000'
      find('input.click2').click
    end
    context 'ログインする場合' do
      it 'タスク一覧ページに飛べるか' do
        expect(page).to have_content 'タスク一覧'
        expect(page).to have_content '絞り込み'
      end
      it '自分の詳細ページに飛べるか' do
        visit user_path(@user1.id)
        expect(page).to have_content '名前test_user_01'
        expect(page).to have_content 'メールアドレスtest_user_01@sample.com'
      end
    end
    context '一般ユーザーが他人の詳細ページに遷移しようとする場合' do
      it 'タスク一覧に遷移するか' do
        visit user_path(@user2.id)
        expect(current_path).to eq tasks_path
      end
    end
    context 'ログアウトする場合' do
      it 'ログイン画面に戻るか' do
        click_link 'ログアウト'
        expect(current_path).to eq root_path
      end
    end
  end
  describe '管理画面テスト' do
    before do
      visit root_path
      fill_in 'session_email', with: 'test_user_02@sample.com'
      fill_in "session_password", with: '00000000'
      find('input.click2').click
      visit admin_users_path
    end
    context '管理者の場合' do
      it '管理画面にアクセスできるか' do
        expect(page).to have_content 'ユーザー一覧'
        expect(page).to have_content 'test_user_01'
        expect(page).to have_content 'test_user_02'
      end
      it '新規登録できること' do
        click_on '新規作成'
        visit new_admin_user_path
        fill_in 'user[name]', with: 'taro'
        fill_in 'user[email]', with: 'taro@taro.com'
        check 'user_admin'
        fill_in 'user[password]', with: '12345678'
        fill_in 'user[password_confirmation]', with: '12345678'
        click_on '登録'
        expect(page).to have_content 'hanako', 'true'
        expect(page).to have_content 'ユーザーを作成しました'
      end
      it '他人の詳細画面にアクセスできること' do
        visit admin_user_path(@user1.id)
        expect(page).to have_content 'test_user_01のページ'
        expect(page).to have_content '管理人:false'
      end
      it '他人のユーザー編集ができること' do
        click_link "編集", match: :first
        fill_in 'user[name]', with: 'hanako'
        fill_in 'user[email]', with: 'hanako@hanako.com'
        check 'user_admin'
        fill_in 'user[password]', with: '12345678'
        fill_in 'user[password_confirmation]', with: '12345678'
        click_on '登録'
        expect(page).to have_content 'hanako', 'true'
        expect(page).to have_content 'ユーザーを編集しました'
      end
      it '他人のユーザーを削除できること' do
        click_link "削除", match: :first
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'ユーザーを削除しました'
      end
    end
    context '一般ユーザーの場合' do
      it '管理画面にアクセスできないこと' do
        visit root_path
        fill_in 'session_email', with: 'test_user_01@sample.com'
        fill_in "session_password", with: '00000000'
        find('input.click2').click
        visit admin_users_path
        expect(current_path).to eq root_path
      end
    end
  end
end
