class SpeechEngine
  OS_LOOKUP = {
    'armv7l-linux-eabihf' => 'raspberrypi',
    'x86_64-darwin16' => 'osx',
  }

  @@volume = 100

  class << self
    def say(sentence, options = {})
      if options[:volume] && options[:volume] != @@volume
        volume = options[:volume]
      end

      cmd = speech_command(sentence)
      Rails.logger.info("Speech engine executing command: #{cmd.inspect}")
      pid = spawn()
      Process.detach pid
    end

    def speech_command(sentence = 'thing happened')
      case OS_LOOKUP[RUBY_PLATFORM]
      when 'raspberrypi'
        %Q{echo "#{sentence}" | festival --tts}
      when 'osx'
        %Q{say "#{sentence}"}
      end
    end

    def volume
      @@volume
    end

    #this command can take a while, be aware that it's possible for the engine to finish speaking before volume is fully set
    def volume=(new_volume)
      @@volume = new_volume
      cmd = volume_command(new_volume)
      Rails.logger.info cmd
      pid = spawn(cmd)
      Process.detach(pid)
    end

    def volume_command(new_volume)
      scale_to_range = ->(value, range) { range[((range.size - 1) * (value.to_i.clamp(0, 100) / 100.0)).round] }
      case OS_LOOKUP[RUBY_PLATFORM]
      when 'raspberrypi'
        scaled_volume = scale_to_range.call(new_volume, (-10239..400).to_a)
        %Q{amixer set PCM -- #{scaled_volume}}
      when 'osx'
        scaled_volume = scale_to_range.call(new_volume, (0..7).step(0.1).to_a.map{|x| x.round(1)})
        %Q{osascript -e "set Volume #{scaled_volume}"}
      end
    end

  end
end
