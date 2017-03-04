class SpeechEngine
  OS_LOOKUP = {
    'armv7l-linux-eabihf' => 'raspberrypi',
    'x86_64-darwin16' => 'osx',
  }.freeze

  @volume = 100

  class << self
    def say(sentence, options = {})
      if options[:volume] && options[:volume] != @volume
        self.volume = options[:volume]
      end

      run_command speech_command(sentence)
    end

    def volume
      @volume
    end

    # this command can take a while, be aware that it's possible
    # for the engine to begin speaking before volume is fully set
    def volume=(new_volume)
      return if @volume == new_volume
      @volume = new_volume
      run_command volume_command(new_volume)
    end

    private

    def speech_command(sentence = 'thing happened')
      case OS_LOOKUP[RUBY_PLATFORM]
      when 'raspberrypi'
        %(echo "#{sentence}" | festival --tts)
      when 'osx'
        %(say "#{sentence}")
      end
    end

    def volume_command(new_volume)
      scale_to_range = ->(value, range) { range[((range.size - 1) * (value.to_i.clamp(0, 100) / 100.0)).round] }
      case OS_LOOKUP[RUBY_PLATFORM]
      when 'raspberrypi'
        # raspberry pi's actual volume range is -10239..400, but anything below -3900 is inaudible
        # scaled_volume = scale_to_range.call(new_volume, (-10_239..400).to_a)
        scaled_volume = scale_to_range.call(new_volume, (-3900..400).to_a)
        %(amixer set PCM -- #{scaled_volume})
      when 'osx'
        scaled_volume = scale_to_range.call(new_volume, (0..7).step(0.1).to_a.map { |x| x.round(1) })
        %(osascript -e "set Volume #{scaled_volume}")
      end
    end

    def run_command(cmd)
      Rails.logger.info "SpeechEngine.run_command(#{cmd.inspect})"
      pid = spawn(cmd, [:out, :err] => File::NULL)
      Process.detach(pid)
    end
  end
end
