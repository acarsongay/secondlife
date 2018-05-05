
string common; //Engine Level
string json;//Application Level
string err;//Application Level
key UUID; //Datatypes
string name; //Datatypes
integer line; //Datatypes 
key handle; //Datatypes

string lindon_lab_get_number_of_notecard_lines( string common ) {
    string json;
    json = llJsonGetValue(common, (list) "json");
    if(json == JSON_NULL) {
        err = llJsonSetValue(err, (list) "lindon_lab_get_number_of_notecard_lines", json);
        return llJsonSetValue(common, (list) "err", err);
    }

    string name;
    name = llJsonGetValue(json, (list) "string_name");
    if(name == JSON_NULL) {
        err = llJsonSetValue(err, (list) "lindon_lab_get_number_of_notecard_lines", name);
        return llJsonSetValue(common, (list) "err", err);
    }

    json = llJsonSetValue(json, (list) "key_handle", (string) llGetNumberOfNotecardLines(name));
    return llJsonSetValue(common, (list) "json", json);
}
string lindon_lab_get_notecard_line( string common ) {
    string json;
    json = llJsonGetValue(common, (list) "json");
    if(json == JSON_NULL) {
        err = llJsonSetValue(err, (list) "lindon_lab_get_notecard_line", json);
        return llJsonSetValue(common, (list) "err", err);
    }

    string name;
    name = llJsonGetValue(json, (list) "string_name");
    if(name == JSON_NULL) {
        err = llJsonSetValue(err, (list) "lindon_lab_get_number_of_notecard_lines", name);
        return llJsonSetValue(common, (list) "err", err);
    }

    integer line;
    line = llJsonGetValue(json, (list) "integer_line");
    if(line == JSON_NULL) {
        err = llJsonSetValue(err, (list) "lindon_lab_get_number_of_notecard_lines", name);
        return llJsonSetValue(common, (list) "err", err);
    }


    name = llJsonGetValue(json, (list) "string_name");
    line = llJsonGetValue(json, (list) "integer_line");

    json = llJsonSetValue(json, (list) "key_handle", (string) llGetNotecardLine(name,line));

    return llJsonSetValue(common, (list) "json", json);
}
string lindon_lab_get_inventory_key( string common ) {
    string json;
    json = llJsonGetValue(common, (list) "json");
    if(json == JSON_NULL) {
        err = llJsonSetValue(err, (list) "lindon_lab_get_notecard_line", json);
        return llJsonSetValue(common, (list) "err", err);
    }

    string name;
    name = llJsonGetValue(json, (list) "string_name");
    if(name == JSON_NULL) {
        err = llJsonSetValue(err, (list) "lindon_lab_get_number_of_notecard_lines", name);
        return llJsonSetValue(common, (list) "err", err);
    }
    
    json = llJsonSetValue(json, (list) "key_UUID", (string) llGetInventoryKey(name));
    
    return llJsonSetValue(common, (list) "json", json);
}

default {
    state_entry() {
        common = "{
                    \"json\":\"JSON_NULL\",
                    \"err\":\"ERR_GENERIC\"
                }";
        json = llJsonGetValue(common, (list) "json");

        name = "notecard.json";
        UUID = llGetInventoryKey(name);

        line = 0;
        handle = llGetNotecardLine(name , line); 
    }
    dataserver(key query_id, string data) {
        if (query_id == handle) {
            if (data == EOF) {

            } else {
                ++line;

                llJsonGetValue(json, (list "dataserver");
                llJsonSetValue(common, (list) "dataserver", json )
                json = json + notecard_data;
                handle = llGetNotecardLine(name , line); 
            }
        }
    }
}