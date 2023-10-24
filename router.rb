class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
  end

  def run
    while @running == true
      @current_employee = @sessions_controller.login
      while @current_employee
        # si l'employee est un manager
        if @current_employee.manager?
          # alors on affiche un menu manager
            print_manager_menu
            # on récupère son choix
            choice = gets.chomp.to_i
            # on route son action vers des actions manager
            route_manager_action(choice)
        else
          print_rider_menu
          choice = gets.chomp.to_i
          route_rider_action(choice)
        end
      end
    end
  end

  private

  def print_manager_menu
    puts "-----------"
    puts "----MANAGER MENU----"
    puts "------------"
    puts "1. Add a new meal"
    puts "2. List all meals"
    puts "3. Add a customer"
    puts "4. List all customers"
    puts "5. Add new order"
    puts "6. List all undelivered orders"
    puts "7. Logout"
    puts "8. Quit"
  end

  def route_manager_action(choice)
    case choice
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then @orders_controller.add
    when 6 then @orders_controller.list_undelivered_orders
    when 7 then logout!
    when 8 then stop!
    end
  end

  def print_rider_menu
    puts "-----------"
    puts "----RIDER MENU----"
    puts "------------"
    puts "1. List my undelivered orders"
    puts "2. Mark order as delivered"
    puts "3. Logout"
    puts "4. Quit"
  end

  def route_rider_action(choice)
    case choice
    when 1 then @orders_controller.list_my_orders(@current_employee) # Current employee est forcément un rider ici
    when 2 then @orders_controller.mark_as_delivered(@current_employee) # Current employee est forcément un rider ici
    when 3 then logout!
    when 4 then stop!
    end
  end

  def logout!
    @current_employee = nil
  end

  def stop!
    logout!
    @running = false
  end
end
