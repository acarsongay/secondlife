#include "common_init_string_json.lsl"
#include "common_init_string_value.lsl"
#include "common_init_string_data.lsl"
#include "common_init_string_name.lsl"

string common_init_string( string common ) {
	return common_init_string_name( common_init_string_data( common_init_string_value( common_init_string_json( common ) ) ) );
}