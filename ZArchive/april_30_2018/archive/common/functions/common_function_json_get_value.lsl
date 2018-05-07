string common_function_json_get_value( string common ) {
	return llJsonGetValue(common, (list) llJsonGetValue(common, ["get_value"]));
}