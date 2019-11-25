component{

	function configure(){
		// Set Full Rewrites
		setFullRewrites( true );

		/**
		 * --------------------------------------------------------------------------
		 * App Routes
		 * --------------------------------------------------------------------------
		 *
		 * Here is where you can register the routes for your web application!
		 * Go get Funky!
		 *
		 */

		// A nice healthcheck route example
		route("/healthcheck",function(event,rc,prc){
			return "Ok!";
		});
        /**
		 * if add new routes: reestart server
		 */
		// API Echo
		get( "/api/index", "Echo.index" );
		get( "/api/test", "Echo.test" );
		/**
		 * Undocumented DRUD
		 */
		post( "/api/person/save", "persons.create" );
		delete( "/api/person/delete", "persons.delete" );
		put( "/api/person/update", "persons.update");
		get( "/api/person/show", "persons.show" );
	
		// Conventions based routing
		route( ":handler/:action?" ).end();


		
	}

}