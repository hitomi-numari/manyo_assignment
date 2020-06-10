# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ title: 'Star Wars' }, { title: 'Lord of the Rings' }])
#   Character.create(title: 'Luke', movie: movies.first)

User.create!(
    name: 'パパ(管理ユーザー)',
    email: 'papa@gmail.com',
    password: '000000',
    password_confirmation: '000000',
    admin: 'true',
    )

User.create!(
    name: 'ママ(一般ユーザー)',
    email: 'mama@gmail.com',
    password: '123456',
    password_confirmation: '123456',
    )

Task.create!(
    title: '予防接種（生後2ヶ月)',
    content: 'ヒブ・肺炎球菌・B型肺炎・ロタ',
    deadline: '2020-05-18 13:00:00',
    status: 'completed',
    priority: 'high',
    user_id: 2,
)

Task.create!(
    title: '予防接種（生後3ヶ月)',
    content: 'ヒブ・肺炎球菌・B型肺炎・ロタ・四種混合',
    deadline: '2020-06-15 13:00:00',
    status: 'no_started',
    priority: 'high',
    user_id: 2,
)

Task.create!(
    title: '予防接種（生後4ヶ月)',
    content: 'ヒブ・B型肺炎・ロタ・四種混合',
    deadline: '2020-07-20 13:00:00',
    status: 'no_started',
    priority: 'high',
    user_id: 2,
)

Task.create!(
    title: '保育園申請',
    content: 'A保育園',
    deadline: '2020-06-05 08:00:00',
    status: 'in_progress',
    priority: 'middle',
    user_id: 2,
)

Task.create!(
    title: '保育園見学',
    content: 'A保育園',
    deadline: '2020-05-25 15:00:00',
    status: 'completed',
    priority: 'low',
    user_id: 2,
)

Task.create!(
    title: '出張',
    content: '中国',
    deadline: '2020-07-20 00:00:00',
    status: 'no_started',
    priority: 'middle',
    user_id: 1,
)

Task.create!(
    title: '出張申請',
    content: '日程表作成',
    deadline: '2020-07-01 10:00:00',
    status: 'in_progress',
    priority: 'middle',
    user_id: 1,
)

Task.create!(
    title: '友人の結婚式',
    content: '品川プリンスホテルにて参列',
    deadline: '2020-07-12 15:00:00',
    status: 'no_started',
    priority: 'high',
    user_id: 2,
)

Task.create!(
    title: '育児',
    content: 'ママ不在の為',
    deadline: '2020-07-12 15:00:00',
    status: 'no_started',
    priority: 'low',
    user_id: 1,
)

Task.create!(
    title: 'パパのパジャマを買う',
    content: '夏物のパジャマ',
    deadline: '2020-07-20 00:00:00',
    status: 'no_started',
    priority: 'low',
    user_id: 2,
)

Label.create!(
    name: '仕事',
)
Label.create!(
    name: '家族',
)

Label.create!(
    name: '子供',
)

Label.create!(
    name: 'オフ',
)

Labeling.create!(
    task_id: 1,
    label_id: 3,
)

Labeling.create!(
    task_id: 2,
    label_id: 3,
)

Labeling.create!(
    task_id: 3,
    label_id: 3,
)

Labeling.create!(
    task_id: 4,
    label_id: 3,
)

Labeling.create!(
    task_id: 5,
    label_id: 3,
)

Labeling.create!(
    task_id: 6,
    label_id: 1,
)

Labeling.create!(
    task_id: 7,
    label_id: 1,
)

Labeling.create!(
    task_id: 8,
    label_id: 4,
)

Labeling.create!(
    task_id: 9,
    label_id: 2,
)

Labeling.create!(
    task_id: 10,
    label_id: 2,
)
