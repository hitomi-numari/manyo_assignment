#要件
自分のタスクを簡単に登録したい
タスクに終了期限を設定できるようにしたい
タスクに優先順位をつけたい
ステータス（未着手・着手・完了）を管理したい
ステータスでタスクを絞り込みたい
タスク名などで指定のタスクを検索したい
タスクを一覧したい。一覧画面で（優先順位、終了期限などを元にして）ソートしたい
タスクにラベルなどをつけて分類したい
ユーザ登録し、自分が登録したタスクだけを見られるようにしたい

#データベース
____________

##Userテーブル
  string :name
  string :email
  string :password_digest

##Taskテーブル
  strig :title
  content :text
  deadline :date
  status :integer
  priority :integer
  user_id :bigint

##Labelテーブル
  name :string
  user_id :bigint

##Labelingテーブル
  task_id :bigint
  label_id :bigint
