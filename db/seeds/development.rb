Article.create(title: 'タイトル1', sub_title: 'サブタイトル1', content: 'hoge')
Article.create(title: 'タイトル2', sub_title: 'サブタイトル2', content: 'hogehogehoge')
Article.create(title: 'タイトル3', sub_title: 'サブタイトル3', content: 'hoge')
Article.create(title: 'タイトル4', sub_title: 'サブタイトル4', content: 'hogehogehoge')
Article.create(title: 'タイトル5', sub_title: 'サブタイトル5', content: 'hoge')
Article.create(title: 'タイトル6', sub_title: 'サブタイトル6', content: 'hogehogehoge')
Article.create(title: 'タイトル7', sub_title: 'サブタイトル7', content: 'hoge')
Article.create(title: 'タイトル8', sub_title: 'サブタイトル8', content: 'hogehogehoge')

Area.create(name: '沼津(原)')
Area.create(name: '沼津(片浜)')
Area.create(name: '沼津(全般)')
Category.create(name: 'グルメ')
Category.create(name: '観光')

Article.all.ids.sort.each do |article_id|
  Area.all.ids.sort.each do |area_id|
    ArticleArea.create(article_id: article_id, area_id: area_id)
  end
end

Article.all.ids.sort.each do |article_id|
  Category.all.ids.sort.each do |category_id|
    ArticleCategory.create(article_id: article_id, category_id: category_id)
  end
end

user = User.new(:email => 'hogehoge@hoge.com', :password => 'hugahuga')
user.save!
