README
======

### Database structure

#Loan
* datetime field in case of different timezones


#LoanFile
* Since the uploaded and generated files are almost identical in structure
Product
Network



### Gems used

* roo: Parsing .csv files
* rails-footnotes: Outputs detailed DB query information. Practically this is how n+1 queries are caught.

### Considerations

* How do we prevent duplicate loans? I.e. could identical loans (same day, network, etc.) be legitimate data? 