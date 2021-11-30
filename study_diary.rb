require 'io/console'
INSERT = 1
VIEW_ALL = 2
SEARCH = 3
# LIST_BY_CATEGORY = 4
# DELETE_ITEM = 5
# DESCRIPTION_AND_SEARCH = 6
MARK_AS_DONE = 4
EXIT = 5

def welcome
	'Boas vindas ao Diário de Estudos :D'
end

def menu
	puts <<~Menu 
		------------------------------------------
		[#{INSERT}] Cadastrar um item para estudar
		[#{VIEW_ALL}] Ver todos os itens cadastrados
		[#{SEARCH}] Buscar um item de estudo
		[#{MARK_AS_DONE}] Marcar um item como concluído
		[#{EXIT}] Salvar e Sair
		------------------------------------------
	Menu
	print 'Escolha uma opção: '
	gets.to_i
end

def create_study_item
	print 'O que você quer estudar? '
	title = gets.chomp

	print 'A qual categoria esse item pertence? '
	category = gets.chomp

	puts "O estudo de #{title} foi cadastrado com sucesso na categoria #{category}"
	{title: title, category: category, done: false}
end

def mark_study_items_as_done(study_items)
	not_finalized = study_items.filter { |item| !item[:done] }
	print_study_items(not_finalized)
	return if not_finalized.empty?

	puts
	print 'Digite o número que deseja finalizar: '
	index = gets.to_i
	not_finalized[index - 1][:done] = true
	
end

def clear
	system 'clear'
end

def wait_keypress
	puts
	puts 'Pressione qualquer tecla para continuar...'
	STDIN.getch
end

def wait_and_clear
	wait_keypress
	clear
end

def print_study_items(collection)
	collection.each.with_index(1) do |item, index|
		puts "##{index} - #{item[:title]} - #{item[:category]}#{' - Finalizada' if item[:done]}"
	end
	puts 'Nenhum item encontrado' if collection.empty?
end

def search_study_items(collection)
	print 'Digite uma palavra para procurar: '
	term = gets.chomp
	collection.filter do |item|
		item[:title].include? term
	end
end

clear
puts welcome

study_items = []
option = menu

loop do
	case option
	when INSERT
		study_items << create_study_item
		wait_and_clear
	when VIEW_ALL
		print_study_items(study_items)
		wait_and_clear
	when SEARCH
		found_items = search_study_items(study_items)
		print_study_items(found_items)
		wait_and_clear
	# elsif option == 4
	# elsif option == 5
	# elsif option == 6
	when MARK_AS_DONE
		mark_study_items_as_done(study_items)
		wait_and_clear
	when EXIT
		break
	else
		puts 'Opção inválida'
		wait_and_clear
	end
	clear
	option = menu
end
puts 'Obrigado por usar o Diário de Estudos :D'
puts