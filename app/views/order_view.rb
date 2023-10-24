class OrderView
  def ask_for_index(stuff)
    puts "Which #{stuff} do you want to add to your order ? (position)"
    gets.chomp.to_i - 1
  end

  def ask_for_order_index
    puts "Which order do you want to mark ? (position)"
    gets.chomp.to_i - 1
  end

  def display_orders(orders)
    orders.each_with_index do |order, index|
      puts "#{index + 1} - #{order.employee.username.capitalize} is delivered #{order.meal.name} to #{order.customer.name.capitalize}"
    end
  end
end
