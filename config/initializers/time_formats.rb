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

ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(
  :us           => '%m/%d/%y',
  :usy          => '%m/%d/%Y',
  :us_with_time => '%m/%d/%y, %l:%M %p',
  :short_day    => '%B %e, %Y',
  :long_day     => '%A, %e %B %Y',
  :sql_date     => '%Y-%m-%d',
  :detailed     => '%l:%M %p, %B %d, %Y'
)

ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(
  :month        => '%B',
  :short_month  => '%b',
  :short_day    => '%B %e, %Y',
  :mon_day      => '%B %e'
)
