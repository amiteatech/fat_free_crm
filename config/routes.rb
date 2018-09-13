# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Eatech CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
Rails.application.routes.draw do

  get 'tasks/find_user_task' => 'tasks#find_user_task'
  get 'tasks/download_task_file' => "tasks#download_task_file"
  get 'surper_task_report/task_super'

  get 'surper_task_report/report_super'

  post '/documents/:id/documents/update_files' => 'documents#update_files'
  resources :documents
  resources :access_on_forms
  resources :school_forms
  resources :form_types
  resources :supplementary_task_files
  resources :task_files
  resources :task_form_tag_values
  resources :school_item_numbers
  resources :task_years
  resources :task_form_tags
  resources :thrid_forms
  get 'report/index'
  post 'tasks/task_protected' => 'tasks#task_protected'

  resources :form_second_details
  resources :form_seconds
  resources :form_firsts
  resources :companies
  resources :user_tasks

  post '/tasks/:task_id/user_tasks/set_position' => 'user_tasks#set_position'

  resources :lists

  root to: 'tasks#index'
  get '/oauth2callback', to: 'tasks#set_google_drive_token'
  get 'show_files', to: 'tasks#show_files'
  get 'show_trails', to: 'tasks#show_trails'

  get 'activities' => 'home#index'
  get 'admin'      => 'admin/users#index',       :as => :admin
  get 'login'      => 'authentications#new',     :as => :login
  delete 'logout'  => 'authentications#destroy', :as => :logout
  get 'profile'    => 'users#show',              :as => :profile
  get 'signup'     => 'users#new',               :as => :signup
  get 'report'     => 'report#index',            :as => :report

  
  get '/home/options',  as: :options
  get '/home/toggle',   as: :toggle
  match '/home/timeline', as: :timeline, via: [:get, :put, :post]
  match '/home/timezone', as: :timezone, via: [:get, :put, :post]
  post '/home/redraw',   as: :redraw

  resource :authentication, except: [:index, :edit]
  resources :comments,       except: [:new, :show]
  resources :emails,         only: [:destroy]
  resources :passwords,      only: [:new, :create, :edit, :update]

  resources :accounts, id: /\d+/ do
    collection do
      get :advanced_search
      post :filter
      get :options
      get :field_group
      match :auto_complete, via: [:get, :post]
      get :redraw
      get :versions
    end
    member do
      put :attach
      post :discard
      post :subscribe
      post :unsubscribe
      get :contacts
      get :opportunities
    end
  end

  resources :campaigns, id: /\d+/ do
    collection do
      get :advanced_search
      post :filter
      get :options
      get :field_group
      match :auto_complete, via: [:get, :post]
      get :redraw
      get :versions
    end
    member do
      put :attach
      post :discard
      post :subscribe
      post :unsubscribe
      get :leads
      get :opportunities
    end
  end

  resources :contacts, id: /\d+/ do
    collection do
      get :advanced_search
      post :filter
      get :options
      get :field_group
      match :auto_complete, via: [:get, :post]
      get :redraw
      get :versions
    end
    member do
      put :attach
      post :discard
      post :subscribe
      post :unsubscribe
      get :opportunities
    end
  end

  resources :leads, id: /\d+/ do
    collection do
      get :advanced_search
      post :filter
      get :options
      get :field_group
      match :auto_complete, via: [:get, :post]
      get :redraw
      get :versions
      get :autocomplete_account_name
    end
    member do
      get :convert
      post :discard
      post :subscribe
      post :unsubscribe
      put :attach
      match :promote, via: [:patch, :put]
      put :reject
    end
  end

  resources :opportunities, id: /\d+/ do
    collection do
      get :advanced_search
      post :filter
      get :options
      get :field_group
      match :auto_complete, via: [:get, :post]
      get :redraw
      get :versions
    end
    member do
      put :attach
      post :discard
      post :subscribe
      post :unsubscribe
      get :contacts
    end
  end

  resources :tasks, id: /\d+/ do
    collection do
      post :filter
      match :auto_complete, via: [:get, :post]
    end
    member do
      put :complete
      put :uncomplete
      put :reject
      put :task_comment
      put :task_reject
      get :download_docx, format: 'docx'
      get :forgot_password
      get :edit_task_password
      post :change_task_password
    end
  end

  resources :users, id: /\d+/, except: [:index, :destroy] do
    member do
      get :avatar
      get :password
      match :upload_avatar, via: [:put, :patch]
      patch :change_password
      post :redraw
    end
    collection do
      match :auto_complete, via: [:get, :post]
      get :opportunities_overview
    end
  end

  namespace :admin do
    resources :groups

    resources :users do
      collection do
        match :auto_complete, via: [:get, :post]
      end
      member do
        get :confirm
        put :suspend
        put :reactivate
      end
    end

    resources :field_groups, except: [:index, :show] do
      collection do
        post :sort
      end
      member do
        get :confirm
      end
    end

    resources :fields do
      collection do
        match :auto_complete, via: [:get, :post]
        get :options
        get :redraw
        post :sort
        get :subform
      end
    end

    resources :tags, except: [:show] do
      member do
        get :confirm
      end
    end

    resources :fields, as: :custom_fields
    resources :fields, as: :core_fields

    resources :settings, only: :index
    resources :plugins,  only: :index
  end
end
