User.destroy_all
Article.destroy_all
Comment.destroy_all

hash_users = 10.times.map do
  {
    name: FFaker::Internet.user_name[0...16],
    email: FFaker::Internet.safe_email
  }
end
users = User.create! hash_users
users.first(7).each { |u| u.update creator: true }
users.first(2).each { |u| u.update moderator: true }

creators = User.where(creator: true)
categories = Category.all
hash_articles = 20.times.map do
  {
    title: FFaker::HipsterIpsum.paragraph[0..25],
    text: FFaker::HipsterIpsum.paragraphs,
    category_id: categories.sample.id,
    user_id: creators.sample.id
  }
end
articles = Article.create! hash_articles

hash_comments = 200.times.map do
  {
      message: FFaker::HipsterIpsum.paragraphs,
      commenter: users.sample.name,
      article_id: articles.sample.id
  }
end
Comment.create! hash_comments