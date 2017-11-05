# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name: 'admin', password_digest: BCrypt::Password.create('iyahaya')) # YOU SHOULD CHANGE THE PASSWORD

Subject.create(name: '基礎演習II')
Subject.create(name: '演習I')
Subject.create(name: '演習II')
Subject.create(name: '演習III')

Course.create(name: '現代社会')
Course.create(name: '国際社会')
Course.create(name: '情報システム')

g = Course.find_by_name('現代社会')
k = Course.find_by_name('国際社会')
j = Course.find_by_name('情報システム')

Staff.create(username: 'kido', lastname: '城戸', firstname: '英樹', kana: 'きどひでき', course_id: k.id)
Staff.create(username: 'toda', lastname: '戸田', firstname: '真紀子', kana: 'とだまきこ', course_id: k.id)
Staff.create(username: 'toritani', lastname: '鳥谷', firstname: '一生', kana: 'とりたにいっしょう', course_id: k.id)
Staff.create(username: 'matsudas', lastname: '松田', firstname: '哲', kana: 'まつださとし', course_id: k.id)
Staff.create(username: 'matsummi', lastname: '松本', firstname: '充豊', kana: 'まつもとみつとよ', course_id: k.id)
Staff.create(username: 'na', lastname: 'ネイティブ助教A', firstname: '', kana: 'ねいてぃぶじょきょうA', course_id: k.id)
Staff.create(username: 'nb', lastname: 'ネイティブ助教B', firstname: '', kana: 'ねいてぃぶじょきょうB', course_id: k.id)
Staff.create(username: 'eguchi', lastname: '江口', firstname: '聡', kana: 'えぐちさとし', course_id: g.id)
Staff.create(username: 'okuia', lastname: '奥井', firstname: '亜紗子', kana: 'おくいあさこ', course_id: g.id)
Staff.create(username: 'kakeya', lastname: '掛谷', firstname: '純子', kana: 'かけやじゅんこ', course_id: g.id)
Staff.create(username: 'kanekom', lastname: '金子', firstname: '充', kana: 'かねこみつる', course_id: g.id)
Staff.create(username: 'kamoto', lastname: '嘉本', firstname: '伊都子', kana: 'かもといつこ', course_id: g.id)
Staff.create(username: 'kudom', lastname: '工藤', firstname: '正子', kana: 'くどうまさこ', course_id: g.id)
Staff.create(username: 'sakadume', lastname: '坂爪', firstname: '聡子', kana: 'さかづめさとこ', course_id: g.id)
Staff.create(username: 'sawa', lastname: '澤', firstname: '敬子', kana: 'さわけいこ', course_id: g.id)
Staff.create(username: 'shimoda', lastname: '霜田', firstname: '求', kana: 'しもだもとむ', course_id: g.id)
Staff.create(username: 'suwa', lastname: '諏訪', firstname: '亜紀', kana: 'すわあき', course_id: g.id)
Staff.create(username: 'nakatake', lastname: '中田', firstname: '兼介', kana: 'なかたけんすけ', course_id: g.id)
Staff.create(username: 'nakamich', lastname: '中道', firstname: '仁美', kana: 'なかみちひとみ', course_id: g.id)
Staff.create(username: 'nishio', lastname: '西尾', firstname: '久美子', kana: 'にしおくみこ', course_id: g.id)
Staff.create(username: 'hamasaki', lastname: '濱崎', firstname: '由紀子', kana: 'はまさきゆきこ', course_id: g.id)
Staff.create(username: 'fujiita', lastname: '藤井', firstname: '隆道', kana: 'ふじいたかみち', course_id: g.id)
Staff.create(username: 'masakid', lastname: '正木', firstname: '大貴', kana: 'まさきだいき', course_id: g.id)
Staff.create(username: 'morihisa', lastname: '森久', firstname: '聡', kana: 'もりひささとし', course_id: g.id)
Staff.create(username: 'watari', lastname: '亘', firstname: '明志', kana: 'わたりあけし', course_id: g.id)
Staff.create(username: 'noguchi', lastname: '野口', firstname: '実', kana: 'のぐちみのる', course_id: g.id)
Staff.create(username: 'nakayama', lastname: '中山', firstname: '貴夫', kana: 'なかやまたかお', course_id: j.id)
Staff.create(username: 'maruno', lastname: '丸野', firstname: '由希', kana: 'まるのゆき', course_id: j.id)
Staff.create(username: 'mizuno', lastname: '水野', firstname: '義之', kana: 'みずのよしゆき', course_id: j.id)
Staff.create(username: 'michikos', lastname: '道越', firstname: '秀吾', kana: 'みちこししゅうご', course_id: j.id)
Staff.create(username: 'miyasita', lastname: '宮下', firstname: '健輔', kana: 'みやしたけんすけ', course_id: j.id)
