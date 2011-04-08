class AddDealsToDealType < ActiveRecord::Migration
  class DealTypes < ActiveRecord::Base  
  end

  def self.up   
    deal = DealTypes.new(:title => "Продам", :status => 1) 
    deal.save!
    deal = DealTypes.new(:title => "Куплю", :status => 1) 
    deal.save!

  end
  def self.down
    DealTypes.delete(DealTypes.find(:all))
  end
  
end
