class SessionsView
  def display_employees(employees)
      puts "----- EMPLOYEES -----"
      employees.each_with_index do |employee, index|
        puts "#{index + 1} - #{employee.username.capitalize} - #{employee.role}"
    end
  end

  def ask_for(keyword)
    puts "#{keyword.capitalize}?"
    gets.chomp
  end

  def signed_in(username)
    puts "Welcome #{username} !"
  end

  def print_wrong_credentials
    puts "Wrong credentials... Try again"
  end
end
