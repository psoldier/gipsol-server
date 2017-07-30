class Questions < Cuba
  Questions.plugin Cuba::Render
  Questions.settings[:render][:views] = "./app/views/user/"
  
  # We choose a different layout file for all admin views
  define do
    on get, root do
      questions = Question.paginate(req.params["page"]).asc(:name)
      render("questions/index", questions: questions, current_section: "questions")
    end

    on "new" do
      @question = Question.new
      @categories = Category.all
      4.times {@question.answerds.build} 
      render("questions/new", question: @question, categories: @categories, current_section: "questions")
    end

    on post, root do
      question_creation = Filters::Question.new(req.params["question"])
      begin
        if question_creation.valid? && Question.create!(question_creation.attributes)
          session[:notice] = "La Pregunta fue creada con éxito"
          res.redirect "/questions", 302
        else
          session[:error] = "Ocurrió un erro al crear la pregunta - #{question_creation.errors} "
          @question = Question.new(question_creation.attributes)
          @categories = Category.all
          render("questions/new", question: @question, categories: @categories, current_section: "questions")
        end
      rescue => e
        session[:error] = "Error #{e.message} "
        @question = Question.new(req.params["question"])
        @categories = Category.all
        render("questions/new", question: @question, categories: @categories, current_section: "questions")
      end
    end

    on ':id' do |id|
      begin
        question = Question.find(id)
      rescue Mongoid::Errors::DocumentNotFound
        not_found!
      end

      on get, root do
        render("questions/show", question: question, current_section: "questions")
      end

      on "edit" do
        render("questions/edit", question: question, current_section: "questions")
      end

      on put do
        on root do
          question_update = Filters::Question.new(req.params["question"])
          begin
            if question_update.valid? && Question.update_attributes!(question_update.attributes)
              session[:notice] = "Pregunta actualizada con éxito"
              res.redirect "/questions", 302
            else
              session[:error] = "Ocurrió un erro al actualizar la pregunta - #{question_update.errors} "
              render("questions/edit", question: question, current_section: "questions")
            end
          rescue => e
            session[:error] = "Error #{e.message} "
            render("questions/edit", question: question, current_section: "questions")
          end
        end
      end

      on delete, root do
        question.delete
        session[:notice] = "Pregunta eliminada con éxito"
        res.redirect "/questions", 302
      end
    end

    not_found!
  end
end