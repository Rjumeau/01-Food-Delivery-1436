class SessionsView

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
