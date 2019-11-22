/**
* I am a new handler
*/
component extends="BaseHandler"{
	//property name="bcrypt"		inject="@BCrypt";   //para encriptar hay que instalar paquete

	property name="PersonService"	inject="entityService:Person";

    //property name="messagebox" inject="messagebox@cbmessagebox";/* instalarlo para mensajes flashh **/
	// OPTIONAL HANDLER PROPERTIES

	this.prehandler_only 	     = "";
	this.prehandler_except   	 = "";
	this.posthandler_only 	     = "";         // Why ?
	this.posthandler_except      = "";
	this.aroundHandler_only      = "";
	this.aroundHandler_except    = "";

	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	
	this.allowedMethods = {};

	// Inject our service layer
	//property name="personService" inject="entityService:Person";
	/**
	IMPLICIT FUNCTIONS: Uncomment to use
	function preHandler( event, rc, prc, action, eventArguments ){
	}
	function postHandler( event, rc, prc, action, eventArguments ){
	}
	function aroundHandler( event, rc, prc, targetAction, eventArguments ){
		// executed targeted action
		arguments.targetAction( event );
	}
	function onMissingAction( event, rc, prc, missingAction, eventArguments ){
	}
	function onError( event, rc, prc, faultAction, exception, eventArguments ){
	}
	function onInvalidHTTPMethod( event, rc, prc, faultAction, eventArguments ){
	}
	*/
		
	/**
	* index
	*/
	
	function index( event, rc, prc ){
		event.setView( "persons/index" );
	}

	/**
	* create
	*/
	function create( event, rc, prc ){

		var oPerson = PersonService.populate( entityNew( "Person" ), rc );
		oPerson.setlastVisit(now());//create date automatic
		var message = {};
		if( oPerson.isValid() ){
			oPerson.save();
			prc.response.setData( "Person Saved!")
			            .setStatusCode(200)
						.addMessage("Ready")
		                .setError(false);/*true or false*/;	;
					   
		}
		else{
			prc.response.setData("")
						.setStatusCode(404)
						.addMessage(oPerson.getValidationResults().getAllErrors())
		                .setError(true);/*true or false*/;		
		}
		
	    }

		/**
		* show
		*/
		function show( event, rc, prc ){
			return getInstance( "Person" )
			      .get( rc.id ?: 0 )
			      .getMemento( includes="id" );
		}

		/**
		* update
		*/
		function update( event, rc, prc ){
			event.setView( "persons/update" );
		}

		/**
		* delete
		*/
		function delete( event, rc, prc ){
			event.setView( "persons/delete" );
		}


	
}
