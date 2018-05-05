#include "common_init.lsl"

string common;

default {
	state_entry()
	{
		llOwnerSay(common_init( common ));
	}
	listen( integer channel, string name, key id, string message )
    {

    }
    changed( integer mask )
    {

    }
	state_exit()
	{
		common_delete( common );
	}
}