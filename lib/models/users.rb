class User < ActiveRecord::Base

    def self.start(create_profile_or_sign_in)
        case create_profile_or_sign_in
        when "create_profile"
            # create_profile
        when "sign_in"
            # sign_in
        else
            App.invalid_input
        end
    end

    def self.navigation
        prompt = TTY::Prompt.new
        prompt.select("Where would you like to go?", %w(home categories posts meditations sign_out))
    end

end