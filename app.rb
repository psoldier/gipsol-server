require File.expand_path("shotgun",  File.dirname(__FILE__))

ENV["RACK_ENV"] ||= 'development'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

Mongoid.load!("./config/mongoid.yml")

Dir["./lib/**/*.rb"].each     { |rb| require rb }
Dir["./app/helpers/**/*.rb"].each  { |rb| require rb }
Dir["./app/models/**/*.rb"].each  { |rb| require rb }
Dir["./app/routes/**/*.rb"].each  { |rb| require rb }
Dir["./app/filters/**/*.rb"].sort.each    { |rb| require rb }
Dir["./app/routes/**/*.rb"].sort.each     { |rb| require rb }

# Load rack middlewares
Cuba.use Rack::Deflater
Cuba.use Rack::ContentType, 'text/html; charset=utf-8'
Cuba.use Rack::MethodOverride
Cuba.use Rack::Head
Cuba.use Rack::Session::Cookie, key: '__gipsol__', secret: "__gipsolservergipsolservergipsolservergipsolservergipsolserver__"
Cuba.use Rack::Static, root: 'public', urls: %w(/css /fonts /img /js /robots.txt)
Cuba.use Rack::ShowExceptions if ENV["RACK_ENV"] == "development"
Cuba.use Rack::Parser,
  parsers:  { "application/json" => proc { |data| JSON.parse(data) } },
  handlers: { %r(json) => proc { |err, type| [400, {}, ["Bad Request: #{err.to_s}"]] } }

Cuba.plugin Cuba::Safe
Cuba.plugin Cuba::Render
Cuba.plugin Shield::Helpers
Cuba.plugin Cuba::ContentFor
Cuba.plugin Cuba::With
Cuba.plugin Helpers::App


Cuba.settings[:render][:views] = './app/views/'
Cuba.settings[:render][:layout] = 'public/layout'


Cuba.define do
  persist_session!

  on csrf.unsafe? do
    csrf.reset!

    res.status = 403
    res.write("Not authorized")

    halt(res.finish)
  end

  on authenticated(User) do
    run Users
  end

  on "login" do
    on get do
      render("public/login", {title: "Login", current_section: "login", return_url: req.params[:return]})
    end

    on post, param("username"), param("password") do |user, pass|
      if login(User, user, pass)
        current_user.inc(login_count: 1)
        current_user.update_attribute(:last_login_at, Time.now.utc)
        current_user.save
        remember(1209600) if req.params["remember_me"]
        session[:notice] = "Bienvenido!"
        res.redirect(req.params["return"]||"/dashboards")
      else
        session[:error] = "Combinación de email y/o contraseña inválida."
        render("public/login", { username: user, title: "Login", current_section: "login"})
      end
    end

    on default do
      session[:error] = "Debe ingresar email y/o contraseña."
      res.redirect "/login", 303
    end
  end

  on "api" do
    run API
  end
  
  on root do
    render "public/pages/index"
  end
end