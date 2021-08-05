# sar.rb

class Sar
  def erb(filename, local = {})
    message = local[:message]
    content = File.read("views/#{filename}.erb")
    ERB.new(content).result(binding)
  end

  def response(status, headers)
    body = yield if block_given?
    [status, headers, [body]]
  end
end