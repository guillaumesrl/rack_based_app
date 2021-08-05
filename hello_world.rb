# hello_world.rb


require_relative 'advice'


class HelloWorld
  def call(env)
    case env['REQUEST_PATH']
    when '/'
      [
        '200', {'Content-Type' => 'text/html'},
        [erb(:index)]
      ]
    when '/advice'
      piece_of_advice = Advice.new.generate
      [
        '200', {'Content-Type' => 'text/html'},
        [erb(:advice, message: piece_of_advice)]
      ]
    else
      [
        '404', {"Content-Type" => 'text/html', "Content-Length" => '48'},
        ["<html><body><h4>404 Not Found</h4></body></html>"]
      ]
    end
  end

  private

  def erb(filename, local = {})
    message = local[:message]
    content = File.read("views/#{filename}.erb")
    ERB.new(content).result(binding)
  end 

end