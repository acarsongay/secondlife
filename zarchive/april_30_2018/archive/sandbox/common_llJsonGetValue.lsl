string common_json_get_value( string common ) {
	return llJsonGetValue(
		llJsonGetValue(common, llJson2List(llJsonGetValue(common, ["string_json"]))), 
		llList2Json(llJsonGetValue(common, llJson2List(llJsonGetValue(common, ["list_specifiers"]))))
	);
}
string common_json_get_value_string_json( string common ) {
	return llJsonGetValue(common, llJson2List(llJsonGetValue(common, ["string_json"])));
}
string common_json_get_value_list_specifiers( string common ) {
	return llList2Json(llJsonGetValue(common, llJson2List(llJsonGetValue(common, ["list_specifiers"]))));
}


string common_json_set_value( string common ) {
	return llJsonSetValue(llJsonGetValue(common, llJson2List(llJsonGetValue(common, ["string_json"]))), 
		llList2Json(llJsonGetValue(common, llJson2List(llJsonGetValue(common, ["list_specifiers"]))))), 
		llJsonGetValue(common, llJson2List(llJsonGetValue(common, ["string_value"])))
	);
}