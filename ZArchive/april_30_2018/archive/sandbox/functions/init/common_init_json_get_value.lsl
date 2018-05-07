string common_init_json_get_value( string common ) {
	return common_init_json_set_value_string_value(
		common_init_json_set_value_list_specifiers(common));
}
string common_init_json_get_value_string_json( string common ) {
	return llJsonSetValue(common, ["json_get_value_string_json"], "string_json");
}
string common_init_json_get_value_list_specifiers( string common ) {
	return llJsonSetValue(common, ["json_get_value_list_specifiers"], "list_specifiers");
}