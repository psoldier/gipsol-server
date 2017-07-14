class API < Cuba
  
  define do
    res.headers["Content-Type"] = "application/json"

    on "categories" do
      res.write JSON.dump(
        {
          categories: [
            {
              id: 1,
              title: 'Energias Renovables',
              score: 0,
              lifes: 3,
              maxScore: 0,
              questions: [
                {
                  id: 1,
                  question: '¿Cual de las siguientes fuentes de energias no es renovable?',
                  options:[{id: 1, text: 'HIDRAULICA', value: false},{id: 2, text: 'SOLAR',value: false},{id: 3, text: 'EOLICA',value: false},{id: 4, text: 'PETROLEO',value: true}]
                },
                {
                  id: 2,
                  question: '¿Que elemento es el mayor generador de energia eolica?',
                  options:[{id: 1, text: 'ESPEJOS', value: false},{id: 2, text: 'MOLINOS',value: true},{id: 3, text: 'VOLCANES',value: false},{id: 4, text: 'SPINNERS',value: false}]
                },
                {
                  id: 3,
                  question: '¿En que sector se consume mas energia?',
                  options:[{id: 1, text: 'SECTOR TRANSPORTE', value: true},{id: 2, text: 'SECTOR INDUSTRIAL',value: false},{id: 3, text: 'SECTOR DOMESTICO',value: false},{id: 4, text: 'SECTOR CREATIVO',value: false}]
                },
                {
                  id: 4,
                  question: 'Petroleo, carbon, uranio, sol y viento, son...',
                  options:[{id: 1, text: 'FUENTES DE ENERGIAS', value: true},{id: 2, text: 'ENERGIAS',value: false},{id: 3, text: 'FUERZAS',value: false},{id: 4, text: 'INVENTOS HUMANOS',value: false}]
                }
              ],
              question_id: 1
            },
            {
              id: 2,
              title: 'Transporte',
              score: 0,
              lifes: 3,
              maxScore: 0,
              questions: [
                {
                  id: 1,
                  question: '¿Super o Premium?',
                  options:[{id: 1, text: 'SUPER', value: false},{id: 2, text: 'PREMIUM',value: false},{id: 3, text: 'INFINIA',value: false},{id: 4, text: 'POWERADE',value: true}]
                }
              ],
              question_id: 1
            },
            {
              id: 3,
              title: 'Test',
              score: 0,
              lifes: 3,
              maxScore: 0,
              questions: [
                {
                  id: 1,
                  question: '¿Mejor equipo de futbol?',
                  options:[{id: 1, text: 'BOCA', value: false},{id: 2, text: 'LOBO',value: true},{id: 3, text: 'PINCHA',value: false},{id: 4, text: 'RIBER',value: false}]
                }
              ],
              question_id: 1
            }
          ],
        }
      )
    end

    on default do
      res.status = 401
      res.headers["WWW-Authenticate"] = 'Basic realm="GIPSOL"'
      res.write "Unauthorized"
    end
  end
end