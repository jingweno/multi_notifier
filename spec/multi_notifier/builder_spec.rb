require "spec_helper"

describe MultiNotifier::Builder do
  it "builds adapter by types" do
    builder = described_class.new
    builder.use :mail
    builder.use :travis

    builder.adapters.size.should == 2
    builder.adapters.first.class.name.should == "MultiNotifier::Middlewares::Mail"
    builder.adapters.last.class.name.should == "MultiNotifier::Middlewares::Travis"
  end
end
