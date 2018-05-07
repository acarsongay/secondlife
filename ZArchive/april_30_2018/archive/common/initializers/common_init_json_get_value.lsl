#include "common_init_get_value.lsl"

string common_init_json_get_value( string common ) {
	return common_init_get_value (
		common_init_json_get_value_list_specifiers(
		common_init_json_get_value_string_json( common ) ) );
}
string common_init_json_get_value_string_json( string common ) {
	return llJsonSetValue(common, ["json_get_value_string_json"], "string_json");
}
string common_init_json_get_value_list_specifiers( string common ) {
	return llJsonSetValue(common, ["json_get_value_list_specifiers"], "list_specifiers");
}