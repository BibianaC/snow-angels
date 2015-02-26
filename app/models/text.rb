class Text < ActiveRecord::Base
  belongs_to :volunteer

  def self.send_text
    volunteers = Volunteer.all

    client = Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']
    account = client.account
    volunteers.each do |volunteer|
      message = account.messages.create({:body => "It's awful weather! #{volunteer.name} are you available to help today? Snow Angels",
            :to => volunteer.mobile_number,
            :from => ENV['TWILIO_NO']})
      puts message
    end
  end
end