string lindon_lab_get_inventory_key( string common ) {
    string json;
    json = llJsonGetValue(common, (list) "json");
    if(json == JSON_NULL) {
        err = llJsonSetValue(err, (list) "lindon_lab_get_notecard_line", (string) json);
        return llJsonSetValue(common, (list) "err", (string) err);
    }

    string name;
    name = llJsonGetValue(json, (list) "string_name");
    if(name == JSON_NULL) {
        err = llJsonSetValue(err, (list) "lindon_lab_get_number_of_notecard_lines", (string) name);
        return llJsonSetValue(common, (list) "err", (string) err);
    }
    
    json = llJsonSetValue(json, (list) "key_UUID", (string) llGetInventoryKey( (string) name));
    
    return llJsonSetValue(common, (list) "json", (string) json);
}