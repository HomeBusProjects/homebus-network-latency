require 'homebus'
require 'dotenv/load'

class HomebusNetworkLatency::App < Homebus::App
  DDC = 'org.homebus.experimental.network-latency'

  def initialize(options)
    @options = options
    super
  end

  def setup!
    host_names = ENV['HOSTS'].split

    @devices = Array.new

    host_names.each do |host|
      @devices.push Homebus::Device.new name: "Network latency for #{host}",
                                        model: 'network latency',
                                        manufacturer: 'Homebus',
                                        serial_number:  host
    end
  end

  def work!
    @devices.each do |device|
      results = _ping(device.serial_number)

      if options[:verbose]
        puts device.serial_number, results
      end

      device.publish! DDC, results
    end

    sleep(60)
  end

  def _ping(ip)
    results = `ping -c 3 #{ip}`

    packet_loss = 0
    minimum_latency = 0
    average_latency = 0
    maximum_latency = 0
    standard_deviation = 0

    lines = results.split "\n"
    lines.each do |line|
      if line.match /(\d+\.\d+)\% packet loss/
        packet_loss = $1.to_f
      end

      if line.match /(\d+\.\d+)\/(\d+\.\d+)\/(\d+\.\d+)\/(\d+\.\d+) ms/
        minimum_latency = $1.to_f
        average_latency = $2.to_f
        maximum_latency = $3.to_f
        standard_deviation = $4.to_f
      end
    end

    return {
      packet_loss: packet_loss,
      minimum_latency: minimum_latency,
      average_latency: average_latency,
      maximum_latency: maximum_latency,
      standard_deviation: standard_deviation
    }
  end

  def name
    'homebus-network-latency'
  end

  def consumes
    []
  end

  def publishes
    [ DDC ]
  end

  def devices
    @devices
  end
end
