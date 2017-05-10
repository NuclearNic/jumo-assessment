README
======

# PLEASE NOTE:
* There is a version of this assessment running on Heroku. It is on a free dyno so it may 
take up to 30 seconds to start up the first time. It can be found here: https://jumo-assessment.herokuapp.com/


### Database structure

# Loan
* datetime field in case of different timezones


# LoanFile
* Since the uploaded and generated files are almost identical in structure

# Product

# Network


### Gems used

* roo: Parsing .csv files
* rails-footnotes: Outputs detailed DB query information. Practically this is how n+1 queries are caught.
* jquery-datatables-rails: For sorting and pagination of displayed tables.

### Considerations

* How do we prevent duplicate loans? I.e. could identical loans (same day, network, etc.) be legitimate data? 