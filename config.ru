require 'img2png'

use Rack::Static, :urls => ['/css', '/js', '/images', '/about'], :root => 'public'

run Controller