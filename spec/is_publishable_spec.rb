require 'spec_helper'

class Sample < ActiveRecord::Base
  publishable

  def self.table_name 
    "samples" 
  end
end

describe IsPublishable do

  before(:all) do
    setup_db
  end

  after(:all) do
    teardown_db
  end

  before(:each) do
    Sample.destroy_all
  end

  it 'will save without changing anything' do
    sample = Sample.create
    sample.published.should be_false
  end

  it 'will update published_at to now automatically' do
    sample = Sample.create :published => true
    sample.published_at.should be_within(2.second).of(Time.zone.now)
  end

  it 'will not update published_at if already set' do
    yesterday = Time.zone.now - 1.day
    sample = Sample.create :published => true, :published_at => yesterday
    sample.save
    sample.published_at.should == yesterday
  end

  it 'will act appropriately for published resources' do
    sample = Sample.create :published => true, :published_at => Time.zone.now - 1.day
    
    # sample.published?.should be_true
    sample.unpublished?.should be_false

    Sample.published.should include sample
    Sample.unpublished.should_not include sample
  end

  it 'will act appropriately for unpublished resources' do
    sample = Sample.create published: false
    
    # sample.published?.should be_false
    sample.unpublished?.should be_true

    Sample.published.should_not include sample
    Sample.unpublished.should include sample
  end

  it 'will act appropriately for published resources in the future' do
    sample = Sample.create :published => true, :published_at => Time.zone.now + 1.day
    
    # sample.published?.should be_false
    sample.unpublished?.should be_true

    Sample.published.should_not include sample
    Sample.unpublished.should include sample
  end

  it 'has a publish! method' do
    sample = Sample.create
    sample.published?.should be_false
    sample.publish!
    sample.published?.should be_true
  end

  it 'has a unpublish! method' do
    sample = Sample.create published: true
    sample.published?.should be_true
    sample.unpublish!
    sample.published?.should be_false
    sample.publish!
    sample.published?.should be_true
  end

end
