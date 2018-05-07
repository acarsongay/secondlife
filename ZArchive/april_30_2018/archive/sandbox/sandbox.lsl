//#line 1 "/home/andrew/Desktop/github/secondlife/common/init/common_init_string_json.lsl"
string common_init_string_json( string common ) {
	return llJsonSetValue(common, ["string_json"], "{}");
}//#line 1 "/home/andrew/Desktop/github/secondlife/common/init/common_init_string_value.lsl"
string common_init_string_value( string common ) {
	return llJsonSetValue(common, ["string_value"], "");
}//#line 1 "/home/andrew/Desktop/github/secondlife/common/init/common_init_string_data.lsl"
string common_init_string_data( string common ) {
    return llJsonSetValue(common, ["string_data"], "");
}//#line 1 "/home/andrew/Desktop/github/secondlife/common/init/common_init_string_name.lsl"
string common_init_string_name( string common ) {
    return llJsonSetValue(common, ["string_name"], "");
}
//#line 6 "/home/andrew/Desktop/github/secondlife/common/init/common_init_string.lsl"
string common_init_string( string common ) {
	return common_init_string_name( common_init_string_data( common_init_string_value( common_init_string_json( common ) ) ) );
}//#line 1 "/home/andrew/Desktop/github/secondlife/common/init/common_init_list_specifiers.lsl"
string common_init_list_specifiers( string common ) {
	return llJsonSetValue(common, ["list_specifiers"], "[]");
}
//#line 3 "/home/andrew/Desktop/github/secondlife/common/init/common_init_list.lsl"
string common_init_list( string common ) {
	return common_init_list_specifiers( common );
}