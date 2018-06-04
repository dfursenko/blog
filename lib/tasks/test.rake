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
  desc 'Filling content from Habr'
  task parse_habr: :environment do
    require 'nokogiri'
    require 'open-uri'

    Category.destroy_all
    Tag.destroy_all
    User.destroy_all
    Article.destroy_all
    Comment.destroy_all

    page = Nokogiri::HTML(open('https://habr.com/top/'))
    page.css('.post__title_link').each do |article|
      article_page = Nokogiri::HTML(open(article['href']))

      # Categories
      categories = article_page.css('.post__hubs .hub-link').children.map(&:to_s)
      categories.each do |category|
        Category.create!(name: category) unless Category.exists?(name: category)
      end

      # Tags
      tags = article_page.css('.post__tags .post__tag').children.map(&:to_s)
      tags.each do |tag|
        Tag.create!(name: tag) unless Tag.exists?(name: tag)
      end

      # Users
      users = article_page.css('.user-info__nickname_small').children.map(&:to_s)
      users.each do |user|
        User.create!(name: user, email: "#{user}@email.ru") unless User.exists?(name: user)
      end

      # Article
      # :title, :text, :image, :category_id, tag_ids: []
      # title = article_page.css('.post__title-text').text
      # text = article_page.css('.post__text-html').text
      image_src = article_page.css('.post__text-html img').first
      image = image_src.nil? ? '' : image_src['src']
      # category_id = Category.find_by(name: categories.first).id
      # tag_ids = Tag.where(name: [tags]).pluck(:id)
      hash_article = {
          title: article_page.css('.post__title-text').text,
          text: article_page.css('.post__text-html').text,
          image: image,
          category_id: Category.find_by(name: categories.first).id,
          tag_ids: Tag.where(name: [tags]).pluck(:id),
          user_id: User.find_by(name: users.first).id
      }
      article = Article.create!(hash_article)
      # p article

      # Comments
      comments = article_page.css('.comment')#.children.map(&:to_s)
      comments.each do |comment|
        commenter = comment.css('.user-info__nickname_comment').text
        message = comment.css('.comment__message').text
        article.comments.create({commenter: commenter, message: message})
      end




      # categories = Category.pluck(:id)
    #   # Рубрики есть
    #   # Метки есть
    #   # Пользователи есть
    #   # Статья есть
    #   # Комменты
    #   #
    #   # Каков порякдок работы?
    #       Категории
    #       Теги
    #       Пользователи
    #       Статья
    #       Комментарии
    end
  end
end