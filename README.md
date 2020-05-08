# 要件
- 自分のタスクを簡単に登録したい
- タスクに終了期限を設定できるようにしたい
- タスクに優先順位をつけたい
- ステータス（未着手・着手・完了）を管理したい
- ステータスでタスクを絞り込みたい
- タスク名などで指定のタスクを検索したい
- タスクを一覧したい。一覧画面で（優先順位、終了期限などを元にして）ソートしたい
- タスクにラベルなどをつけて分類したい
- ユーザ登録し、自分が登録したタスクだけを見られるようにしたい

# データベース
____________

## Userテーブル
- string :name
- string :email
- string :password_digest

## Taskテーブル
- strig :title
- content :text
- deadline :date
- status :integer
- priority :integer
- user_id :bigint

## Labelテーブル
- name :string
- user_id :bigint

## Labelingテーブル
- task_id :bigint
- label_id :bigint

# Herokuへデプロイ

## コミットする
  git commitコマンドを使用して、コミットをします。
  ~/workspace/heroku_test_app (master) $ git add -A
  ~/workspace/heroku_test_app (master) $ git commit -m "コミットメッセージ"

## Herokuに新しいアプリケーションを作成します。
  ~/workspace/heroku_test_appに位置していることを確認して、Herokuに新しいアプリケーションを作成します。
  $ heroku create
  Creating app... done, ⬢ fierce-mountain-94329
  <https://fierce-mountain-94329.herokuapp.com/> | https://git.heroku.com/fierce-mountain-94329.git
  これで新しいアプリケーションが作成されました。
  上記の場合、
  https://fierce-mountain-94329.herokuapp.com/
  がアプリケーションのURLになります。URLは毎回異なります。


## Herokuにデプロイをする
- それではHerokuにデプロイしていきましょう。

## デプロイする前にアセットプリコンパイル する。（下記詳細）
  $ rake assets:precompile RAILS_ENV=production

  $git remote -v でherokuのpush先確認

  $ git push heroku master
  Counting objects: 92, done.
  Delta compression using up to 8 threads.
  Compressing objects: 100% (79/79), done.
  Writing objects: 100% (92/92), 22.60 KiB | 0 bytes/s, done.
  Total 92 (delta 2), reused 0 (delta 0)
  ~ (省略) ~
  remote: Verifying deploy... done.
  To https://git.heroku.com/fierce-mountain-94329.git
   * [new branch]      master -> master

  上記のように表示されれば成功です。

## 次に、データベースの移行を行います。
  $ heroku run rails db:migrate

## ブラウザで以下のURLにアクセスすれば起動します。
  createした際のURL
