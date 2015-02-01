module TopicsHelper
  def markdown_for(content)
    MarkdownTopicConverter.format(content)
  end
end
