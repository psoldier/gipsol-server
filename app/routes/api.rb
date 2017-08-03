class API < Cuba
  
  define do
    res.headers["Content-Type"] = "application/json"

    on "categories" do
      categories = Hash.new
      categories[:categories] = Category.all.entries.map.with_index(1) do |category,index|
        {
          id: index,
          title: category.name,
          score: 0,
          lifes: 2,
          maxScore: 0,
          question_id: 1,
          questions: category.questions.entries.map.with_index(1) do |question,i|
            {
              id: i,
              question: question.title,
              options: question.answerds.entries.map.with_index(1) do |answerd,k|
                {
                  id: k,
                  text: answerd.text,
                  value: answerd.value
                }
              end
            }
          end
        }
      end
      res.write categories.to_json
    end

    on default do
      res.status = 401
      res.headers["WWW-Authenticate"] = 'Basic realm="GIPSOL"'
      res.write "Unauthorized"
    end
  end
end