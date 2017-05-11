README
======

### Please Note:
* There is a version of this assessment running on Heroku. It is on a free dyno so it may 
take up to 30 seconds to start up the first time. It can be found here: https://jumo-assessment.herokuapp.com/

* Files (both uploaded and generated) are stored on an Amazon S3 bucket.

* Since a 'readme.txt' file was specifically requested, a copy of 'README.md' has been saved as such.

## Database structure

### Loan
* A loan is created from each line in the uploaded CSV file. We are assuming that they need not be unique.


### LoanFile
* Since the uploaded and generated files are almost identical in structure, the same model is used for both uploaded and 
generated CSV files. This enables archiving of uploaded files. If it were required to show what file was used for a 
particular import, then this can now easily be added to the loans' index view. Also, if this is not a requirement then
this functionality can be removed easily, whereas it would have been more difficult if there was an 'UploadedLoanFile' model and 
'GeneratedLoanFile' model.

### Product and Network

* These get created on file upload. The product and network names are required to be unique.


## Libraries used

### Gems used

* roo: Parsing .csv files
* rails-footnotes: Outputs detailed DB query information. Practically this is how n+1 queries are caught.
* jquery-datatables-rails: For sorting and pagination of displayed tables.
* annotate: Shows the fields of each model in the model.rb file itself.
* meta-request: Useful gem for showing controller/action etc. for each HTTP request.
* carrierwave: Handles file uploads.
* fog-aws: For uploading files to Amazon S3.
* bootstrap: Styling.


## Other Information


### Performance and Scaling Considerations

* Eager loading is used where applicable to avoid the N+1 problem.
* If Heroku is chosen as the production environment then the 30 second timeout for very long operations will cause the application
to error out. In such a case a background worker is required. Since this situation is not foreseeable, this has not been implemented, since
the user will be redirected to the page without the operation being completed. This may be confusing to a user.


### Further Considerations

* How do we prevent duplicate loans? I.e. could identical loans (same day, network, etc.) be legitimate data? We would 
assume that this is possible. A way to prevent users from uploading the same file multiple times is therefore to 
validate the uniqueness of the **start_date** and **end_date** for any uploaded file.