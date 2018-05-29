namespace :blog do
  desc 'Counts the number of ruby-files in the project'
  task count_files: :environment do
    puts Dir.glob('./**/*.rb').length
  end
end

namespace :blog do
  desc 'Counts the number of ruby-file strings in the project'
  task count_strings: :environment do
    strings = 0
    Dir.glob('./**/*.rb').each do |file|
      File.readlines(file).each do |string|
        strings += 1
      end
    end
    puts strings
  end
end

namespace :blog do
  desc 'Parse Habr for articles'
  task parse_habr: :environment do
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
      # p categories[rand(3)]
      Article.create!(hash_article)
      puts hash_article[:title]
    end
  end
end