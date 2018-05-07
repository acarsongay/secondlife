string common_init_get_notecard_line( string common ) {
	return common_init_get_notecard_line_queryid(
		common_init_get_notecard_line_integer_line(
		common_init_get_notecard_line_string_name( common ) ) );
}
string common_init_get_notecard_line_string_name( string common ) {
	return llJsonSetValue(common, ["get_notecard_line_string_name"], "string_name");
}
string common_init_get_notecard_line_integer_line( string common ) {
	return llJsonSetValue(common, ["get_notecard_line_integer_line"], "integer_line");
}
string common_init_get_notecard_key_queryid( string common ) {
	return llJsonSetValue(common, ["get_notecard_key_queryid"], "key_queryid");
}