module ApplicationHelper
  def comments_pluralize(count)
    def my_plural(count, one, two, three)
      i = count.to_s.split('').last.to_i
      if i == 1
        one
      elsif [2, 3, 4].include? i
        two
      else
        three
      end
    end

    my_plural(count, 'комментарий', 'комментария', 'комментариев')
  end
end
