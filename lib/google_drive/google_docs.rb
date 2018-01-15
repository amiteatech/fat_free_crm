require 'oauth2'
module GoogleDrive

  class GoogleDocs
    attr_writer :client_id, :client_secret, :redirect_uri

    def initialize(client_id, client_secret, redirect_uri)
      @client_id = "318261922103-6o5ui2qui55luqss9d2gpsbsukianb39.apps.googleusercontent.com"
      @client_secret = "WlTtICFYG64yummKqFlpz5hf"
      @redirect_uri = "http://localhost:3000/oauth2callback"
    end

    def create_google_client
      OAuth2::Client.new(
        @client_id, @client_secret,
        :site => "https://accounts.google.com",
        :token_url => "/o/oauth2/token",
        :authorize_url => "/o/oauth2/auth")
    end

    def set_google_authorize_url
      client = create_google_client
      client.auth_code.authorize_url(
        :redirect_uri => @redirect_uri,
        :access_type => "offline",
        :scope =>
          "https://www.googleapis.com/auth/drive " +
          "https://www.googleapis.com/auth/drive.file")
    end

    def add_permission(file_id, email_id)
      # file_id = '1sTWaJ_j7PkjzaBWtNc3IzovK5hQf21FbOw9yLeeLPNQ'
      # callback = lambda do |res, err|
      #   if err
      #     # Handle error...
      #     puts err.body
      #   else
      #     puts "Permission ID: #{res.id}"
      #   end
      # end
      drive_service = Google::Apis::DriveV3::DriveService.new("318261922103-6o5ui2qui55luqss9d2gpsbsukianb39.apps.googleusercontent.com", "WlTtICFYG64yummKqFlpz5hf", "http://localhost:3000/oauth2callback")
      drive_service.batch do |service|
        user_permission = {
            type: 'user',
            role: 'writer',
            email_address: email_id
        }
        service.create_permission(file_id,
                                  user_permission,
                                  fields: 'id')
                                  # &callback)
        # domain_permission = {
        #     type: 'domain',
        #     role: 'reader',
        #     domain: 'example.com'
        # }
        # service.create_permission(file_id,
        #                           domain_permission,
        #                           fields: 'id',
        #                           &callback)
      end
    end

  end
end
