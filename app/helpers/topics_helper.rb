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
    #   "其它类型的帖子"
      "拼单"
    end
  end

  def cn_for(freight_source)
    case freight_source
    when 'mainland'
      "国内"
    when 'america'
      "美国"
    when 'hongkong'
      "香港"
    when 'korea'
      "韩国"
    when 'japan'
      "日本"
    when 'macao'
      "澳门"
    when 'australia'
      "澳大利亚"
    when 'europe'
      "欧洲"
    end
  end

  def cn_for_category(category)
    case category
    when 'pi_fa'
      "批发"
    when 'ding_zhuo'
      "定做"
    when 'hai_tao'
      "海淘"
    end
  end

  def cn_for_invoice(invoice)
    case invoice
    when 'not_sure'
      "不确定"
    when 'yes'
      "提供发票"
    when 'no'
      "无发票"
    end
  end

  def cn_for_rate(rate)
    rate ||= "无"
    rate
  end

  def cn_for_status(status)
    case status
    when 'shopping_end'
      "已下单"
    when 'shopping_finish'
      "已完成"
    else
      "拼单中"
    end
  end

  def cn_for_freight_source(freight_source)
    case freight_source
    when 'mainland'
      "国内"
    when 'america'
      "美国"
    when 'hongkong'
      "香港"
    when 'korea'
      "韩国"
    when 'japan'
      "日本"
    when 'macao'
      "澳门"
    when 'australia'
      "澳大利亚"
    when 'europe'
      "欧洲"
    end
  end
end
