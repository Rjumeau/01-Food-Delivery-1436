class CustomerView
  def display_customers(customers)
    puts "----- CUSTOMERS -----"
    customers.each_with_index do |customer, index|
      puts "#{index + 1} - #{customer.name} - #{customer.address}"
    end
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
