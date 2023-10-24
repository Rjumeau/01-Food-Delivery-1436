require "csv"
require_relative "../models/order.rb"
require "pry-byebug"

class OrderRepository
  def initialize(orders_csv_path, meal_repository, customer_repository, employee_repository)
    @orders_csv_path = orders_csv_path
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @next_id = 1
    @orders = []
    load_csv if File.exist?(@orders_csv_path)
  end

  def create(order)
    order.id = @next_id
    @orders << order
    @next_id += 1
    save_csv
  end

  def undelivered_orders
    @orders.reject {|order| order.delivered? }
  end

  def my_undelivered_orders(rider)
    @orders.select {|order| order.employee == rider && order.delivered == false  } # ou !order.delivered?
  end

  def mark_as_delivered(order)
    order.deliver!
    save_csv
  end

  private

  # Serialization
  def save_csv
    CSV.open(@orders_csv_path, "wb") do |csv|
      csv << ["id", "meal_id", "employee_id", "customer_id", "delivered"]
      @orders.each do |order|
        csv << [order.id, order.meal.id, order.employee.id, order.customer.id, order.delivered]
      end
    end
  end

  # Deserialization
  def load_csv
    CSV.foreach(@orders_csv_path, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      row[:meal] = @meal_repository.find(row[:meal_id].to_i)
      row[:customer] = @customer_repository.find(row[:customer_id].to_i)
      row[:employee] = @employee_repository.find(row[:employee_id].to_i)
      row[:delivered] = row[:delivered] == "true"
      @orders << Order.new(row)
    end

    @next_id = @orders.last.id + 1 unless @orders.empty?
  end
end
