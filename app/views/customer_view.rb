class CustomerView
  def display_customers(customers)
    customers.each_with_index do |customer, index|
      puts "#{index + 1} - #{customer.name} - #{customer.address}"
    end

    # Autre solution => Afficher les id (plus simple pour find)
    # Soucis => Les id sont uniques, donc risque de ne pas avoir un affichage cohérent

    # ex : 23 - John : 45 rue Dupont 31000 Toulouse
    #      26 - Sarah : 33 rue de la paix 33000 Bordeaux

    #customers.each do |customer|
      #puts "#{customer.id} - #{customer.name} : #{customer.price}€"
    #end
  end

  def ask_for_name
    puts "Which name for your customer ?"
    gets.chomp
  end

  def ask_for_address
    puts "Which address for your customer ?"
    gets.chomp
  end
end
