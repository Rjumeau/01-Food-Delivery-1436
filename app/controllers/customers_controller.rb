require_relative "../views/customer_view.rb"
require_relative "../models/customer.rb"

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customer_view = CustomerView.new
  end

  def add
    # Demander à la view le nom
    name = @customer_view.ask_for_name
    # Demander à la view l'addresse
    address = @customer_view.ask_for_address
    # Créer une instance de customer avec ces infos
    customer = Customer.new(name: name, address: address)
    # Utiliser la méthode create du repository
    @customer_repository.create(customer)
    display_list
  end
  # List

  def list
    display_list
  end

  private

  def display_list
    # Récupérer les customers depuis le repository
    customers = @customer_repository.all
    # Demander à la view d'afficher la liste des customers
    @customer_view.display_customers(customers)
  end
end
