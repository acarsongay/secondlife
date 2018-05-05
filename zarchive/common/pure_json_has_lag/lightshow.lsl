string global_json;

integer lindon_lab_abs( integer val ) {
    return llAbs(val);    
}
integer abs( integer val ) {
    return ( ( ( val >> 31 ) ^ val ) - ( val >> 31 )); 
}
integer abs_alt( integer val ) {
    return ( val * ( ( ( val > 0 ) << 1 ) - 1 ) );
}
integer abs_alt_two( integer val ) {
    return ( ( val * ( val >> 31) ) | ( ( ~val + 1 ) * ( ( ~val + 1 ) >> 31 ) ) );
}

string common_timer( string json ) {
    return llJsonSetValue(global_global_json (list)"json", json);   
}
string common_state_entry( string json ) {
    global_json = llJsonSetValue(global_global_json (list)"json", json);
    //llOwnerSay(global_json);
    
    return global_json;    
}
integer min_int(a, b) {
  return a - ((a - b) & ((b - a) >> 31));
  // return b ^ ((a ^ b) & -(a < b));
}
string get( string value ) {
    return llJsonGetValue(global_json, (list) value);
}
float get_float( string value ) {
    return (float) get(value);
}
rotation get_rotation( string value ) {
    return (rotation) get(value);
}
vector get_vector( string value ) {
    return (vector) get(value);
}
integer get_integer( string value ) {
    return (integer) get(value);
}

set( string KEY, string value ) {
    global_json = llJsonSetValue(global_json, (list) KEY, value);
}
default
{
    state_entry()
    {
        //timer
        set("counter","0.0");
        set("gap","0.1");

        //lightshow
        set("rod","1");
        set("rod_count","3");
        set("offsets", 
            (string) 
            <
                0.0,
                llSin( ((PI * (get_float("counter"))) + ((PI * (get_integer("rod")))/(get_integer("rod_count"))) ) ) / 4, 
                0.0
            >);
        set("repeats", "<0.0, 0.5, 0.0>");
        set("rotation", "0.0");
        set("texture", "f139203a-90a6-317e-a956-8272f67bd498");

        do {
            set("counter", (string) (get_float("counter") + get_float("gap")));
        for(; get_integer("rod") > 0; set("rod", (string) (get_integer("rod") - 1))) {
            set("offsets",
                (string) 
                <
                    0.0,
                    llSin( ((PI * (get_float("counter"))) + ((PI * (get_integer("rod")))/(get_integer("rod_count"))) ) ) / 4,
                    0.0
                >
                );
            llSetLinkPrimitiveParamsFast(get_integer("rod"), [PRIM_TEXTURE, ALL_SIDES,get("texture"),get_vector("repeats"),get_vector("offsets"),get_float("rotation")]);
        }

        set("rod", get("rod_count"));   
            }while(1>2);
        //llSetTimerEvent( get_float("gap") );
    }

    touch_start(integer total_number)
    {
    }
    
    dataserver(key query_id, string data) {
           
    }
    
    
    object_rez(key id)
    {
        llCreateLink(id, TRUE);
    }
    
    timer()
    {
        set("counter", (string) (get_float("counter") + get_float("gap")));
        for(; get_integer("rod") > 0; set("rod", (string) (get_integer("rod") - 1))) {
            set("offsets",
                (string) 
                <
                    0.0,
                    llSin( ((PI * (get_float("counter"))) + ((PI * (get_integer("rod")))/(get_integer("rod_count"))) ) ) / 4,
                    0.0
                >
                );
            llSetLinkPrimitiveParamsFast(get_integer("rod"), [PRIM_TEXTURE, ALL_SIDES,get("texture"),get_vector("repeats"),get_vector("offsets"),get_float("rotation")]);
        }

        set("rod", get("rod_count"));       
    }
}
