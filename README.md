# Link Shortener

Rails 5 JSON api app for building shortlinks.

Using mysql.

## Create ##

POST to localhost:3000/shortlinks

Auth:

Set an 'Auth-Token' header for an existing user:

    request.headers['Auth-Token'] = 'abc123'

JSON request body:

    {
      "shortlink": {
        "source": "https://www.example.com"
      }
    }

JSON response body:

    {
        "shortlink": {
            "source": "https://www.example.com",
            "slug": "xtJGkB"
        }
    }


## Click ##

GET localhost:3000/xtJGkB

Will redirect to https://www.example.com.


## Deployment ##

Whenever gem sets crontab to run update rake task:

    $ whenever --update-crontab link_shortener_api
    $ crontab -l
