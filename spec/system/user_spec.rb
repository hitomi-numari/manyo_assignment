require 'rails_helper'
RSpec.describe 'ユーザ登録・ログイン・ログアウト機能', type: :system do
  before do
    user1 = create(:user)
    user2 = create(:second_user)
  end
  describe 'ユーザ登録のテスト' do
    context 'ユーザのデータがなくログインしていない場合' do
      it 'ユーザ新規登録のテスト' do
        visit new_session_path
        visit new_user_path
        fill_in 'user[name]', with: 'test_user_01'
        fill_in 'user[email]', with: 'test_user_01@dic.com'
        fill_in 'user[password]', with: '00000000'
        fill_in 'user[password_confirmation]', with: '00000000'
        click_on '登録'
        expect(page).to have_content 'マイページ'
        expect(page).to have_content 'test_user_01のページ'
      end
      it 'ログインしていない時はログイン画面に飛ぶテスト' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end
end
