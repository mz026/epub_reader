current_path = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(current_path, '..')) 
Dir['lib/**/*.rb'].each {|f| require f}
