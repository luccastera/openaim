Gem::Specification.new do |s|
  s.name = "openaim"
  s.version = "2009.03.24"
 
  s.summary = "OpenAIM is a simple ruby library for OpenAIM API"
  s.description = "Ruby library for openaim - only Presence API implemented so far."
  s.platform = "ruby"
  s.has_rdoc = true
  s.author = "Luc Castera"
  s.email = "luc.castera@gmail.com"
  s.homepage = "http://github.com/dambalah/openaim"
  s.require_path = "lib"
  s.add_dependency('xml-simple', '>= 1.0.11')
 
  s.files = [
    "README",
    "lib/openaim.rb",
    "lib/openaim/presence.rb",
    "openaim.gemspec"
  ]
end
