#include "init/common_init_string.lsl"
#include "init/common_init_list.lsl"
#include "init/common_init_json.lsl"

string common_init_datatypes( string common ) {
	return common_init_json( common_init_list( common_init_string( common )));
}
string common_init( string common ) {
	return common_init_datatypes( common );
}
