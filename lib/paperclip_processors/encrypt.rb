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

      `rm -f "#{File.expand_path(dst.path)}"; gpg -o "#{File.expand_path(dst.path)}" -e -r "#{@recipient}" "#{File.expand_path(src.path)}"`
      
      dst
    end
  end
end
