require 'paramedic'

def produce_hash(string)
  hash = {}

  pieces = string.split('&')

  pieces.each do |piece|
    sub = piece.split('=')
    hash[sub[0]] = sub[1]
  end

  hash
end
