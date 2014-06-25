require 'spec_helper'

describe "Binary" do
  it "should serialize and deserialize correctly" do
    klass = Doc do
      key :contents, Binary
    end

    doc = klass.new(:contents => '010101')
    doc.save

    doc = doc.reload
    doc.contents.to_s.should == BSON::Binary.new('010101').to_s
  end

  context "Saving a document with a blank binary value" do
    before do
      @document = Doc do
        key :file, Binary
      end
    end

    it "not fail" do
      expect { @document.new(:file => nil).save }.to_not raise_error
    end
  end
end