string common_init_set_link_primitive_params_fast( string common ) {
	return common_init_set_link_primitive_params_fast_integer_link(
		common_init_set_link_primitive_params_fast_list_rules( common ));
}
string common_init_set_link_primitive_params_fast_integer_link( string common ) {
	return llJsonSetValue(common, (list) "set_link_primitive_params_fast_integer_link", "integer_link");
}
string common_init_set_link_primitive_params_fast_list_rules( string common ) {
	return llJsonSetValue(common, (list) "set_link_primitive_params_fast_list_rules", "list_rules");
}