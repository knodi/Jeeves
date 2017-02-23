class SpeechEngine
  OS = {
    'armv7l-linux-eabihf' => 'raspberrypi',
    'x86_64-darwin16' => 'osx',
  }[RUBY_PLATFORM]

  def self.say(sentence)
    case OS 
    when 'raspberrypi'
      Process.daemon(%Q{echo "#{sentence}" | festival --tts})
    when 'osx'
      Process.daemon(%Q{say "#{sentence}"})
    end
  end
  
end
