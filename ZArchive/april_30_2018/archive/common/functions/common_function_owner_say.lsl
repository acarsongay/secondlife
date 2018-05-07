string common_fuction_owner_say( common ) {
	llOwnerSay(llJsonGetValue(common, ["owner_say_string_value"]));
	return common;
}