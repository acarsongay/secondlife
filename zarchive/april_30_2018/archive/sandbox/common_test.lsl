string validate_json( string json ) {
	return (llJsonValueType(json, []) == JSON_INVALID) ||
}
string validate_json_invalid( string json_invalid ) {

}
string validate_json_object( strig json_object ) {

}
string validate_json_array( string json_array ) {

}
string validate_json_number( string json_number ) {

}
string validate_json_string( string json_string ) {

}
string validate_json_null( string json_null ) {

}
string validate_json_true( string json_true ) {

}
string validate_json_false( string json_false ) {

}
string validate_json_delete( string json_delete ) {

}

string validate_json_float( string json_float ) {
    string json_type = llJsonValueType(json_float, []);
    string type = llJsonGetValue(json_float, ["type"]);
    string type_type = llJsonValueType(json_float, ["type"]);

    string value = llJsonGetValue(json_float, ["value"]);
    string value_type = llJsonValueType(json_float, ["value"]);

    string valid = llJsonGetValue(json_float, ["valid"]);
    string valid_type = llJsonValueType(json_float, ["valid"]);



    llOwnerSay("-----     " + json_float + "     -----");
    llOwnerSay(" ");
    if(json_type == JSON_NUMBER) {
        llOwnerSay("json_type: JSON_NUMBER");
    } else {
        llOwnerSay("json_type" + json_type);
    }
    
    llOwnerSay("type" + type);
    llOwnerSay("type_type" + type_type);
    llOwnerSay("value" + value);
    llOwnerSay("value_type" + value_type);
    llOwnerSay("valid" + valid);
    llOwnerSay("valid_type" + valid_type);
    llOwnerSay(" ");
    
    return "";
}