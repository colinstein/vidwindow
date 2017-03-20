# Vidwindow [![CircleCI](https://circleci.com/gh/colinstein/vidwindow.svg?style=shield)](https://circleci.com/gh/colinstein/vidwindow) [![codecov](https://codecov.io/gh/colinstein/vidwindow/branch/master/graph/badge.svg)](https://codecov.io/gh/colinstein/vidwindow)
A graphical interface for scripting languages and other command line programs.

Reads from a file-system pipe and then uses the data read to draw some pixels in
a Window. It is not intended for high-througput graphics, for that you should
consider using Gosu to build an Interface specific for your application. This is
just a simple protocol to slap some graphical capabilities around otherwise
text-only applications.

## Getting Started
### Requirements
This gem depends on [Gosu](https://www.libgosu.org) to generate the user
interface. Gosu in turn depends on SDL2. You should follow the installation
instructions for Gosu on your platform before continuing.
  * [macOS](https://github.com/gosu/gosu/wiki/Getting-Started-on-OS-X)
  * [Linux](https://github.com/gosu/gosu/wiki/Getting-Started-on-Linux)

### Installation
If you are using bundler then add the following to your application's `Gemfile`:

        gem "vidwindow"

Then run `bundle install`. Otherwise, you can install this by running:

        gem install vidwindow

### Use as a Binary
This gem is intended to be used primarily as an application. You'd build an
application which writes to a FIFO, and then launch Vidwindow and specify that
same FIFO along with Width and Height information to create an interface.

  * `vidwindow /tmp/screen.fifo`: Run Vidwindow listening to `/tmp/screen.fifo`.
  * `vidwindow -w 320 -h 240 /tmp/screen.fio`: Run Vidwindow with a specific
  width (320 pixels) and height(240 pixels) listening to a `/tmp/screen.fifo`.
  * `vidwindow -v`: display version information.
  * `vidwindow -h`: display help.

### Use as a Library
Library use is not really intended, but if you find it necessary then you can
accomplish that in the usual way:

  1. Add vidwindow to your Gemfile
  2. Bundle install
  3. Add the following code:
  ```ruby
  require "vidwindow"
  vw = VidWindow::Screen.new(file: "somefile.fifo")
  vw.show
  ```

*Note:* This feature is still a work in progress.

## Development
After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[gem.colins.me](https://gem.colins.me).

### Running Tests
  1. `bundle install`
  2. `rake spec`

### Contributing
Bug reports and pull requests are welcome on GitHub at
https://github.com/colinstein/vidwindow.

## About the Screen Protocol
The FIFO should be written as a single continuous stream of bytes. A single
pixel is represented by writing 3 consecutive bytes representing the RGB values
for the pixl. Each set of three bytes represents one pixel. Pixels are drawn
form the top left corner of the screen to the bottom right corner of the screen
in order (think of the layout of VGA memory). At the end of one screen simply
start writing the next screen. Partial screen draws are not permissible, the
"previous" screen will continue to be displayed until all of the pixels for a
new screen have been read to replace it.

*Note:* This is a work in progress.

## License
This code is relesed under the MIT license.
The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).
