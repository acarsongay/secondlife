
string engine = "";
string sim = "";
string avatar = "";

string common;

string get_value(string value) {
    return llJsonGetValue(common, (list) value);
}
string set_value( string value ) {
    return llJsonSetValue(common, (list) "set_value", value);
}

string json_set_value( string common ) {
    return llJsonSetValue(common, (list) "json_set_value", "set_value");
}
string notecard_name( string common ) {
    return llJsonSetValue(common, (list) "notecard_name", llJsonGetValue(common, (list) "json_set_value"));
}
string notecard_line( string common ) {
    return llJsonSetValue(common, (list) "notecard_line", llJsonGetValue(common, (list) "json_set_value"));
}
string notecard_queryid( string common ) {
    return llJsonSetValue(common, 
        (list) "notecard_queryid", 
        llGetNotecardLine(notecardName, notecardLine)
    );
}
string read_notecard() {
    return llJsonSetValue(common, 
        (list) "notecard_queryid", 
        llGetNotecardLine(notecard_name(), notecard_line())
    );
}
string merge_overrides() {
    return llList2Json("JSON_OBJECT",
        llListInsertList(
            llListInsertList(
                llListInsertList(
                    (list) common, 
                    llJson2List(engine),
                    0
                ),
                llJson2List(sim),
                llGetListLength((list) common)
            ),
            llJson2List(avatar),
            llGetListLength((list) common)
        )
    );
}
default
{
    state_entry()
    {
        llOwnerSay(read_notecard());
        llOwnerSay(merge_overrides());
    }
 
    dataserver(key query_id, string data)
    {
        get_value("query_id")
        if (key_query_id() == notecard_query_id())
        {
            if (data == EOF) {
                if(notecardName == "default") {

                    say(get_value("abs"));

                    notecardName = "sim";
                    notecardLine = 0;
                    notecardQueryId = llGetNotecardLine(notecardName, notecardLine);
                } else {

                    say(get_value("abs"));
                }
            }
            else
            {
                // bump line number for reporting purposes and in preparation for reading next line
                ++notecardLine;
                json = json + data;
                if(notecardLine != 0 && notcardLine != )
                json = llJsonSetValue(json, [0, JSON_APPEND], data)
                notecardQueryId = llGetNotecardLine(notecardName, notecardLine);
            }
        }
    }
}