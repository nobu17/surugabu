# frozen_string_literal: true

# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'https://surugabu.com'

SitemapGenerator::Sitemap.create do
  add about_path, priority: 0.5

  Article.find_each do |article|
    add "articles/#{article.id}", lastmod: article.updated_at
  end

  Area.find_each do |area|
    add "articles/pages/1?area=#{area.id}", lastmod: area.updated_at
  end

  Category.find_each do |category|
    add "articles/pages/1?category=#{category.id}", lastmod: category.updated_at
  end
end
