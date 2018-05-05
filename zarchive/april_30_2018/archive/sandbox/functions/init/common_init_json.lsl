#include "common_init_json_get_value.lsl"
#include "common_init_json_set_value.lsl"

string common_init_json( string common ) {
	return common_init_json_set_value( common_init_json_get_value( common ) );
}