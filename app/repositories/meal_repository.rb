require "csv"
require_relative "../models/meal.rb"

class MealRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @meals = []
    # On initialise le prochain id à 1 par défault
    @next_id = 1
    # On charge les données du CSV pour remplir mon array meals et gérer
    # l'incrémentation des Id
    load_csv if File.exist?(@csv_file_path)
    # On exécute cette méthode seulement si le csv_file_path existe
  end

  def create(meal)
    # On assigne l'id de l'instance de meal au next_id
    meal.id = @next_id
    @meals << meal
    # On incrémente le next id de 1 pour être certain que la prochaine instance ait
    # un nouvel id
    @next_id += 1
    save_csv
  end

  def all
    @meals
  end

  def find(id)
    @meals.find {|meal| meal.id == id }
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i
      #@meals << Meal.new(id: row[:id], name: row[:name], price: row[:price])
      @meals << Meal.new(row)
    end

    # Si on a rien dans le CSV (donc meals reste vide), alors le next id reste à 1
    # Sinon, on récupère l'id de la dernière instance de Meal et on lui ajoute 1
    @next_id = @meals.empty? ? 1 : @meals.last.id + 1
  end

  def save_csv
    CSV.open(@csv_file_path, "wb") do |csv|
      csv << ["id", "name", "price"]
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end
end
