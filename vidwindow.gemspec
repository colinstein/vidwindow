# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vidwindow/version'

Gem::Specification.new do |spec|
  spec.name          = "vidwindow"
  spec.version       = Vidwindow::VERSION
  spec.authors       = ["Colin Stein"]
  spec.email         = ["colinstein@me.com"]
  spec.homepage      = "https://github.com/colinstein/vidwindow"
  spec.license       = "MIT"

  spec.summary       = "A light-weight graphical display for 'CLI' programs"
  spec.description   = <<~DESCRIPTION
                       Occasionally I find myself wanting a way to have a
                       a graphical interface for programs that would ordinarily
                       be a command line application. Typically this is to
                       display simple pixel graphics like its 1988 or for basic
                       charts and graphs. This is a library that tosses a window
                       on the screen and then displays "sceenfulls" of data that
                       are read from a standard FIFO.

                       Your comand line application is expected to maintain its
                       own internal representation of vidoe memory and then blit
                       it out to the pipe whenever an update is needed. This is
                       intended to consume full screens worth of pixels and will
                       redraw them continuously until a new screen replaces
                       the previous screen.
                       DESCRIPTION

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://gems.colins.me/"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "gosu", "~> 0.11"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "codecov", "~> 0.1.10"

end
