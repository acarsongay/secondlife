
#include "init/common_init_json_set_value.lsl"


string common_delete_json_set_value_string_json( string common ) {
	return llJsonSetValue(common, ["json_set_value_string_json"], JSON_DELETE);
}
string common_delete_json_set_value_list_specifiers( string common ) {
	return llJsonSetValue(common, ["json_set_value_list_specifiers"], JSON_DELETE);
}
string common_delete_json_set_value_string_value( string common ) {
	return llJsonSetValue(common, ["json_set_value_string_value"], JSON_DELETE);
}

string common_json_set_value( string common ) {
	return llJsonSetValue(common, list specifiers, string value)
}
string common_json_set_value_string_json( string common ) {
	return llJsonGetValue(common, ["json_set_value_string_json"])
}
string common_json_set_value( string common ) {
	return llJsonSetValue(
		common, 
		[	
			llJsonGetValue(common, ["common_json_set_value_string_json"]),
			llJsonGetValue(common, ["common_json_set_value_list_specifiers"])
		], 
		llJsonGetValue(
			common, 
			[
				"common_json_set_value_string_value"
			]
		)
	);
}