key notecardQueryId;
string notecardName = "default";
 
// script-wise, the first notecard line is line 0, the second line is line 1, etc.
integer notecardLine;
string json;

string remove_whitespace( string input ) {
    return llDumpList2String(llParseString2List(input, [" "], []), " ");
}
say(string inputString)
{
    inputString = remove_whitespace( inputString );
    integer string_length = llStringLength(inputString);
    while(string_length > 1024) {
        inputString = llDeleteSubString( inputString, 0, 1024 );
        string_length = llStringLength(inputString);
    }
    llOwnerSay(inputString);
}
 
string get_value(string value) {
    return llJsonGetValue(json, (list) value);
}
default
{
    state_entry()
    {
        // Check the notecard exists, and has been saved
        if (llGetInventoryKey(notecardName) == NULL_KEY)
        {
            llOwnerSay( "Notecard '" + notecardName + "' missing or unwritten");
            return;
        }
        notecardQueryId = llGetNotecardLine(notecardName, notecardLine);

    }
 
    dataserver(key query_id, string data)
    {
        if (query_id == notecardQueryId)
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