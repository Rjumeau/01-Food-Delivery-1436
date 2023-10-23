class Router
  def initialize(meals_controller, customers_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @running = true
  end

  def run
    # Tant que running est true
    while @running == true
      # On affiche le menu
      print_menu
      # On récupère le réponse du user
      choice = gets.chomp.to_i
      # On redirige vers l'action du controller associé
      route_action(choice)
    end
  end

  private

  def print_menu
    puts "-----------"
    puts "----MENU----"
    puts "------------"
    puts "1. Add a new meal"
    puts "2. List all meals"
    puts "3. Add a customer"
    puts "4. List all customers"
    puts "5. Quit"
  end

  def route_action(choice)
    case choice
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then @running = false
    end
  end
end
