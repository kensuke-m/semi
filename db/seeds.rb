# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name: 'admin', password_digest: BCrypt::Password.create('iyahaya')) # YOU SHOULD CHANGE THE PASSWORD

Course.create(name: '現代社会')
Course.create(name: '国際社会')
Course.create(name: '情報システム')

g = Course.find_by_name('現代社会')
k = Course.find_by_name('国際社会')
j = Course.find_by_name('情報システム')

Staff.create(username: 'toritani', lastname: '鳥谷', firstname: '一生', kana: 'とりたにいっしょう', course_id: k.id)