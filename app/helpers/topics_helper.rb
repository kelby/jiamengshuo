module TopicsHelper
  def markdown_for(content)
    MarkdownTopicConverter.format(content)
  end

  def category_text_for(topic)
    case topic.category
    when "bai_shi"
      "拜师帖"
    when "shou_tu"
      "收徒帖"
    when "bai_shi_he_shou_tu"
      "拜师兼收徒帖"
    else "qita"
      "其它类型的帖子"
    end
  end
end
