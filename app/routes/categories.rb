class Categories < Cuba
    Categories.plugin Cuba::Render
    Categories.settings[:render][:views] = "./app/views/user/"
    
    # We choose a different layout file for all admin views

    define do
      on get, root do
        categories = Category.paginate(req.params["page"]).asc(:name)
        render("categories/index", categories: categories, current_section: "categories")
      end

      on "new" do
        category = Category.new
        render("categories/new", category: category, current_section: "categories")
      end

      on post, root do
        category_creation = Filters::Category.new(req.params["category"])
        begin
          if category_creation.valid? && Category.create!(category_creation.attributes)
            session[:notice] = "La Categoría fue creada con éxito"
            res.redirect "/categories", 302
          else
            session[:error] = "Ocurrió un erro al crear la categoría - #{category_creation.errors}"
            render("categories/new", category: Category.new(category_creation.attributes), current_section: "categories")
          end
        rescue => e
          session[:error] = "Error #{e.message} "
          render("categories/new", category: Category.new(), current_section: "categories")
        end
      end

      on ':id' do |id|
        begin
          category = Category.find(id)
        rescue Mongoid::Errors::DocumentNotFound
          not_found!
        end

        on get, root do
          render("categories/show", category: category, current_section: "categories")
        end

        on "edit" do
          render("categories/edit", category: category, current_section: "categories")
        end

        on put do
          on root do
            category_update = Filters::Category.new(req.params["category"])
            begin
              if category_update.valid? && category.update_attributes!(category_update.attributes)
                session[:notice] = "Categoría actualizada con éxito"
                res.redirect "/categories", 302
              else
                session[:error] = "Ocurrió un erro al editar la categoría - #{category_update.errors}"
                render("categories/edit", category: category, current_section: "categories")
              end
            rescue => e
              session[:error] = "Error #{e.message} "
              render("categories/edit", category: category, current_section: "categories")
            end
          end
        end

        on delete, root do
          category.delete
          session[:notice] = "Categoría eliminada con éxito"
          res.redirect "/categories", 302
        end
      end

      not_found!
    end
  end
