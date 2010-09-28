class ReviewStats
  def total
    @total ||= Registration.count
  end
  
  def returned
    @returned ||= Registration.returned.count
  end
  
  def reviewed
    @reviewed ||= Registration.reviewed.count
  end
  
  def unconfirmed
    @unconfirmed ||= Registration.reviewed.unconfirmed.count
  end
  
end
