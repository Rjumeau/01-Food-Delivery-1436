require_relative "../views/sessions_view.rb"

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  def login
    # Demander à l'utilisateur son username
    username = @sessions_view.ask_for("username")
    # Demander son mot de passe
    password = @sessions_view.ask_for("password")
    # Demander à l'employee repo si un employee a ce username => employee
    employee = @employee_repository.find_by_username(username)
    # Si il y'a un bien un employé trouvé et que son mot de passe correspond au mot de passe rentré
    if employee && employee.password == password
      # Afficher welcome
      @sessions_view.signed_in(username)
      # Et retourner l'employee
      return employee
    # Sinon
    else
      # Mauvais identifiants, recommencez
      @sessions_view.print_wrong_credentials
      # Relancer le login (récursion)
      login
    end
  end
end
