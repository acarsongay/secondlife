string common_init_acos( string common ) {
	return llJsonSetValue( 
		common_init_acos_float_value( common ), 
		(list) "common_init_acos", 
		""
	);
}
string common_init_acos_float_value( string common ) {
	return llJsonSetValue( common, (list) "common_init_aco_float_value", "float_value");
}