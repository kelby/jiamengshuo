# rackup faye.ru -E production -s thin
require 'faye'
Faye::WebSocket.load_adapter('thin')

bayeux = Faye::RackAdapter.new(:mount => '/faye', :timeout => 25)

run bayeux
