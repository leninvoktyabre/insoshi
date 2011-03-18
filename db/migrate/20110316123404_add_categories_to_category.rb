class AddCategoriesToCategory < ActiveRecord::Migration

  class Category < ActiveRecord::Base  
  end

  def self.up   
    category = Category.new(:title => "Ветеринары", :description => "Ветеринары", :title_safe => "Ветеринары".to_safe_uri)
    category.save!
    category = Category.new(:title => "Зоомагазины", :description => "Зоомагазины", :title_safe => "Зоомагазины".to_safe_uri)
    category.save!
    category = Category.new(:title => "Кошки", :description => "Кошки", :title_safe => "Кошки".to_safe_uri)
    category.save!
    category = Category.new(:title => "Собаки", :description => "Собаки", :title_safe => "Собаки".to_safe_uri)
    category.save!
    category = Category.new(:title => "Стрижка", :description => "Стрижка", :title_safe => "Стрижка".to_safe_uri)
    category.save!
    category = Category.new(:title => "Птицы", :description => "Птицы", :title_safe => "Птицы".to_safe_uri)
    category.save!
    category = Category.new(:title => "Рыбы", :description => "Рыбы", :title_safe => "Рыбы".to_safe_uri)
    category.save!
    category = Category.new(:title => "Другие животные", :description => "Другие животные", :title_safe => "Другие животные".to_safe_uri)
    category.save!
    category = Category.new(:title => "Одежда для животных", :description => "Одежда для животных", :title_safe => "Одежда для животных".to_safe_uri)
    category.save!

  end

  def self.down
    Category.delete(Category.find(:all))
  end
end
