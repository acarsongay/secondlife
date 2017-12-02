string common_clear( string common ) {
	return llJsonSetValue(common, (list) llJsonGetValue(common, (list) "clear"), JSON_DELETE);
}