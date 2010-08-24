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
  def tip(text)
    image_tag "question.gif", :title => text, :class => "tip"
  end
end
