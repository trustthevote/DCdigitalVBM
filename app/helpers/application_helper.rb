# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Typed translation takes the type of the voting process (physical or digital) into
  # account when creating the key
  def tt(key)
    t tkey(key), :default => t(key)
  end

  # Generates the voting type dependent translation key
  def tkey(key)
    ".#{voting_type}#{key}"
  end
  
  # Generates ul-li list of pipe-separated steps stored in the given key
  def pipe_list(items)
    content_tag(:ul, items.split('|').map { |l| content_tag(:li, l) })
  end
  
  # Displays a standard tip
  def tip(title, text)
    content_tag(:div, [
      content_tag(:div, nil, :class => "help-popup-icon"),
      content_tag(:div, [
        content_tag(:h4, title),
        text
      ], :class => "help-popup")
    ], :class => "help-popup-wrapper")
  end
  
  def section_header(n)
    content_tag(:header, [
      content_tag(:h1, tt(".step_#{n}.title")),
      content_tag(:h2, tt(".step_#{n}.instruction"), :class => "help-popup-attached"),
      tip(tt(".step_#{n}.instruction"), tt(".step_#{n}.tip")),
      content_tag(:p, tt(".step_#{n}.summary"), :class => "help-popup-attached")
    ])
  end
  
  def page_options(options = {})
    @page_id      = options[:id]
    @page_class   = options[:class]
    @no_keydates  = options[:no_keydates] || false
    @no_subheader = options[:no_subheader] || false
    @h1           = options[:h1]
    @h2           = options[:h2]
  end
end
