#include "common_functions.lsl"
#include "common_initializers.lsl"


string common;

default {
	state_entry()
	{
		common = common_init( common );
	}
	listen( integer channel, string name, key id, string message )
    {

    }
    dataserver(key query_id, string data)
    {
    	common = llJsonSetValue(common, ["string_data"], data);
    }
    changed( integer mask )
    {

    }
	state_exit()
	{
		//common_delete
	}
}