require "spec_helper"
require "multi_notifier/adapters/mail"

describe MultiNotifier::Adapters::Mail do
  context "validations" do
    [:delivery, :from, :to, :subject, :text_body].each do |field|
      it "#{field} can't be blank" do
        instance = described_class.new
        instance.should be_invalid
        instance.errors[field].should include("can't be blank")
      end
    end

    it "delivery method can't be blank" do
      instance = described_class.new(:delivery => {
        :foo => :bar
      })
      instance.should be_invalid
      instance.errors[:delivery].should include("method can't be blank")
    end
  end

  context "notify" do
    it "sends email" do
      mail = MultiNotifier::Adapters::Mail.new
      mail.delivery = {
        :method => :test
      }
      mail.from = "from@owenou.com"
      mail.to = "to@owenou.com"
      mail.subject = "subject"
      mail.text_body = "text body"
      mail.html_body = "html body"

      mailer = mail.notify!
      mailer.from.should == [mail.from]
      mailer.to.should == [mail.to]
      mailer.subject.should == mail.subject
      mailer.body.encoded.should include(mail.text_body)
      mailer.body.encoded.should include(mail.html_body)
    end
  end
end
