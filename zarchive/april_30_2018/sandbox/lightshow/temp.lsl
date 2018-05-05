string json;

key notecardQueryId; set("notecard_query_id", JSON_NULL);
string notecardName = "default";
 
// script-wise, the first notecard line is line 0, the second line is line 1, etc.
integer notecardLine;



string flatten( string json ) {
    return llJsonSetValue(
        llDumpList2String(
            llParseString2List(
                json, 
                [" "],
                []
            ),
            " "
        ),
        (list) "length",
        llStringLength(
            llJsonGetValue(
                json, 
                (list) "json"
            )
        )
    );
}
string remove_whitespace( string json) {
    return llDumpList2String(llParseString2List(json, [" "], []), " ");
}
string get( string json, string value) {
    return llJsonGetValue(json, (list) value);
}
string get_length( string json ) {
    return get(json, "length");
}
string owner_say_notecard( string json ) {
    while( get_length(flatten(json)) > 1024 ){
        llOwnerSay(
            llJsonGetValue(
                llStringLength(
                    llJsonGetValue(
                        llDeleteSubString( json, 0, 1024 ), 
                        (list) "json"
                    )
                ),
                "json"
            )
        )
    }

    return json;
}
 
string get_value(string value) {
    return llJsonGetValue(json, (list) value);
}




string version  = "Sparky's Light Show ver 1.1";
string item2Rez;


integer rows;
string animation;
 
 
float gap;
float spacing;
float counter;


integer numberOfLinkedSparky;
integer faceOfLinkedSparky;
string textureOfLinkedSparky;
vector repeatsOfLinkedSparky;
vector offsetsOfLinkedSparky;
float rotationOfLinkedSparky;


float offsetNumberX;
float offsetNumberY;
float offsetNumberZ;
float repeatsNumberX;
float repeatsNumberY;
float repeatsNumberZ;

/**/
integer appKey = 00110;
integer myChan;
integer myListener;
Key2Chan(key ID) 
{
    myChan = 0x80000000 | ((integer)("0x"+(string)ID) ^ appKey); 

    myListener = llListen(myChan, "", "", "");
}


loadDefault() {
    textureOfLinkedSparky = "f139203a-90a6-317e-a956-8272f67bd498";
    
    offsetNumberX = 0.0;
    offsetNumberY = 0.5;   
    offsetNumberZ = 0.0;
    offsetsOfLinkedSparky = <offsetNumberX, offsetNumberY, offsetNumberZ>;
    repeatsNumberX = 0.0;
    repeatsNumberY = 0.5;
    repeatsNumberZ = 0.0;
    repeatsOfLinkedSparky = <repeatsNumberX, repeatsNumberY, repeatsNumberZ>; 
    rotationOfLinkedSparky = 0.0;    
}

runLightShow(integer index) {
   llSetLinkPrimitiveParamsFast(index, 
        [
            PRIM_TEXTURE, ALL_SIDES,
            textureOfLinkedSparky,repeatsOfLinkedSparky,
            offsetsOfLinkedSparky,rotationOfLinkedSparky
        ]
    ); 
}

spawnInRows(integer rows, float spacing) {
    vector vel = llGetVel();
    vector pos = llGetPos();
    rotation rot = llGetRot();
    if(rows > 1) {
        integer index;
        for(index = rows; index > 0; index--) {
            llRezObject(item2Rez, <pos.x - (index * spacing),pos.y,pos.z>, vel, rot, 0);
        }
    }
}

string sin( string value ) {
    return llJsonSetValue(json, (list) "sin", (string) llSin( value ) );    
}
string get( string value ) {
    return llJsonGetValue(json, (list) value);
}
setupLightShow(integer index, integer totalLinkedSparkies) {
    ( (vector) get("offset_vector") )ll
     llJsonSetValue(json, (list) "offset_vector", "<0.0," + sin( ( ( PI * get( "counter" ) + ( ( PI * get( "index" ) / get( "total_linked_sparky ") ) ) ) / 4
    if(animation = "wave") {
        //offsetNumberX = 0.0;
        offsetNumberY = llSin( ((PI * counter) + ((PI * index)/totalLinkedSparkies) ) ) / 4;   
        offsetNumberZ = 0.0;
        offsetsOfLinkedSparky = <offsetNumberX, offsetNumberY, offsetNumberZ>;
        
        
        repeatsNumberX = 0.0;
        repeatsNumberY = 0.5;
        repeatsNumberZ = 0.0;
        repeatsOfLinkedSparky = <repeatsNumberX, repeatsNumberY, repeatsNumberZ>; 
        
        rotationOfLinkedSparky = 0.0;
    }    
}

lightShow(integer totalLinkedPrims) {
    integer index;
    if(totalLinkedPrims > 1) {
        for(index = 0; index <= totalLinkedPrims; index++) {
            setupLightShow(index,totalLinkedPrims);
            runLightShow(index);
        }
    }
}
 
/**/   
increaseCounter(float value) {
    counter = counter + value;    
}   
 
default {
    
    on_rez(integer starP) {
         // Check the notecard exists, and has been saved
        if (llGetInventoryKey(notecardName) == NULL_KEY)
        {
            llOwnerSay( "Notecard '" + notecardName + "' missing or unwritten");
            return;
        }
        notecardQueryId = llGetNotecardLine(notecardName, notecardLine);

        llResetScript();
    }
    
    touch_start(integer numberOfTouches) {
        item2Rez = llGetInventoryName(INVENTORY_OBJECT, 0);
        if(item2Rez == "") {
            llOwnerSay("No item in inventory to rez. Please place an item to rez into inventory.");
            return;
        }
        else
        {
            Key2Chan(llGetOwner());
            loadDefault();
            llSetTimerEvent(gap);
        } 
    }
    
    state_entry() {
        
        rows = 2; 
        gap = 0.1;
        counter = 0.0;
        spacing = 1.0;
        animation = "wave";
    }

    
    timer() {
        increaseCounter(0.1);
        lightShow(3);
    }
    
    object_rez(key id)
    {
        llCreateLink(id, TRUE);
    }
    
    dataserver(key query_id, string data)
    {
        if (query_id == notecardQueryId)
        {
            if (data == EOF) {
                if(notecardName == "engine") {

                    say(get_value("abs"));

                    notecardName = "sim";
                    notecardLine = 0;
                    notecardQueryId = llGetNotecardLine(notecardName, notecardLine);
                }
            }
            else
            {
                ++notecardLine;
                json = json + data;
                notecardQueryId = llGetNotecardLine(notecardName, notecardLine);
            }
        }
    }
    
}



