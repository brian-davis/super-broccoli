# frozen_string_literal: true

# mysql> describe users;
# +-------------+--------------+------+-----+---------+----------------+
# | Field       | Type         | Null | Key | Default | Extra          |
# +-------------+--------------+------+-----+---------+----------------+
# | id          | bigint(20)   | NO   | PRI | NULL    | auto_increment |
# | client_name | varchar(255) | NO   |     | NULL    |                |
# | auth_token  | varchar(255) | YES  | UNI | NULL    |                |
# | created_at  | datetime     | NO   |     | NULL    |                |
# | updated_at  | datetime     | NO   |     | NULL    |                |
# +-------------+--------------+------+-----+---------+----------------+

# User is the Auth model for the JSON API.
class User < ApplicationRecord
  has_secure_token :auth_token

  has_many :shortlinks, dependent: :destroy
end
