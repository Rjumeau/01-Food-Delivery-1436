require_relative "../views/meal_view.rb"
require_relative "../models/meal.rb"

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meal_view = MealView.new
  end


  # Add

  def add
    # Demander à la view le nom
    name = @meal_view.ask_for_name
    # Demander à la view le prix
    price = @meal_view.ask_for_price
    # Créer une instance de Meal avec ces infos
    meal = Meal.new(name: name, price: price)
    # Utiliser la méthode create du repository
    @meal_repository.create(meal)
    display_list
  end
  # List

  def list
    display_list
  end

  private

  def display_list
    # Récupérer les meals depuis le repository
    meals = @meal_repository.all
    # Demander à la view d'afficher la liste des meals
    @meal_view.display_meals(meals)
  end
end
