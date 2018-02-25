# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180225121931) do

  create_table "account_contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "account_id"
    t.integer  "contact_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["account_id", "contact_id"], name: "index_account_contacts_on_account_id_and_contact_id", using: :btree
  end

  create_table "account_opportunities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "account_id"
    t.integer  "opportunity_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["account_id", "opportunity_id"], name: "index_account_opportunities_on_account_id_and_opportunity_id", using: :btree
  end

  create_table "accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "assigned_to"
    t.string   "name",             limit: 64,    default: "",       null: false
    t.string   "access",           limit: 8,     default: "Public"
    t.string   "website",          limit: 64
    t.string   "toll_free_phone",  limit: 32
    t.string   "phone",            limit: 32
    t.string   "fax",              limit: 32
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",            limit: 254
    t.string   "background_info"
    t.integer  "rating",                         default: 0,        null: false
    t.string   "category",         limit: 32
    t.text     "subscribed_users", limit: 65535
    t.index ["assigned_to"], name: "index_accounts_on_assigned_to", using: :btree
    t.index ["user_id", "name", "deleted_at"], name: "index_accounts_on_user_id_and_name_and_deleted_at", unique: true, using: :btree
  end

  create_table "activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "subject_type"
    t.integer  "subject_id"
    t.string   "action",       limit: 32, default: "created"
    t.string   "info",                    default: ""
    t.boolean  "private",                 default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["created_at"], name: "index_activities_on_created_at", using: :btree
    t.index ["user_id"], name: "index_activities_on_user_id", using: :btree
  end

  create_table "addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "street1"
    t.string   "street2"
    t.string   "city",             limit: 64
    t.string   "state",            limit: 64
    t.string   "zipcode",          limit: 16
    t.string   "country",          limit: 64
    t.string   "full_address"
    t.string   "address_type",     limit: 16
    t.string   "addressable_type"
    t.integer  "addressable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.index ["addressable_id", "addressable_type"], name: "index_addresses_on_addressable_id_and_addressable_type", using: :btree
  end

  create_table "avatars", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "entity_type"
    t.integer  "entity_id"
    t.integer  "image_file_size"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campaigns", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "assigned_to"
    t.string   "name",                limit: 64,                             default: "",       null: false
    t.string   "access",              limit: 8,                              default: "Public"
    t.string   "status",              limit: 64
    t.decimal  "budget",                            precision: 12, scale: 2
    t.integer  "target_leads"
    t.float    "target_conversion",   limit: 24
    t.decimal  "target_revenue",                    precision: 12, scale: 2
    t.integer  "leads_count"
    t.integer  "opportunities_count"
    t.decimal  "revenue",                           precision: 12, scale: 2
    t.date     "starts_on"
    t.date     "ends_on"
    t.text     "objectives",          limit: 65535
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "background_info"
    t.text     "subscribed_users",    limit: 65535
    t.index ["assigned_to"], name: "index_campaigns_on_assigned_to", using: :btree
    t.index ["user_id", "name", "deleted_at"], name: "index_campaigns_on_user_id_and_name_and_deleted_at", unique: true, using: :btree
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.boolean  "private"
    t.string   "title",                          default: ""
    t.text     "comment",          limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",            limit: 16,    default: "Expanded", null: false
  end

  create_table "companies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "admin_id"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "country"
    t.string   "prime_contact"
    t.string   "prime_phone_number"
    t.boolean  "status"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "contact_opportunities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "contact_id"
    t.integer  "opportunity_id"
    t.string   "role",           limit: 32
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["contact_id", "opportunity_id"], name: "index_contact_opportunities_on_contact_id_and_opportunity_id", using: :btree
  end

  create_table "contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "lead_id"
    t.integer  "assigned_to"
    t.integer  "reports_to"
    t.string   "first_name",       limit: 64,    default: "",       null: false
    t.string   "last_name",        limit: 64,    default: "",       null: false
    t.string   "access",           limit: 8,     default: "Public"
    t.string   "title",            limit: 64
    t.string   "department",       limit: 64
    t.string   "source",           limit: 32
    t.string   "email",            limit: 254
    t.string   "alt_email",        limit: 254
    t.string   "phone",            limit: 32
    t.string   "mobile",           limit: 32
    t.string   "fax",              limit: 32
    t.string   "blog",             limit: 128
    t.string   "linkedin",         limit: 128
    t.string   "facebook",         limit: 128
    t.string   "twitter",          limit: 128
    t.date     "born_on"
    t.boolean  "do_not_call",                    default: false,    null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "background_info"
    t.string   "skype",            limit: 128
    t.text     "subscribed_users", limit: 65535
    t.index ["assigned_to"], name: "index_contacts_on_assigned_to", using: :btree
    t.index ["user_id", "last_name", "deleted_at"], name: "id_last_name_deleted", unique: true, using: :btree
  end

  create_table "emails", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "imap_message_id",                                    null: false
    t.integer  "user_id"
    t.string   "mediator_type"
    t.integer  "mediator_id"
    t.string   "sent_from",                                          null: false
    t.string   "sent_to",                                            null: false
    t.string   "cc"
    t.string   "bcc"
    t.string   "subject"
    t.text     "body",            limit: 65535
    t.text     "header",          limit: 65535
    t.datetime "sent_at"
    t.datetime "received_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",           limit: 16,    default: "Expanded", null: false
    t.index ["mediator_id", "mediator_type"], name: "index_emails_on_mediator_id_and_mediator_type", using: :btree
  end

  create_table "field_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       limit: 64
    t.string   "label",      limit: 128
    t.integer  "position"
    t.string   "hint"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tag_id"
    t.string   "klass_name", limit: 32
  end

  create_table "fields", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.integer  "field_group_id"
    t.integer  "position"
    t.string   "name",           limit: 64
    t.string   "label",          limit: 128
    t.string   "hint"
    t.string   "placeholder"
    t.string   "as",             limit: 32
    t.text     "collection",     limit: 65535
    t.boolean  "disabled"
    t.boolean  "required"
    t.integer  "maxlength"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pair_id"
    t.text     "settings",       limit: 65535
    t.index ["field_group_id"], name: "index_fields_on_field_group_id", using: :btree
    t.index ["name"], name: "index_fields_on_name", using: :btree
  end

  create_table "file_uploads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "task_id"
    t.string   "file"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "file_name"
    t.string   "content_type"
    t.binary   "file_contents", limit: 65535
  end

  create_table "form_firsts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "name_of_applicant"
    t.string   "position_applied_for"
    t.date     "part_a_first_interview_date"
    t.string   "interviewer_comment_first"
    t.string   "interviewer_comment_second"
    t.string   "interviewer_comment_others"
    t.date     "part_b_first_interview_date"
    t.string   "interviewer_comments"
    t.string   "part_c_name"
    t.string   "part_c_signature"
    t.date     "part_c_date"
    t.integer  "company_id"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "task_id"
    t.string   "part_c_name_1"
    t.string   "part_c_signatur_1"
    t.date     "part_c_date_1"
    t.string   "part_c_name_2"
    t.string   "part_c_signatur_2"
    t.date     "part_c_date_2"
  end

  create_table "form_second_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "week"
    t.string   "topic"
    t.string   "textbook"
    t.string   "teaching_activity"
    t.string   "teacher_remark"
    t.string   "supervisor_remark"
    t.integer  "form_second_id"
    t.integer  "position"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "form_seconds", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "module_title"
    t.string   "course"
    t.date     "course_date"
    t.integer  "module_toucht_by_id"
    t.integer  "company_id"
    t.integer  "user_id"
    t.integer  "task_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "week_1"
    t.string   "topic_1"
    t.string   "textbook_1"
    t.string   "teaching_activity_1"
    t.string   "teacher_remark_1"
    t.string   "supervisor_remark_1"
    t.string   "week_2"
    t.string   "topic_2"
    t.string   "textbook_2"
    t.string   "teaching_activity_2"
    t.string   "teacher_remark_2"
    t.string   "supervisor_remark_2"
    t.string   "week_3"
    t.string   "topic_3"
    t.string   "textbook_3"
    t.string   "teaching_activity_3"
    t.string   "teacher_remark_3"
    t.string   "supervisor_remark_3"
    t.string   "week_4"
    t.string   "topic_4"
    t.string   "textbook_4"
    t.string   "teaching_activity_4"
    t.string   "teacher_remark_4"
    t.string   "supervisor_remark_4"
    t.string   "week_5"
    t.string   "topic_5"
    t.string   "textbook_5"
    t.string   "teaching_activity_5"
    t.string   "teacher_remark_5"
    t.string   "supervisor_remark_5"
  end

  create_table "groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "group_id"
    t.integer "user_id"
    t.index ["group_id", "user_id"], name: "index_groups_users_on_group_id_and_user_id", using: :btree
    t.index ["group_id"], name: "index_groups_users_on_group_id", using: :btree
    t.index ["user_id"], name: "index_groups_users_on_user_id", using: :btree
  end

  create_table "leads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "campaign_id"
    t.integer  "assigned_to"
    t.string   "first_name",       limit: 64,    default: "",       null: false
    t.string   "last_name",        limit: 64,    default: "",       null: false
    t.string   "access",           limit: 8,     default: "Public"
    t.string   "title",            limit: 64
    t.string   "company",          limit: 64
    t.string   "source",           limit: 32
    t.string   "status",           limit: 32
    t.string   "referred_by",      limit: 64
    t.string   "email",            limit: 254
    t.string   "alt_email",        limit: 254
    t.string   "phone",            limit: 32
    t.string   "mobile",           limit: 32
    t.string   "blog",             limit: 128
    t.string   "linkedin",         limit: 128
    t.string   "facebook",         limit: 128
    t.string   "twitter",          limit: 128
    t.integer  "rating",                         default: 0,        null: false
    t.boolean  "do_not_call",                    default: false,    null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "background_info"
    t.string   "skype",            limit: 128
    t.text     "subscribed_users", limit: 65535
    t.index ["assigned_to"], name: "index_leads_on_assigned_to", using: :btree
    t.index ["user_id", "last_name", "deleted_at"], name: "index_leads_on_user_id_and_last_name_and_deleted_at", unique: true, using: :btree
  end

  create_table "lists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "url",        limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_lists_on_user_id", using: :btree
  end

  create_table "opportunities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "campaign_id"
    t.integer  "assigned_to"
    t.string   "name",             limit: 64,                             default: "",       null: false
    t.string   "access",           limit: 8,                              default: "Public"
    t.string   "source",           limit: 32
    t.string   "stage",            limit: 32
    t.integer  "probability"
    t.decimal  "amount",                         precision: 12, scale: 2
    t.decimal  "discount",                       precision: 12, scale: 2
    t.date     "closes_on"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "background_info"
    t.text     "subscribed_users", limit: 65535
    t.index ["assigned_to"], name: "index_opportunities_on_assigned_to", using: :btree
    t.index ["user_id", "name", "deleted_at"], name: "id_name_deleted", unique: true, using: :btree
  end

  create_table "permissions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "asset_type"
    t.integer  "asset_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.index ["asset_id", "asset_type"], name: "index_permissions_on_asset_id_and_asset_type", using: :btree
    t.index ["group_id"], name: "index_permissions_on_group_id", using: :btree
    t.index ["user_id"], name: "index_permissions_on_user_id", using: :btree
  end

  create_table "preferences", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "name",       limit: 32,    default: "", null: false
    t.text     "value",      limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id", "name"], name: "index_preferences_on_user_id_and_name", using: :btree
  end

  create_table "school_item_numbers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "company_id"
    t.boolean  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "session_id",               null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", using: :btree
    t.index ["updated_at"], name: "index_sessions_on_updated_at", using: :btree
  end

  create_table "settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       limit: 32,    default: "", null: false
    t.text     "value",      limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_settings_on_name", using: :btree
  end

  create_table "taggings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type", limit: 50
    t.string   "context",       limit: 50
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context"], name: "taggings_idx", unique: true, using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "task_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.string   "user_name"
    t.string   "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "task_form_tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.boolean  "status",     default: true
    t.integer  "company_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "task_years", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.boolean  "status",     default: true
    t.integer  "company_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "assigned_to"
    t.integer  "completed_by"
    t.string   "name",                             default: "",    null: false
    t.string   "asset_type"
    t.integer  "asset_id"
    t.string   "priority",           limit: 32
    t.string   "category",           limit: 32
    t.string   "bucket",             limit: 32
    t.datetime "due_at"
    t.datetime "completed_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "background_info"
    t.text     "subscribed_users",   limit: 65535
    t.string   "description"
    t.string   "task_created_by"
    t.integer  "task_created_id"
    t.integer  "company_id"
    t.boolean  "form_first"
    t.boolean  "form_second"
    t.boolean  "form_third"
    t.integer  "form_first_id"
    t.integer  "form_second_id"
    t.integer  "form_third_id"
    t.integer  "form_number"
    t.string   "task_status"
    t.string   "years"
    t.boolean  "is_cancelled",                     default: false
    t.integer  "task_year_id"
    t.integer  "task_form_tag_id"
    t.integer  "school_item_no_id"
    t.string   "school_item_no"
    t.string   "task_form_category"
    t.index ["assigned_to"], name: "index_tasks_on_assigned_to", using: :btree
    t.index ["user_id", "name", "deleted_at"], name: "index_tasks_on_user_id_and_name_and_deleted_at", unique: true, using: :btree
  end

  create_table "thrid_forms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "module_title"
    t.string   "module_syllabus_no"
    t.string   "course"
    t.string   "module_toucht_by"
    t.text     "relevent_information",              limit: 65535
    t.text     "student_performance",               limit: 65535
    t.text     "evaluation",                        limit: 65535
    t.text     "module_development",                limit: 65535
    t.string   "module_development_submitted_by"
    t.date     "module_development_submitted_date"
    t.text     "comments",                          limit: 65535
    t.string   "comments_name"
    t.string   "comments_signature"
    t.string   "comments_designation"
    t.string   "comments_date"
    t.integer  "task_id"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "user_tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.string   "comments"
    t.string   "files"
    t.integer  "position"
    t.string   "task_status"
    t.datetime "approved_time"
    t.datetime "rejected_time"
    t.boolean  "approved"
    t.boolean  "rejected"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "username",            limit: 32,  default: "",    null: false
    t.string   "email",               limit: 254, default: "",    null: false
    t.string   "first_name",          limit: 32
    t.string   "last_name",           limit: 32
    t.string   "title",               limit: 64
    t.string   "company",             limit: 64
    t.string   "alt_email",           limit: 254
    t.string   "phone",               limit: 32
    t.string   "mobile",              limit: 32
    t.string   "aim",                 limit: 32
    t.string   "yahoo",               limit: 32
    t.string   "google",              limit: 32
    t.string   "skype",               limit: 32
    t.string   "password_hash",                   default: "",    null: false
    t.string   "password_salt",                   default: "",    null: false
    t.string   "persistence_token",               default: "",    null: false
    t.string   "perishable_token",                default: "",    null: false
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.integer  "login_count",                     default: 0,     null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                           default: false, null: false
    t.datetime "suspended_at"
    t.string   "single_access_token"
    t.integer  "role"
    t.integer  "company_id"
    t.boolean  "super_admin",                     default: false
    t.boolean  "school_admin",                    default: false
    t.boolean  "school_user",                     default: false
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["perishable_token"], name: "index_users_on_perishable_token", using: :btree
    t.index ["persistence_token"], name: "index_users_on_persistence_token", using: :btree
    t.index ["username", "deleted_at"], name: "index_users_on_username_and_deleted_at", unique: true, using: :btree
  end

  create_table "versions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "item_type",                    null: false
    t.integer  "item_id",                      null: false
    t.string   "event",          limit: 512,   null: false
    t.string   "whodunnit"
    t.text     "object",         limit: 65535
    t.datetime "created_at"
    t.text     "object_changes", limit: 65535
    t.integer  "related_id"
    t.string   "related_type"
    t.integer  "transaction_id"
    t.index ["created_at"], name: "index_versions_on_created_at", using: :btree
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
    t.index ["related_id", "related_type"], name: "index_versions_on_related_id_and_related_type", using: :btree
    t.index ["transaction_id"], name: "index_versions_on_transaction_id", using: :btree
    t.index ["whodunnit"], name: "index_versions_on_whodunnit", using: :btree
  end

end
