ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(
  :us           => '%m/%d/%y',
  :usy          => '%m/%d/%Y',
  :us_with_time => '%m/%d/%y, %l:%M %p',
  :short_day    => '%B %e, %Y',
  :long_day     => '%A, %e %B %Y',
  :sql_date     => '%Y-%m-%d'
)

ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(
  :month        => '%B',
  :short_month  => '%b',
  :short_day    => '%B %e, %Y',
  :mon_day      => '%B %e'
)
