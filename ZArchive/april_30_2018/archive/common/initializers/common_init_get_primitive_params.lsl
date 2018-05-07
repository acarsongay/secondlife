string common_init_get_primitive_params( string common ) {
	return llJsonSetValue(
		common_init_get_primitive_params_list_params( common ),
		(list) "get_primitive_params", (string) []);
}
string common_init_get_primitive_params_list_params( string common ) {
	return llJsonSetValue(common, (list) "get_primitive_params_list_params", "list_params");
}