# coding: utf-8
module ApplicationHelper
  def error_messages_on(object, method, options = {})
    html = {}
    options.stringify_keys!
    ['id', 'class'].each do |key|
      if options.include?(key)
        value = options[key]
        html[key] = value unless value.blank?
      else
        html[key] = 'errorExplanation'
      end
    end
    name = options['method_name'] ||= method.to_s.humanize.capitalize
    if (obj = instance_variable_get("@#{object}")) && (errors = obj.errors.on(method))
      [errors].flatten!
      content_tag(:div,
        content_tag(:ul, errors.map {|msg| content_tag(:li, "#{name} #{msg}") }),
        html
      )
    else 
      ''
    end
  end
  def less_remote_form_for name, *args, &block
    options = args.last.is_a?(Hash) ? args.pop : {}
    options = options.merge(:builder=>LessFormBuilder)
    args = (args << options)
    remote_form_for name, *args, &block
  end
  
  def display_standard_flashes(message = '这里有些问题需要你的注意')
#    if flash[:notice]
#      flash_to_display, level = flash[:notice], 'notice'
#    elsif flash[:warning]
#      flash_to_display, level = flash[:warning], 'warning'
#    elsif flash[:error]
#      level = 'error'
#      if flash[:error].instance_of?( ActiveRecord::Errors) || flash[:error].is_a?( Hash)
#        flash_to_display = message
#        flash_to_display << activerecord_error_list(flash[:error])
#      else
#        flash_to_display = flash[:error]
#      end
#    else
#      return
#    end
#    content_tag 'div', flash_to_display, :id => "flash-#{level}"
  end

  def activerecord_error_list(errors)
    error_list = '<ul class="error_list">'
    error_list << errors.collect do |e, m|
      "<li> #{m}</li>"
    end.to_s << '</ul>'
    error_list
  end
  def photo_url
    
  end
  def distance_of_time_in_words(from_time)
    from_time = from_time.to_time 
    to_time = Time.new.to_time 
    distance_in_minutes = (((to_time - from_time).abs)/60).round
    case distance_in_minutes
    when 0           then  "#{(to_time - from_time).round}秒前"
    when 1..60       then  "#{distance_in_minutes}分钟前"
    when 60..1440    then  "#{(distance_in_minutes/60).round}小时前"
    else from_time.strftime("%Y-%m-%d %H:%M")
    end
  end
  def state_name(state)
    case state
    when 0 then "新建"
    when 1 then "打开"
    when 2 then "接受"
    when 3 then "修复"
    when 4 then "重新打开"
    when 5 then "关闭"
    when 6 then "打回"
    end
  end
  def state_select()
    @state = {"新建" => 0 ,"打开" =>1,"接受"=>2,"修复"=>3,"重新打开"=>4,"关闭"=>5,"打回"=>6}
  end
  def selenium_log(status)
    case status 
    when 0 then "失败"
    when 1 then "通过"
    end
  end
  def event_view(event)
    event_display =  '<li class="event clear">'
    user = User.get_cache(event.user_id)
    p = Project.get_cache(event.project_id)
    event_display << link_to(image_tag(user.photo.public_filename(:tiny),:class =>"avatar"),user_path(user))
    event_view_date(event_display,event.created_at)
    case event.type_id
    when 1 then
      ticket = Ticket.get_cache(event.content_id)
      event_display <<  link_to(ticket.title,project_ticket_path(p,ticket))
      if event.operate_id ==1
      event_display << 'was create by'
      elsif  event.operate_id ==2
        event_display << 'was update by'
      end
      event_display << link_to(user.name,user_path(user))
      event_display << '<p class="emeta">'
      event_display <<  link_to(ticket.id,project_ticket_path(p,ticket))
      event_display << '/'
      event_display <<  link_to(p.name,project_path(p))
      event_display << '/'
      event_display << '<span class="tstate" style="color: rgb(255, 17, 119);">'
      event_display << state_name(event.status)
      event_display << '</span>'
      event_display << '</p>'
      event_display << '<span class="etype eticket">ticket</span>'
      when 2
      then  event_display  << '<span class="etype eproject">project</span>'

    end
    event_display
  end
  def event_view_date(event_display,from_time)
    event_display << '<p class="day-break"><span class="day">'
    event_display << from_time.strftime("%a")
    event_display << '</span>'
    event_display << '<span class="num">'
    event_display << from_time.strftime("%b")
    event_display << ' '
    event_display << from_time.strftime("%d")
    event_display << '</span></p>'
  end
end
