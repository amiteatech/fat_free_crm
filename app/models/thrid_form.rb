class ThridForm < ApplicationRecord
  belongs_to :task
  #has_paper_trail class_name: 'Version', meta: { related: :asset },
                #  ignore: [:subscribed_users]	
end
