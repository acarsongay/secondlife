string lindon_lab_number_of_notecard_line( string common ) {
	string json;

	json = llJsonGetValue(common, (list) "json");

	string name;

	name = llJsonGetValue(json, (list) "string_name");

	llJsonSetValue(json, (list) "handle_key", (string) llGetNotecardLine(name,line));

	return llJsonSetValue(common, (list) "json", json);
}