require 'homebus/options'
require 'homebus-network-latency/version'

class HomebusNetworkLatency::Options < Homebus::Options
  def app_options(op)
  end   

  def version
    HomebusNetworkLatency::VERSION
  end

  def name
    'homebus-network-latency'
  end
end
