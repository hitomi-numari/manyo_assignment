module TasksHelper
  def status_view(type)
    case type
    when 1
        "未着手"
      when 2
        "着手"
      when 3
        "完了"
      else
        puts "非表示"
    end
  end

  def priority_view(type)
    case type
    when 1
        "低"
      when 2
        "中"
      when 3
        "高"
      else
        puts "非表示"
    end
  end
end
