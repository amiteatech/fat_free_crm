class SchoolMailer < ApplicationMailer
  def school_created_notification(entity, assigner, pwd, company)
    @entity_name = entity.name
    @assigner_name = assigner.name
    @admin_pwd = pwd
    @company_name = company.name

    mail subject: "Educert Process Control System: School '#{@company_name}' has been created.",
         to: entity.email,
         from: from_address
  end

  def task_assigned(entity, assigner, task_name, pwd)
    @entity_name = entity.name
    @assigner_name = assigner.name
    @task_title = task_name
    @password = pwd

    mail subject: "Educert Process Control System: Task '#{@task_title}' has been assigned to you.",
         to: entity.email,
         from: from_address
  end

  def task_available(entity, assigner, task_name)
    @entity_name = entity.name
    @assigner_name = assigner.name
    @task_title = task_name

    mail subject: "Educert Process Control System: Task '#{@task_title}' is available now.",
         to: entity.email,
         from: from_address
  end

  def task_completed(entity, completed_by_user, task_name)
    @entity_name = entity.name
    @user_name = completed_by_user.name
    @task_title = task_name

    mail subject: "Educert Process Control System: Task '#{@task_title}' is completed.",
         to: entity.email,
         from: from_address
  end

  def task_rejected(entity, rejected_by, task_name)
    @entity_name = entity.name
    @rejected_by = rejected_by.name
    @task_title = task_name

    mail subject: "Educert Process Control System: Task '#{@task_title}' is rejected.",
         to: entity.email,
         from: from_address
  end

  def task_password_changed(entity, rejected_by, task_name, password)
    @entity_name = entity.name
    @rejected_by = rejected_by.name
    @task_title = task_name
    @password = password

    mail subject: "Educert Process Control System: Password changed for task '#{@task_title}'",
         to: entity.email,
         from: from_address
  end

  # def task_password_reset(user, )
  #   @user = user.name
  #   @task_title = task_name
  #   mail subject: "Educert Process Control System: Password reset for task '#{@task_title}'",
  #        to: user.email,
  #        from: from_address
  # end

  def forgot_task_password(task_id)
    @task = Task.find(task_id)
    @task_password_url = edit_task_password_task_url(task_id)

    mail subject: "Educert Process Control System: " + I18n.t(:password_reset_instruction),
         to: User.find(@task.task_created_id).email,
         from: from_address,
         date: Time.now
  end

  private

  def from_address
    from = "autosmartzicreon@gmail.com"
  end
end
