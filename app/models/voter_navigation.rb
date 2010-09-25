class VoterNavigation < Navigation

  def initialize(current_voter = nil)
    @current_voter = current_voter
  end
  
  def previous_item
    nav_items[:previous]
  end
  
  def next_item
    nav_items[:next]
  end
  
  private
  
  def nav_items
    @nav_items ||= begin
      n = p = nil
      
      if @current_voter
        reviewable = Registration.reviewable.all(:select => 'id')
        reviewable = reviewable.map { |r| r.id }
        current_index = reviewable.index(@current_voter.id)

        if current_index
          p_index = current_index - 1
          p_id    = p_index >= 0 ? reviewable[p_index] : nil
          
          n_index = current_index + 1
          n_id    = n_index < reviewable.size ? reviewable[n_index] : nil
          
          ids = [ p_id, n_id ].compact.uniq
          if ids.any?
            (Registration.find(ids) rescue []).each do |item|
              n = item if item.id == n_id
              p = item if item.id == p_id
            end
          end
        end
      end
      
      { :next => n, :previous => p }
    end
  end
  
end