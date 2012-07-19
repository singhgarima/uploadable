[![Build Status](https://secure.travis-ci.org/singhgarima/uploadable.png)](http://travis-ci.org/singhgarima/uploadable)

Uploadable - A simple gem, with custom options to upload a csv to a model

*How to use?*

1. How to make a model uploadable
  * use keyword uploadable and mandatory_fields & optional_fields 
  * for setting up the fields which the gem should read and upload to model
  * any other field would be ignored 

            class Car < ActiveRecord::Base  
              uploadable :mandatory_fields => [:company, :model], 
                     :optional_fields => [:price, :category]

              validates_presence_of :company, :model
              validates_numericality_of :price, :greater_than => 100000
              validates_inclusion_of :category, :in => %w(two three four)
            end

2. Using csv partial upload : *upload_from_csv*
  * You can use function upload_from_csv which will upload records without errors
  
            Car.upload_from_csv "Company,Model,Price,Category\n,800,250000,four\nHonda,City,8000000,four"
  * Output - 
  
            [
             #<Car id: nil, company: nil, model: "800", price: 250000, category: "four", created_at: nil, updated_at: nil>, 
             #<Car id: 27, company: "Honda", model: "City", price: 8000000, category: "four", created_at: "2012-07-01 10:32:04", updated_at: "2012-07-01 10:32:04">
            ]
</pre>

3. Using transactional upload : *upload_from_csv!*

             Car.upload_from_csv! "Company,Model,Price,Category\n,800,250000,four\nHonda,City,8000000,four"
    if any record contains error, it wouldn't upload, else would upload all
    returns you the array of objects (uploaded or unuploaded)
          </pre>

*Note: You can use errors method and iterate over the list of objects to collect errors*

