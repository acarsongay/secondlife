//
string common;

string value( string common ) {
    return llJsonSetValue(set_value(common)
}
//gets common get_value and returns common
string get_value(string value) {
    return llJsonGetValue(common, (list) llJsonGetValue(common, (list) value));
}

//set common set_value and returns common
string set_value( string value ) {
    return llJsonSetValue(common, (list) "set_value", llJsonSetValue(common, (list) "set_value", value));
}






//
string engine( string common ) {
    return llJsonSetValue(common, "engine", set_value( common ));
}
//
string sim( string common ) {
    return llJsonSetValue(common, "sim", "value");
}
//
string avatar( string common ) {
    return llJsonSetValue(common, "avatar", "value");
}

//
string key_query_id( string common ) {

}
default
{
    state_entry()
    {
        llOwnerSay(get_value( "get_value" ));
        llOwnerSay(set_value( "get_value" ));
    }
 
    dataserver(key query_id, string data)
    {
        
    }
}