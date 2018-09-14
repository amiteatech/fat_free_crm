class ReportController < ApplicationController
  def index
    if current_user.is_super_admin?
      @search = Task.all.ransack(view_context.empty_blank_params params[:q])
    elsif current_user.is_admin?
  	  @search = Task.where(:company_id => current_user.company_id).ransack(view_context.empty_blank_params params[:q])
    elsif current_user
      user_group = []
      
      current_user.groups.each do |group|
        group.users.each do |user|
          user_group << user.id
        end
      end

      user_group << current_user.id

      arr = UserTask.where(:user_id => user_group).map{|s|s.task_id}

   
      
      
      @tasks = Task.where(id: arr).order("id DESC")
      @search = @tasks.ransack(view_context.empty_blank_params params[:q])
    else
      @search = Task.where(:company_id => current_user.company_id).where(task_created_id: current_user.id).order("id DESC").ransack(view_context.empty_blank_params params[:q])
    end

    @tasks = @search.result(distinct: true).includes(:user_tasks).includes(:option_values).order("id DESC")
    
    @task_form_tag_values = TaskFormTagValue.where(:company_id => current_user.company_id)
    
    if (params[:commit] && params[:commit] === "Download to excel")
      download_xls
    end
  	# @tasks = Task.where(:company_id => current_user.company_id).order("id desc")
  	respond_to do |format|
		  format.html
		  # format.csv { send_data @tasks.to_csv }
		  # format.xls 
		end
  end

  def download_xls
    book = Spreadsheet::Workbook.new
    sheet = SheetWrapper.new(book.create_worksheet)
    sheet.add_row ['Number', 'Task Title', 'Type', 'Form', 'Year', 'Edutrust Item Number', 'Due date', 'Staff', 'Status']

    @tasks.each do |task|
      task_name = ""
      if task.user.present? && (task.user.id != current_user.id)
        task_name = t(:task_from, h(task.user.full_name)).html_safe << ':'
      end
      task_name += task.name

      staff = ''
      task.user_tasks.where.not(id: task.task_created_id).each do |user_task|
          @user = User.find(user_task.user_id)
          staff += @user.name 
          staff += (task.user_tasks.where.not(id: task.task_created_id).last == user_task) ? "" : ",   "
        end 

      sheet.add_row [task.id,
      task_name,
      if task.task_form_tag_id.present?
        if TaskFormTag.where(id: task.task_form_tag_id).first.present?
          TaskFormTag.where(id: task.task_form_tag_id).first.name
        end
      end,
      '',
      '',
      '',
      if task.due_at.present?
        task.due_at.strftime('%Y-%m-%d %H:%M')
      end,
      staff,
      task.task_status]
    end

    bold = Spreadsheet::Format.new weight: :bold
    9.times do |x|
      book.worksheets[0].row(0).set_format(x,
                                           bold)
    end

    data = StringIO.new ''
    book.write data
    send_data data.string,
              type: "application/excel",
              disposition: 'attachment',
              filename: 'report.xls'
  end
end
