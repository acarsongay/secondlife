
string common_init_dataserver_key_queryid( string common ) {
	return llJsonSetValue(common, ["dataserver_key_queryid"], "key_queryid");
}
string common_init_dataserver_string_data( string common ) {
	return llJsonSetValue(common, ["dataserver_string_data"], "string_data");
}
string common_init_dataserver( string common ) {
	return common_init_dataserver_string_data(
		common_init_dataserver_key_queryid(common));
}