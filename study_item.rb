require_relative 'category'

class StudyItem
  attr_reader :title, :category, :id

  @@next_index = 1
  @@study_items = []

  def initialize(title:, category:)
    @id = @@next_index
    @title = title
    @category = category
    @done = false
    @@next_index += 1
    @@study_items << self
  end

  def done?
    @done
  end

  def done!
    @done = true
  end

  def undone?
    !@done
  end

  def to_s
		"##{id} - #{title} - #{category}#{' - Finalizada' if done?}"
  end

  def include?(term)
    title.downcase.include?(term.downcase)
  end

  def self.create 
    print 'O que você quer estudar? '
    title = gets.chomp
  
    print_with_index(Category.all)
    print 'Esscolha a categoria desse item: '
    category = Category.index(gets.to_i - 1)
  
    puts "O estudo de #{title} foi cadastrado com sucesso na categoria #{category}"
    StudyItem.new(title: title, category: category)
  end

  def self.all
    @@study_items
  end
  
  def self.search(term)
    all.filter{ |element| element.include?(term) }
  end

  def self.undone
    all.filter(&:undone?)
  end

end