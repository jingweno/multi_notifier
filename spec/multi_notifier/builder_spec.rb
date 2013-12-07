require "spec_helper"

describe MultiNotifier::Builder do
  it "builds adapter by types" do
    builder = described_class.new
    builder.use :mail

    builder.adapters.size.should == 1
    adapter = builder.adapters.first
    adapter.class.name.should == "MultiNotifier::Middlewares::Mail"
  end
end
