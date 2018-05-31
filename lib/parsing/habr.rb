require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open('https://habr.com/search/?target_type=posts&q=ruby&order_by=date'))
page.css('.post__title_link').each do |article|
  article_page = Nokogiri::HTML(open(article['href']))
  image = article_page.css('.post__text-html img').first
  image_src = image.nil? ? '' : image['src']
  categories = Category.pluck(:id)
  hash_article = {
      title: article_page.css('.post__title-text').text,
      text: article_page.css('.post__text-html').text,
      image: image_src,
      category_id: categories[rand(3)]
  }

  Article.create!(hash_article)
  puts hash_article[:title]
end
