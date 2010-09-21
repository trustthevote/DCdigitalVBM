# Version: OSDV Public License 1.2
# The contents of this file are subject to the OSDV Public License
# Version 1.2 (the "License"); you may not use this file except in
# compliance with the License. You may obtain a copy of the License at
# http://www.osdv.org/license/
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

# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|

  # Components used by the form builder to generate a complete input. You can
  # remove any of them, change the order, or even add your own components in the
  # stack. By inheriting your component from SimpleForm::Components::Base you'll
  # have some extra helpers for free.
  # config.components = [ :label, :input, :hint, :error ]

  # Default tag used on hints.
  # config.hint_tag = :span

  # Default tag used on errors.
  # config.error_tag = :span

  # You can wrap all inputs in a pre-defined tag.
  # config.wrapper_tag = :div

  # How the label text should be generated altogether with the required text.
  # config.label_text = lambda { |label, required| "#{required} #{label}" }

  # Series of attemps to detect a default label method for collection
  # config.collection_label_methods = [ :to_label, :name, :title, :to_s ]

  # Series of attemps to detect a default value method for collection
  # config.collection_value_methods = [ :id, :to_s ]

  # Collection of methods to detect if a file type was given.
  # config.file_methods = [ :file?, :public_filename ]

  # Default priority for time_zone inputs.
  # config.time_zone_priority = nil

  # Default priority for country inputs.
  # config.country_priority = nil
end
