class AddCategoriesToCategory < ActiveRecord::Migration

  class Category < ActiveRecord::Base  
  end

  def self.up
    category = Category.new(:title => "Собаки", :description => "Собаки", :category_type => 1)
    category.save!
    category = Category.new(:title => "Кошки", :description => "Коши", :category_type => 1)
    category.save!
    
    category = Category.new(:title => "Ветеринары", :description => "Ветеринары", :category_type => 2)
    category.save!
    category = Category.new(:title => "Зоомагазины", :description => "Зоомагазины", :category_type => 2)
    category.save!
    category = Category.new(:title => "Кошки", :description => "Кошки", :category_type => 2)
    category.save!
    category = Category.new(:title => "Собаки", :description => "Собаки", :category_type => 2)
    category.save!
    category = Category.new(:title => "Стрижка", :description => "Стрижка", :category_type => 2)
    category.save!
    category = Category.new(:title => "Птицы", :description => "Птицы", :category_type => 2)
    category.save!
    category = Category.new(:title => "Рыбы", :description => "Рыбы", :category_type => 2)
    category.save!
    category = Category.new(:title => "Другие животные", :description => "Другие животные", :category_type => 2)
    category.save!
    category = Category.new(:title => "Одежда для животных", :description => "Одежда для животных", :category_type => 2)
    category.save!

  end

  def self.down
    Category.delete(Category.find(:all))
  end
end
