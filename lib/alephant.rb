require 'aws-sdk'
require 'env'
require 'json'

require 'models/cache'
require 'models/renderer'
require 'models/sequencer'

module Alephant

  def self.run
    cache_id = "s3-render-example"

    queue = AWS::SQS.new.queues.create(cache_id)
    cache = Cache.new(cache_id)
    sequencer = Sequencer.new(cache_id)
    renderer = Renderer.new(cache_id)

    t = Thread.new do
      puts "Polling queue..."
      queue.poll do |msg|
        data = JSON.parse(msg.body)

        if data["seq"] > sequencer.last_seen
          puts "Rendering from message #{data["seq"]}"

          content = renderer.render(data)
          cache.put(cache_id, content)
          sequencer.last_seen = data["seq"]
        end
      end
    end

    t.join
  end
end
