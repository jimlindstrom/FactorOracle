# load the implementation
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))
Dir[File.expand_path(File.join(File.dirname(__FILE__),'..','*.rb'))].each {|f| require f}
