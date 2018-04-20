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

  private

  def from_address
    from = "crm1@kinnetik.co"
  end
end
