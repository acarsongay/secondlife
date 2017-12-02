//Datatypes
#include "initializers/common_init_string.lsl"
#include "initializers/common_init_list.lsl"
#include "initializers/common_init_key.lsl"
#include "initializers/common_init_integer.lsl"

#include "initializers/common_init_json.lsl"
//States

//Events
#include "initializers/common_init_dataserver.lsl"

string common_init_datatypes( string common ) {
	return common_init_integer( common_init_key( common_init_json( common_init_list( common_init_string( common ) ) ) ) );
}
string common_init_events( string common ) {
	return common_init_dataserver( common );
}
string common_init( string common ) {
	return common_init_events( common_init_datatypes( common ));
}