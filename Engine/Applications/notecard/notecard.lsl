
string json;//Application Level
string err;//Application Level
string notecard;//Application  Level

key UUID; //Datatypes
string name; //Datatypes
integer line; //Datatypes 
key handle; //Datatypes
default {
    state_entry() {
        json = "";
        err = "";
        notecard = "";
        name = "notecard.json";
        line = 0;
        handle = (string) llGetNotecardLine( (string) name, (integer) line);
    }
    dataserver( key query_id, string data ) {
        if ( (key) query_id == (key) handle ) {
            if ( (string) data == EOF ) {
                llOwnerSay( (string) json);
            } else {
                json = llJsonSetValue( 
                    ( (string) json ), 
                    ( (list) "integer_line"), 
                    ( (string) ( (integer) line + (integer) 1) )
                );
                json = llJsonSetValue( 
                    ( (string) json ), 
                    ( (list) "string_name"), 
                    ( (string) ( "notecard.json" ) )
                );
                json = llJsonSetValue
                    ( 
                        ( (string) json ),
                        ( (list) "string_notecard" ),
                        ( (string) notecard + (string) data )
                    );
                
                err = "";

                notecard = (string) ( (string) notecard + (string) data );
                name = (string) llJsonGetValue( (string) json, (list) "string_name");
                line = (integer) llJsonGetValue( (string) json, (list) "integer_line");
                handle = (string) llGetNotecardLine( (string) name, (integer) line);
            }
        }
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

    }
}