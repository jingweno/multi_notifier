require "spec_helper"
require "multi_notifier/adapters/travis"

describe MultiNotifier::Adapters::Travis do
  context "validations" do
    [:access_token, :repo].each do |field|
      it "#{field} can't be blank" do
        instance = described_class.new
        instance.should be_invalid
        instance.errors[field].should include("can't be blank")
      end
    end
  end
end
