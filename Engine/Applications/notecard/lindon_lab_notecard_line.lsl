string lindon_lab_notecard_line( string common ) {
	string json;

	json = llJsonGetValue(common, (list) "json");

	string name;
	string line;

	name = llJsonGetValue(json, (list) "string_name");
	line = llJsonGetValue(json, (list) "integer_line");

	llJsonSetValue(json, (list) "handle_key", (string) llGetNotecardLine(name,line);

	return llJsonSetValue(common, (list) "json", json);
}