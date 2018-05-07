#include "common_initializers.lsl"
#include "common_functions.lsl"


string common;

//TODO Do not keep this function, either modify or remove.
string format_json(string json) {
	list lWords = llParseStringKeepNulls(json, [",\""], []);
    return llDumpList2String(lWords, ",\n\"");
}

default {
	state_entry() { state initialize; }
	state_exit() { llOwnerSay("Exiting default state"); }
}
state initialize {
	state_entry() { 
		common = common_init( common );
		state run;
	}
	state_exit()
	{
		llOwnerSay("Exiting initialize state");
	}
}

state run {
	state_entry()
	{
		llOwnerSay(format_json( common ));
	}
	dataserver(key query_id, string data)
    {
    	llJsonSetValue(common, (list) "dataserver_key_queryid", (string) query_id);
    	llJsonSetValue(common, (list) "dataserver_key_queryid_is_get_notcard_line_key_queryid",
    		(string) (
    			llJsonGetValue(common, (list) "get_notcard_line_key_queryid") == 
    			llJsonGetValue(common, (list) "dataserver_key_queryid")
    			)
    		);
        
        if ((integer) llJsonGetValue(common, (list) "dataserver_key_queryid_is_get_notcard_line_key_queryid"))
        {
        	/*
            if (data == EOF)
                say("Done reading notecard, read " + (string) notecardLine + " notecard lines.");
            else
            {
                // bump line number for reporting purposes and in preparation for reading next line
                ++notecardLine;
                say( "Line: " + (string) notecardLine + " " + data);
                notecardQueryId = llGetNotecardLine(notecardName, notecardLine);
            }
            */
        }
    }
}