require 'io/console'
require_relative 'study_item'

INSERT = 1
VIEW_ALL = 2
SEARCH = 3
# LIST_BY_CATEGORY = 4
# DELETE_ITEM = 5
# DESCRIPTION_AND_SEARCH = 6
MARK_AS_DONE = 4
EXIT = 5

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

def print_with_index(collection)
	puts collection
	puts 'Nenhum item encontrado' if collection.empty?
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

def search_study_items
	print 'Digite uma palavra para procurar: '
	term = gets.chomp
	StudyItem.search(term)
end

def mark_study_items_as_done
	not_finalized = StudyItem.undone
	print_with_index(not_finalized)
	return if not_finalized.empty?

	puts
	print 'Digite o número que deseja finalizar: '
	index = gets.to_i
	not_finalized[index - 1].done!
end


clear
puts 'Boas vindas ao Diário de Estudos :D'

option = menu

loop do
	case option
	when INSERT
		StudyItem.create
	when VIEW_ALL
		print_with_index(StudyItem.all)
	when SEARCH
		found_items = search_study_items
		print_with_index(found_items)
	# elsif option == 4
	# elsif option == 5
	# elsif option == 6
	when MARK_AS_DONE
		mark_study_items_as_done
	when EXIT
		break
	else
		puts 'Opção inválida'
	end
	wait_and_clear
	option = menu
end
puts 'Obrigado por usar o Diário de Estudos :D'
puts