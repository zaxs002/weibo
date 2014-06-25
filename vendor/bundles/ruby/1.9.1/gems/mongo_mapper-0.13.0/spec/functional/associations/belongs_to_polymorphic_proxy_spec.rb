require 'spec_helper'


describe "BelongsToPolymorphicProxy" do
  before do
    Status.collection.remove
    Project.collection.remove
  end

  it "should default to nil" do
    status = Status.new
    status.target.nil?.should be_true
    status.target.inspect.should == "nil"
  end

  it "should have boolean presence method" do
    status = Status.new
    status.target?.should be_false

    status.target = Project.new(:name => 'mongomapper')
    status.target?.should be_true
  end

  it "should be able to replace the association" do
    status = Status.new(:name => 'Foo!')
    project = Project.new(:name => "mongomapper")
    status.target = project
    status.save.should be_true

    status = status.reload
    status.target.nil?.should be_false
    status.target_id.should == project._id
    status.target_type.should == "Project"
    status.target.name.should == "mongomapper"
  end

  it "should unset the association" do
    status = Status.new(:name => 'Foo!')
    project = Project.new(:name => "mongomapper")
    status.target = project
    status.save.should be_true

    status = status.reload
    status.target = nil
    status.target_type.nil?.should be_true
    status.target_id.nil?.should be_true
    status.target.nil?.should be_true
  end

  context "association id set but document not found" do
    before do
      @status = Status.new(:name => 'Foo!')
      project = Project.new(:name => "mongomapper")
      @status.target = project
      @status.save.should be_true
      project.destroy
      @status.reload
    end

    it "should return nil instead of raising error" do
      @status.target.nil?.should be_true
    end
  end
end
