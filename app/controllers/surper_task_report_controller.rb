class SurperTaskReportController < ApplicationController
  def task_super
  	@tasks = Task.all.order("id DESC")
  end

  def report_super
  	@tasks = Task.all.order("id DESC")
  	if  params[:xls] && (params[:xls] === "true")
  		download_xls
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
