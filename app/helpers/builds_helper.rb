# coding: utf-8
module BuildsHelper
  def build_status(status)
    case  status 
    when 1 then "结束"
    when 0 then "进行中"
   # else then "qit"
    end
  end
end
