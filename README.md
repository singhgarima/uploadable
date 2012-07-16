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

   * You can use the following two methods for conversions and transformations of the fields
		* transform_<attr_name>_for_upload
			* This method is only available for fields in the table. Doesn't works with external dependencies
			* It should always return the transformed value only
		* convert_<attr_name>_for_upload : this is to load external dependencies in the table e.g. id fields
			* It should return the hash with new field name as key and new field value as value
    		
					class Track < ActiveRecord::Base
			  	  	  uploadable :mandatory_fields => [:name], :optional_fields => [:top_rated], :external_fields => [:album]
     			  	  attr_accessible :album_id, :name

         			  belongs_to :album
 
    			      def self.tranform_top_rated_for_upload value
	    		        value == 'Y' ? true : false
    	    		  end
  
    		    	  def self.convert_album_for_upload value
	    		        { :album_id => Album.where( :title => value).first.id }
    		    	  end
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

