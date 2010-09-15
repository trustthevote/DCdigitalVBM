module Paperclip
  class Encrypt < Processor
    def initialize(file, options = {}, attachment = nil)
      super

      @file           = file
      @recipient      = options[:geometry]
      @attachment     = attachment
      @current_format = File.extname(@file.path)
      @basename       = File.basename(@file.path, @current_format)
    end
    
    def make
      src = @file
      dst = Tempfile.new([@basename, 'gpg'].compact.join("."))
      dst.binmode

      raise PaperclipError, "GPG recipient wasn't set" if @recipient.blank?
      
      begin
        run("rm", "-f \"#{File.expand_path(dst.path)}\"")
        run("gpg", "-o \"#{File.expand_path(dst.path)}\" -e -r \"#{@recipient}\" \"#{File.expand_path(src.path)}\"")
      rescue PaperclipCommandLineError
        raise PaperclipError, "couldn't be encrypted. Please try again later."
      end

      dst
    end
    
    def run(cmd, params = "", expected_outcodes = 0)
      command = %Q<#{%Q[#{cmd} #{params}].gsub(/\s+/, " ")}>
      command = "#{command} 2>&1"

      Paperclip.log(command)

      output = `#{command}`
      unless [expected_outcodes].flatten.include?($?.exitstatus)
        Paperclip.log output
        raise PaperclipCommandLineError, "Error while running #{cmd}"
      end

      output
    end
    
    def bit_bucket #:nodoc:
      File.exists?("/dev/null") ? "/dev/null" : "NUL"
    end
    
  end
end
