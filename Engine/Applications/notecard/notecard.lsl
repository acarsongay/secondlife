string common;//Engine Level

string json;//Application Level
string err;//Application Level
string notecard;//Application  Level

string name; //Datatypes
integer line; //Datatypes 
key handle; //Datatypes

default {
    state_entry() {
        common = (string) "";
        json = (string) "";
        err = (string) "";
        notecard = (string) "";
        name = (string) "notecard.json";
        line = (integer) 0;
        handle = (string) llGetNotecardLine( (string) name, (integer) line);
    }
    dataserver( key query_id, string data ) {
        if( query_id == NULL_KEY ) {
            err = llJsonSetValue((string) json, (list) ["err","key_query_id"], "NULL_KEY");
            return;
        }

        if ( (key) query_id == (key) handle ) {
            if ( (string) data == EOF ) {
                llOwnerSay( (string) json);
            } else {
                notecard = (string) ( (string) notecard + (string) data );
                name = (string) llJsonGetValue( (string) json, (list) "string_name");
                line = (integer) llJsonGetValue( (string) json, (list) "integer_line");
                handle = (string) llGetNotecardLine( (string) name, (integer) line);
            }
        }
    }
}