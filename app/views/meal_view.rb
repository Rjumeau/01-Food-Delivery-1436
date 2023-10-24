class MealView

  def display_meals(meals)
    puts "----- MEALS -----"
    meals.each_with_index do |meal, index|
      puts "#{index + 1} - #{meal.name} : #{meal.price}€"
    end
  end

  def ask_for_name
    puts "Which name for your meal ?"
    gets.chomp
  end

  def ask_for_price
    puts "Which price for your meal ?"
    gets.chomp.to_i
  end
end
