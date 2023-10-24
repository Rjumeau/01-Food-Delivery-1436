require "csv"
require_relative "../models/employee.rb"

class EmployeeRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = []
    load_csv if File.exist?(@csv_file_path)
  end

  def find_by_username(username)
    @employees.find {|employee| employee.username == username }
  end

  def all_riders
    @employees.select {|employee| employee.rider? }
  end

  def find(id)
    @employees.find { |employee| employee.id == id }
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      @employees << Employee.new(row)
    end
  end
end
