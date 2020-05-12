
Area.create(name: '沼津(原)')
Area.create(name: '沼津(片浜)')
Area.create(name: '沼津(全般)')

Category.create(name: 'グルメ')
Category.create(name: '観光')


# user = User.new(:email => ENV['ADMIN_USER'], :password => ENV['ADMIN_PASSWORD'])
# user.save!

user = User.new(:email => 'hogehoge@hoge.com', :password => 'hugahuga')
user.save!
