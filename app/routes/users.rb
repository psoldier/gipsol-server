class Users < Cuba
  Users.plugin Cuba::Render
  # If we throw a 401, we get redirected to /user/login.
  use Shield::Middleware, "/login"

  Users.settings[:render][:views] = "./app/views/user/"
  
  # This is a very simple way to secure your return
  # URL and prevent a hijacking attack.
  def assert_return_path(path)
    return if path.nil? or not path =~ %r{\A/user[a-z0-9\-/]*\z}i
    return path
  end

  define do
    on "dashboards" do
      render("dashboard", {title: "GIPSOL - Dashboard"})
    end

    on "categories" do
      run Categories
    end

    on "logout" do
      logout(User)
      session[:notice] = "Has cerrado sesión."
      res.redirect "/login", 303
    end

    on root do
      res.redirect "/dashboards", 302
    end

    on default do
      session[:error] = "Oops la página que buscás no existe"
      res.redirect "/dashboards", 302
    end
  end
end