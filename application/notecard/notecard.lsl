
string common; //Engine Level
list specifiers; //Engine Level
string json;//Application Level
string err;//Application Level
string bug;//User Level
key UUID; //Datatypes
string name; //Datatypes
integer line; //Datatypes 
key handle; //Datatypes

string lindon_lab_get_number_of_notecard_lines( string common ) {
    string json;
    json = llJsonGetValue(common, (list) "string_json"));
    if(json == JSON_NULL) {
        err = llJsonSetValue(err, (list) "lindon_lab_get_number_of_notecard_lines", json);
        return llJsonSetValue(common, (list) "string_err", err);
    }

    string name;
    name = llJsonGetValue(json, (list) "string_name");
    if(name == JSON_NULL) {
        err = llJsonSetValue(err, (list) "lindon_lab_get_number_of_notecard_lines", name);
        return llJsonSetValue(common, (list) "string_err", err);
    }

    json = llJsonSetValue(json, (list) "key_handle", (string) llGetNumberOfNotecardLines(name));
    return llJsonSetValue(common, (list) "string_json"), json);
}
string lindon_lab_get_notecard_line( string common ) {
    string json;
    json = (string) llJsonGetValue(common, (list) "string_json");
    if((string) json == (string) JSON_NULL) {
        err = (string) llJsonSetValue(err, (list) "lindon_lab_get_notecard_line", json);
        return (string) llJsonSetValue(common, (list) "string_err", err);
    }

    string name;
    name = (string) llJsonGetValue(json, (list) "string_name");
    if((string) name == (string) JSON_NULL) {
        err = (string) llJsonSetValue(err, (list) "lindon_lab_get_notecard_line", name);
        return (string) llJsonSetValue(common, (list) "string_err", err);
    }

    integer line;
    line = (integer) llJsonGetValue(json, (list) "integer_line");
    name = (string) llJsonGetValue(json, (list) "string_name");
    line = (integer) llJsonGetValue(json, (list) "integer_line");

    json = (string) llJsonSetValue(json, (list) "key_handle", (string) llGetNotecardLine(name,line));

    return (string) llJsonSetValue(common, (list) "string_json", json);
}
string lindon_lab_get_inventory_key( string common ) {
    string json; //null our json
    json = llJsonGetValue(common, (list) "string_json"); //set out json from global
    if(json == JSON_NULL) {
        err = llJsonSetValue(err, (list) "lindon_lab_get_inventory_key", json);
        return llJsonSetValue(common, (list) "string_err", err);
    }

    string name;
    name = llJsonGetValue(json, (list) "string_name");
    if(name == JSON_NULL) {
        err = llJsonSetValue(err, (list) "lindon_lab_get_inventory_key", name);
        return llJsonSetValue(common, (list) "string_err", err);
    }
    
    json = llJsonSetValue(json, (list) "key_UUID", (string) llGetInventoryKey(name));
    
    return llJsonSetValue(common, (list) "string_json", json);
}

//TEMP
string remove_whitespace( string common ) {
    return llDumpList2String(llParseString2List( common, (list) " ", (list)), (list) " ");
}
string remove_whitespace_alt( string common ) {
    integer index;
    while((integer) ~index = llSubStringIndex((string) common, (string) " ")) {
        common = (string) llDeleteSubString( (string) common,(integer) index, (integer) index);
    }
    return (string) common;
}
string remove_whitespace_alt_two( string json ) {
    return (string)llParseString2List(json, [" "], []);
}

default {
    state_entry() {
        //EngineLevel
        common = (string) JSON_NULL;
        common = (string) llJsonSetValue( (string) common, (list) "string_json", (string) JSON_NULL );
        common = (string) llJsonSetValue( (string) common, (list) "string_err", (string) JSON_NULL );
        common = (string) llJsonSetValue( (string) common, (list) "string_name", (string) JSON_NULL );
        common = (string) llJsonSetValue( (string) common, (list) "integer_line", (string) JSON_NULL );
        common = (string) llJsonSetValue( (string) common, (list) "key_handle", (string) JSON_NULL);
        common = (string) llJsonSetValue( (string) common, (list) "key_UUID", (string) JSON_NULL);
        common = (string) llJsonSetValue( (string) common, (list) "string_json", common);
        common = (string) lindon_lab_get_inventory_key( common );
        common = (string) lindon_lab_get_notecard_line( common ); 
        //EngineLevel


        //llOwnerSay(common);
        //llOwnerSay(json);
        //llOwnerSay(err);

        //EngineLevel
        common = (string) JSON_STRING;
        common = (string) llJsonSetValue( (string) common, (list) "string_json", (string) JSON_STRING );
        common = (string) llJsonSetValue( (string) common, (list) "string_err", (string) JSON_STRING );
        common = (string) llJsonSetValue( (string) common, (list) "string_name", (string) JSON_STRING );
        common = (string) llJsonSetValue( (string) common, (list) "integer_line", (string) JSON_NUMBER );
        common = (string) llJsonSetValue( (string) common, (list) "key_handle", (string) NULL_KEY);
        common = (string) llJsonSetValue( (string) common, (list) "key_UUID", (string) NULL_KEY);
        common = (string) llJsonSetValue( (string) common, (list) "string_json", (string) common);
        common = (string) lindon_lab_get_inventory_key( common );
        common = (string) lindon_lab_get_notecard_line( common ); 
        //EngineLevel

        llOwnerSay(common);
        //llOwnerSay(json);
        //llOwnerSay(err);
        /*
        //Application Level
        json = JSON_NULL;
        json = (string) llJsonGetValue( (string) common, (list) "string_json"); //copy global
        json = (string) llJsonSetValue( (string) json, (list) "string_json", (string) JSON_STRING );
        json = (string) llJsonSetValue( (string) json, (list) "string_err", (string) JSON_STRING );
        json = (string) llJsonSetValue( (string) json, (list) "string_name", "notecard.json");
        json = (string) llJsonSetValue( (string) json, (list) "integer_line", (string) JSON_NUMBER);
        json = (string) llJsonSetValue( (string) json, (list) "key_handle", (string) NULL_KEY);
        json = (string) llJsonSetValue( (string) json, (list) "key_UUID", (string) NULL_KEY);

        UUID = (key) llJsonGetValue( (string) json, (list) "key_UUID");
        handle = (key) llJsonGetValue( (string) json, (list) "key_handle");
        name = (string) llJsonGetValue( (string) json, (list) "string_name");
        line = (integer) llJsonGetValue( (string) json, (list) "integer_line");
         //End Application Level 

        bug="first bug";
        llOwnerSay(bug + common);
        llOwnerSay(bug + json);
        llOwnerSay(bug + err);

        //EngineLevel
        common = llJsonSetValue( (string) common, (list) "string_json", json);
        common = lindon_lab_get_inventory_key( common );
        common = lindon_lab_get_notecard_line( common ); 
        //EngineLevel

        bug="second bug";
        llOwnerSay(bug + common);
        llOwnerSay(bug + json);
        llOwnerSay(bug + err);

        

        bug=" bug";
        llOwnerSay(bug + common);
        llOwnerSay(bug + json);
        llOwnerSay(bug + err);
        */

    }
    dataserver( key query_id, string data ) {
        if ( (key) query_id == (key) handle ) {
            if ((string) data == EOF) {
                llOwnerSay( (string) common);

                llOwnerSay( (string) json);
            } else {
                ++line;
                json = llJsonSetValue( (string) json, (list) "dataserver", (string) llJsonGetValue( (string) json, (list) "dataserver") + (string) data );
                handle = llGetNotecardLine(name , line); 
            }
        }
    }
}