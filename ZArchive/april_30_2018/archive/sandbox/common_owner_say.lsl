string common_owner_say( string common ) {
	llOwnerSay(llJsonGetValue(common,["common_owner_say"]));
	return common;
}