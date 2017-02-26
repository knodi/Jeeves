class SpeechEngine
  OS = {
    'armv7l-linux-eabihf' => 'raspberrypi',
    'x86_64-darwin16' => 'osx',
  }[RUBY_PLATFORM]

  def self.say(sentence)
    pid = case OS 
    when 'raspberrypi'
      spawn(%Q{echo "#{sentence}" | festival --tts})
    when 'osx'
      spawn(%Q{say "#{sentence}"})
    end
    Process.detach(pid)
  end
  
end
