/**
 * @author: Jaime Ramirez
*  I am a new handler
*/
component extends="BaseHandler"{
	//property name="bcrypt"		inject="@BCrypt";   //para encriptar hay que instalar paquete
    // Inject our service layer
	property name="personService"	inject="entityService:Person";

    //property name="messagebox" inject="messagebox@cbmessagebox";/* instalarlo para mensajes flashh **/
	// OPTIONAL HANDLER PROPERTIES
		
	/**
	* index
	*/
	
    /*function index( event, rc, prc ){
		event.setView( "persons/index" );
	}*/

	/**
	* create
	*/
	function create(
		event,
		rc,
		prc 
	){
		var oPerson = personService.populate( entityNew( "Person" ), rc );
		oPerson.setlastVisit( now() );//create date automatic
		var message = {};
		if( oPerson.isValid() ){
			oPerson.save();
			prc.response.setData( "Person Saved!")
			            .setStatusCode( 201 )
						.addMessage( "Ready" )
		                .setError( false );//true or false;	
					   
		}
		else{

			prc.response.setData( "" )
						.setStatusCode( 406 )
						.addMessage( oPerson.getValidationResults().getAllErrors() )
		                .setError( true );//true or false;		
		}
		
	    }

		/**
		* show
		*/
		
		function show(
			event,
			rc,
			prc
		){
			/**
			 * callback data to BD
			 */
			var responseData =  personService 
			                    .list( asQuery=false )
			                     // Map the entities to mementos
                                .map( function( item ){
				                     return item.getMemento( includes="id" );//return map elemments
								 } );
            //return json format api
			prc.response.setData( responseData )
		                .setStatusCode( 200 )
		                .addMessage( "Data response ok" )
		                .setError( false );//true or false;	
		}

		/**
		* update
		*/

		function update(
			event,
			rc,
			prc
		){
			try {
                //validate name
                if( rc.name != '' ){
					prc.person = personService.getOrFail( rc.id ?: -1 )
						.setName( rc.name );
					personService.save( prc.person )
						.getMemento( includes="id" );	
				
					prc.response.setData( "Data save ok" )
						.setStatusCode( 202 )
						.addMessage( "Data save" )
						.setError( false );//true or false;
				}else{

					prc.response.setData( "" )
						.setStatusCode( 417 )
						.addMessage( "Error to save entity: complete data pleace" )
						.setError( true );//true or false

				}
							  
			} catch ( any e ) {

				prc.response.setData( "" )
					.setStatusCode( 417 )
					.addMessage( "Error to save entity: #e.message# #e.detail#" )
					.setError( true );//true or false

			}
			
          
		}

		/**
		* delete
		*/

		function delete(
			event,
			rc,
			prc 
		){
			try{
				PersonService.getOrFail( rc.id ?: '' ).delete();
		        /**
				 * response ok
				 */					 
				prc.response.setData( "Data delete" )
					.setStatusCode( 202 )
					.addMessage( "Data delete" )
					.setError( false );/*true or false*/;
				
			} catch( any e ){
                // Any error response
				prc.response.setData( "" )
					.setStatusCode( 417 )
					.addMessage( "Error deleting entity: #e.message# #e.detail#" )
					.setError( true );//true or false;	
			}
		}
}
