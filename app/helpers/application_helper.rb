# Version: OSDV Public License 1.2
# The contents of this file are subject to the OSDV Public License
# Version 1.2 (the "License"); you may not use this file except in
# compliance with the License. You may obtain a copy of the License at
# The contents of this file are subject to the OSDV Public Licensewww.osdv.org/license/
# Software distributed under the License is distributed on an "AS IS"
# basis, WITHOUT WARRANTY OF ANY KIND, either express or implied.
# See the License for the specific language governing rights and limitations
# under the License.
# 
# The Original Code is:
# 	TTV UOCAVA Ballot Portal.
# The Initial Developer of the Original Code is:
# 	Open Source Digital Voting Foundation.
# Portions created by Open Source Digital Voting Foundation are Copyright (C) 2010.
# All Rights Reserved.
# 
# Contributors: Paul Stenbjorn, Aleksey Gureiev, Robin Bahr,
# Thomas Gaskin, Sean Durham, John Sebes.

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
    return nil if title.nil? || text.nil?
    content_tag(:div, [
      content_tag(:div, nil, :class => "help-popup-icon"),
      content_tag(:div, [
        content_tag(:h4, title),
        text
      ], :class => "help-popup")
    ], :class => "help-popup-wrapper")
  end
  
  # Rendering section header with optional additional content block and
  # a tip.
  def section_header(n, options = {}, &block)
    tip_tag = options[:no_tip] ? nil : tip(tt(".step_#{n}.instruction"), tt(".step_#{n}.tip"))
    image   = options[:image] ? section_image_tag(options[:image], :alt => options[:image_alt]) : nil

    additional_content = nil
    if block_given?
      additional_content = capture(&block)
    end
    
    el_class = tip_tag ? "help-popup-attached" : nil
    header  = content_tag(:header, [
      content_tag(:h1, tt(".step_#{n}.title")),
      content_tag(:h2, tt(".step_#{n}.instruction"), :class => el_class),
      tip_tag,
      content_tag(:p, tt(".step_#{n}.summary"), :class => el_class),
      additional_content
    ].compact)
        
    [ header, image ].compact
  end
  
  # Quick section image tag
  def section_image_tag(name, options = {})
    image_tag("/images/#{name}.png", :alt => options[:alt], :width => "150", :height => "150")
  end
  
  def page_options(options = {})
    @page_id      = options[:id]
    @page_class   = options[:class]
    @no_keydates  = options[:no_keydates] || false
    @no_subheader = options[:no_subheader] || false
    @about        = options[:about]
    @h1           = options[:h1]
    @h2           = options[:h2]
  end
  
  def button_class(disabled = false)
    klass = [ 'button' ]
    klass << "disabled" if disabled
    klass * ' '
  end
end
