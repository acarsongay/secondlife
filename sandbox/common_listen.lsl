string common_listen( string common ) {
	return llJsonSetValue(common, ["common_listen"], 
		(string) llListen(
			(integer) llJsonGetValue(common, ["common_listen_integer_channel"]), 
			llJsonGetValue(common, ["common_listen_string_name"]),
			(key) llJsonGetValue(common, ["common_listen_key_id"]),
			llJsonGetValue(common, ["common_listen_string_msg"]))
		);
}