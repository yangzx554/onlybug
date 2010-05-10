# coding: utf-8
module SeleniumlogsHelper
  def seleniumlog_state_name(status)
    case status
    when 1 then '通过'
    when 0 then '失败'     
    end
  end
end

