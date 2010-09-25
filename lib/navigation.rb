class Navigation
  def initialize(options = {})
    @next_item = options[:next]
    @previous_item = options[:previous]
  end
  
  # Returns TRUE if there's the next item
  def has_next?
    !next_item.nil?
  end
  
  # Returns TRUE if there's the previous item
  def has_previous?
    !previous_item.nil?
  end
  
  # Returns next item
  def next_item
    @next_item.is_a?(Proc) ? @next_item.call : @next_item
  end
  
  # Returns previous item
  def previous_item
    @previous_item.is_a?(Proc) ? @previous_item.call : @previous_item
  end
end
