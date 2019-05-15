# frozen_string_literal: true

desc 'expire shortlink records after 90 days, allowing re-use of limited slugs'
task set_expired: :environment do
  Shortlink.expire_ready.update_all({ status: :expired })
end
