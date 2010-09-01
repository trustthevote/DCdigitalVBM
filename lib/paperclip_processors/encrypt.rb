module Paperclip
  class Encrypt < Processor
    def initialize(file, options = {}, attachment = nil)
      super

      @file       = file
      @options    = options
      @attachment = attachment
    end
    
    def make
      # TODO: Use command line to encrypt the ballot
      @file
    end
  end
end
