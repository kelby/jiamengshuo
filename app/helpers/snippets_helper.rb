module SnippetsHelper
  def cn_for_snippet_status(status)
    case status
    when 'approve'
      "已同意"
    when 'refuse'
      "已拒绝"
    else
      "待处理"
    end
  end
end
