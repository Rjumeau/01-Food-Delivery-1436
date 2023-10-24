require_relative "../views/meal_view.rb"
require_relative "../views/customer_view.rb"
require_relative "../views/order_view.rb"
require_relative "../views/sessions_view.rb"

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @meal_view = MealView.new
    @customer_view = CustomerView.new
    @order_view = OrderView.new
    @sessions_view = SessionsView.new
  end

  def add
    meal = select_meal
    customer = select_customer
    rider = select_employee
    order = Order.new(meal: meal, customer: customer, employee: rider)
    @order_repository.create(order)
  end

  def list_undelivered_orders
    # Récupérer la liste des orders non délivrées
    undelivered_orders = @order_repository.undelivered_orders
    # Afficher la liste des orders non délivrées
    @order_view.display_orders(undelivered_orders)
  end

  def list_my_orders(rider)
    list_my_undelivered_orders(rider)
  end

  def mark_as_delivered(rider)
    # Trouver et afficher les commandes qui appartient au rider et qui ne sont pas livrées
    list_my_undelivered_orders(rider)
    # Demander quelle commande le rider veut indiquer comme livrée
    index = @order_view.ask_for_order_index
    # Récupérer de nouveau les orders du livreur
    my_orders = @order_repository.my_undelivered_orders(rider)
    # Récupérer l'order via l'index passé précédemment
    order = my_orders[index]
    # Modifier l'order pour faire en sorte qu'elle soit livrée
    @order_repository.mark_as_delivered(order)
  end

  private

  def list_my_undelivered_orders(rider)
    # Trouver les commandes qui appartiennent au rider et qui ne sont pas livrées
    my_undelivered_orders = @order_repository.my_undelivered_orders(rider)
    # Affcher les commandes
    @order_view.display_orders(my_undelivered_orders)
  end

  def select_meal
    # Récupérer la liste des meals via le repo meal
    meals = @meal_repository.all
    # Demander à la view d'afficher les meals
    @meal_view.display_meals(meals)
    # Demander à la view quel meal le manager veut choisir
    index = @order_view.ask_for_index("meal")
    # Chercher dans la liste meals, l'instance avec l'index du manager
    meals[index]
  end

  def select_customer
    customers = @customer_repository.all
    @customer_view.display_customers(customers)
    index = @order_view.ask_for_index("customer")
    customers[index]
  end

  def select_employee
    employees = @employee_repository.all_riders
    @sessions_view.display_employees(employees)
    index = @order_view.ask_for_index("employee")
    employees[index]
  end
end
