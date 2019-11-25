component persistent="true" table="Person" accessors="true" extends="cborm.models.ActiveEntity"{

	// Primary Key
	property name="id" fieldtype="id" column="id" generator="native" setter="false";
	
	// Properties
	property name= "name"       ormtype=" string ";
	property name= "age"        ormtype=" numeric ";
	property name= "lastVisit"  ormtype=" timestamp ";
	
	// Validation
	this.constraints = {
		"name"          = {	required = true }, 
        "age"           = { required = true },
        "lastVisit"     = { required = true }
	};
	
	// Constructor
	function init(){
		super.init( useQueryCaching="false" );
		return this;
	}
}