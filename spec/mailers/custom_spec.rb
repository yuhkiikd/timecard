require "rails_helper"
=begin
RSpec.describe CustomMailer, type: :mailer do
  describe "test" do
    let(:mail) { CustomMailer.test }

    it "renders the headers" do
      expect(mail.subject).to eq("Test")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["testdikd@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end
end
=end