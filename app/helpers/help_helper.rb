module HelpHelper

  def help_section(n, options = {})
    section = /\d+/ =~ n.to_s ? t("help.section_#{n}") : find_section_by_slug(n)
    title   = section[:title]
    slug    = section[:slug]
    pages = []

    section.each do |k, page|
      next unless /page_\d+/ =~ k.to_s

      link = page[:link]
      pages << content_tag(:li, link_to(page[:title], link ? link : help_page_path(slug, page[:slug])))
    end
    
    options[:bare_li] ? pages : content_tag(:li, [
      content_tag(:h2, title),
      content_tag(:ul, pages)
    ])
  end

  def help_questions(section, page)
    page_data = find_page_by_slug(section, page)
    return nil if page_data.nil?
    
    questions = []
    page_data.each do |k, v|
      questions << [ v[:q], v[:a] ] if /question_\d+/ =~ k.to_s
    end
    
    questions
  end

  def current_section
    @current_section ||= find_section_by_slug(@section)
  end
  
  def current_page
    @current_page ||= find_page_by_slug(@section, @page)
  end
  
  private
    
  def find_page_by_slug(section, page)
    section_data = find_section_by_slug(section)
    section_data.each do |k, v|
      next unless /page_\d+/ =~ k.to_s
      return v if v[:slug] == page
    end

    return nil
  end
  
  def find_section_by_slug(section)
    sections = t("help")
    sections.each do |k, v|
      next unless /section_\d+/ =~ k.to_s
      return v if v[:slug] == section
    end
    
    return nil
  end
  
end
