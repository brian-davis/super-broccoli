# Link Shortener

Rails 5 JSON api app for building shortlinks.

Using mysql.

## Create ##

POST to localhost:3000/shortlinks

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

GET localhost:3000/z93E8E

Will redirect to https://www.example.com.

AUTH TODO
