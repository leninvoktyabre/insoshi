class AddSexToSexTypes < ActiveRecord::Migration
  class SexType < ActiveRecord::Base  
  end

  def self.up   
    sex = SexType.new(:title => "Самец", :status => 1) 
    sex.save!
    sex = SexType.new(:title => "Самка", :status => 1) 
    sex.save!  
  end

  def self.down
    SexType.delete(SexType.find(:all))
  end
end
