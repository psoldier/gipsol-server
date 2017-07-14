module Helpers
  module App
    def current_user
      authenticated(User)
    end

    def current_section; @current_section.to_s;end

    def date_time_format(date_time, with_time=false)
      format = "%m/%d/%y#{" %I:%M %p" if with_time}"
      date_time.strftime(format)
    end

    def notfound(msg)
      res.status = 404
      res.write(msg)
      halt(res.finish)
    end

    def forbidden(msg)
      res.status = 403
      res.write(msg)
      halt(res.finish)
    end
  end
end