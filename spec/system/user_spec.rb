require 'rails_helper'
RSpec.describe 'ユーザ登録・ログイン・ログアウト機能', type: :system do
  before do
    user1 = create(:user)
    admin_user = create(:admin_user)
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
end
