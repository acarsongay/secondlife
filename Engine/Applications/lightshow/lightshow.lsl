string json;
float counter;
float speed;
integer row;
integer rows;
vector offsets;
vector repeats;
float rot;
string texture;
integer listener;
float spacing;
integer app_key;
string notecard_name;
integer notecard_line;
key notecard_query_id;
key rod;
vector rgb;

integer number_of_prims;

default
{
    state_entry() {
        state read_lightshow_notecard;
    }
}

state read_lightshow_notecard {
    state_entry() {
        notecard_name = "wavy.json";
        notecard_line = 0;//start at 0 for open {
        notecard_query_id = llGetNotecardLine(notecard_name , notecard_line); 
    }
    dataserver(key query_id, string notecard_data) {
        if (query_id == notecard_query_id) {
            if (notecard_data == EOF) {
                row = (integer) llJsonGetValue(json, (list) "row");
                rows = (integer) llJsonGetValue(json, (list) "rows");
                spacing = (integer) llJsonGetValue(json, (list) "spacing");

                state start_lightshow;
            } else {
                ++notecard_line;
                json = json + notecard_data;
                notecard_query_id = llGetNotecardLine(notecard_name, notecard_line);
            }
        }
    }
}


state start_lightshow {

    state_entry() {

        llRequestPermissions(llGetOwner(), PERMISSION_CHANGE_LINKS);
        app_key = 00110;
        listener = llListen(0x80000000 | ((integer)("0x"+(string)llGetOwner()) ^ app_key), "", "", "");
    }

    listen(integer channel, string name, key id, string message) {
        json = llDumpList2String(llParseString2List(message, [" "], []), " ");
        counter = (float) llJsonGetValue(json, (list) "counter");
        speed = (float) llJsonGetValue(json, (list) "speed");
        row = (integer) llJsonGetValue(json, (list) "row");
        rows = (integer) llJsonGetValue(json, (list) "rows");
        offsets = (vector) llJsonGetValue(json, (list) "offsets");
        repeats = (vector) llJsonGetValue(json, (list) "repeats");
        rot = (float) llJsonGetValue(json, (list) "rot");
        texture = (key) llJsonGetValue(json, (list) "texture");
        listener = (integer) llJsonGetValue(json, (list) "listener");
        spacing = (float) llJsonGetValue(json, (list) "spacing");

        string rgb_string = llJsonGetValue(json, (list) "rgb");
        if(rgb_string == "random") {
            rgb = <llFrand(1),llFrand(1),llFrand(1)>;  
        } else {
            rgb = (vector) llJsonGetValue(json, (list) "rgb");   
        }

        number_of_prims = llGetNumberOfPrims();


        if(rows > 0) {
            rod = llGetInventoryName(INVENTORY_OBJECT, 0);
            vector pos = llGetPos();
            integer index;

            if(rows > number_of_prims) {
                llBreakAllLinks();//TODO FIX
                for(index = rows; index > 1; index--) {
                    llRezObject("rod", <(pos.x + ((index * spacing) - 1)),pos.y,pos.z>, llGetVel(), llGetRot(), 0);
                }
                /*
                for(index = 2;  index < number_of_prims; index++) {
                    llSetLinkPrimitiveParamsFast(index, [PRIM_POSITION, <(pos.x + (spacing * index)),pos.y,pos.z>]);
                }
                for(index = rows;  index > number_of_prims; index--) {
                    llRezObject("rod", <(pos.x + ((index * spacing) - 1)),pos.y,pos.z>, llGetVel(), llGetRot(), 0);
                }
                */
                
                
            } else if (rows < number_of_prims) {

                for(index = number_of_prims; index > rows; index--) {
                    llBreakLink(index);
                }
            }

        }

        llSetTimerEvent( speed ); 
        llOwnerSay((string) rgb);
    }
    
    timer()
    {
        counter = counter + speed;

        
        for(row = 1;row <= rows; row++) {
            offsets = <0.0,  llSin( ((PI * counter) + ((PI * row)/rows) ) ) / 4, 0.0>;
            llSetLinkPrimitiveParamsFast(row, [PRIM_TEXTURE, ALL_SIDES,texture,repeats,offsets,rot]);
            llSetLinkPrimitiveParamsFast(row, [PRIM_COLOR, ALL_SIDES, rgb, 1.0]);
        }
        

        //offsets = <0.0,  llSin( ((PI * counter) + ((PI * row)/rows) ) ) / 4, 0.0>;
        //lSetLinkPrimitiveParamsFast(0, [PRIM_TEXTURE, ALL_SIDES,texture,repeats,offsets,rot]);
    }

    object_rez(key id)
    {
        llCreateLink(id, TRUE);
    }
}