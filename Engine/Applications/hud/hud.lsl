integer ready; 
key notecard_query_id;
string notecard_name;
integer notecard_line;
string textures;
string json;
list required;
integer app_key;
integer listener;
integer channel;

default {

    state_entry() {
        ready = FALSE;
        notecard_query_id = NULL_KEY;
        notecard_name = "required.json";
        notecard_line = 0;
        textures = "";
        required = [];
        app_key = 0;
        listener = 0;
        channel = 0;
        json = "";

        state notecard;
    }

}

state notecard {
    state_entry() {
        notecard_query_id = llGetNotecardLine(notecard_name, notecard_line);
    }
    dataserver(key query_id, string data) {
        if (query_id == notecard_query_id) {
            if (data == EOF) {
                required = llDeleteSubList(required, 0, 0);
                if(llGetListLength(required) > 0) {
                    if(notecard_name != "required.json") {
                        json = json + ",";
                    }

                    notecard_name = (string) required[0]; 
                    notecard_line = 0;
                    notecard_query_id = llGetNotecardLine(notecard_name , notecard_line);
                } else {
                    json = "{" + llDumpList2String(llParseString2List(json, [" "], []), " ") + "}";
                    state activate_hud;
                }
            } else {
                ++notecard_line;
                if(notecard_name == "required.json") {
                    required = llJson2List(data);
                } else {
                    if((llSubStringIndex(data, "{") != 0) && (llSubStringIndex(data, "}") != 0)) {
                        json = json + data;
                    }
                }

                notecard_query_id = llGetNotecardLine(notecard_name, notecard_line);
            }
        }
    }
}

state activate_hud {
    state_entry() {
        ready = (integer) llJsonGetValue(json, (list) "ready");
        textures = llJsonGetValue(json, (list) "textures");
        app_key =  (integer) llJsonGetValue(json, (list) "app_key");

        channel = (0x80000000 | ((integer)("0x"+(string)llGetOwner()) ^ app_key));
        listener = llListen(channel, "", "", "");
    }

    touch_start(integer total_number) {
        key user;
        integer link;

        string received_data;
        string button_name;
        string received_data_type;

        user = llDetectedKey(0);
        link = llDetectedLinkNumber(0);
        //if(LINK_ROOT == link)
        //    return;
            
        button_name = llGetLinkName(link);
        if(button_name == "send") {
            llShout(channel, llJsonGetValue(json, (list) "json"));
        } else if(button_name == "reload") {
            json = "";
            state notecard;
        }
    }
}

