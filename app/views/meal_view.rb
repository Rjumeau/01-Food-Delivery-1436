class MealView

  def display_meals(meals)
    meals.each_with_index do |meal, index|
      puts "#{index + 1} - #{meal.name} : #{meal.price}€"
    end

    # Autre solution => Afficher les id (plus simple pour find)
    # Soucis => Les id sont uniques, donc risque de ne pas avoir un affichage cohérent

    # ex : 23 - Cassoulet : 35€
    #      26 - Lasagnes : 20€

    #meals.each do |meal|
      #puts "#{meal.id} - #{meal.name} : #{meal.price}€"
    #end
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
