string common_function_json_get_value( string common ) {
	return llJsonGetValue(common, (list) llJsonGetValue(common, ["get_value"]));
}
string common_init( string common ) {
	return common_init_json_get_value
}
string common_init_json_get_value( string common ) {
	return common_init_json_get_value_string_json( 
		common_init_json_get_value_list_specifiers( common ));
}
string common_init_json_get_value_string_json( string common ) {
	return llJsonSetValue(common, ["json_get_value_string_json"], "string_json");
}
string common_init_json_get_value_list_specifiers( string common ) {
	return llJsonSetValue(common, ["json_get_value_list_specifiers"], "list_specifiers");
}


string common;

default {
	state_entry()
	{
		common = common_init( common );
	}
	listen( integer channel, string name, key id, string message )
    {

    }
    dataserver(key query_id, string data)
    {
    	common = llJsonSetValue(common, ["string_data"], data);
    }
    changed( integer mask )
    {

    }
	state_exit()
	{
		//common_delete
	}
}