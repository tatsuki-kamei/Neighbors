module ProductsHelper
  def render_with_hashtags(content)
    content.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/product/hashtag/#{word.delete("#")}"}.html_safe
  end 	
end
