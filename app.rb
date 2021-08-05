# App.rb

require_relative 'advice'


class App
  def call(env)
    case env['REQUEST_PATH']
    when '/'
      status = '200'
      headers = {"Content-Type" => 'text/html'}
      response(status, headers) do
        erb :index
      end
    when '/advice'
      piece_of_advice = Advice.new.generate
      status = '200'
      headers = {'Content-Type' => 'text/html'}
      reponse(status, headers) do 
        erb(:advice, message: piece_of_advice)
      end
    else
      status = '404'
      headers = {"Content-Type" => 'text/html', "Content-Length" => '48'}
      reponse(status, headers) do
        erb(:not_found)
      end
    end
  end

  private

  def erb(filename, local = {})
    message = local[:message]
    content = File.read("views/#{filename}.erb")
    ERB.new(content).result(binding)
  end

  def reponse(status, headers)
    body = yield if block_given?
    [status, headers, [body]]
  end

end