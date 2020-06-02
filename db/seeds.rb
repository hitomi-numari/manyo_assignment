# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Label.create!(
    name: 'イベント関連',
)
Label.create!(
    name: '会議',
)

Label.create!(
    name: '社内手続き',
)

Label.create!(
    name: 'プロジェクト案件',
)
