#include "common_listen.lsl"

string common;

default {
	
	touch_start(integer total_number)
    {
    	common = common_listen(
    		llList2Json(JSON_OBJECT, 
	        [
	        	"common_listen_integer_channel","0",
	        	"common_listen_string_name","",
	        	"common_listen_key_id",llGetOwner(),
	        	"common_listen_string_message",""
	        ])
    	);
    }

	listen( integer channel, string name, key id, string message )
    {
    	llOwnerSay(common);
    }
}