#include "common_init_string_json.lsl"
#include "common_init_string_value.lsl"

string common_init_string( string common ) {
	return common_init_string_value( common_init_string_json( common ) );
}