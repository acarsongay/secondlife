/*Respect our culture*/

#include "common_json_get_value.lsl"
#include "common_json_set_value.lsl"
#include "common_owner_say.lsl"

default
{
    state_entry()
    {

    }

    touch_start(integer total_number)
    {
        string common = llList2Json(JSON_OBJECT, 
        [
            "json_get_value", 
            llList2Json(JSON_OBJECT, 
                [
                    "string_json",
                    "thought",

                    "list_specifiers",
                    "idea",
                    
                    "return",""
                ]
            ),

            "thought",
            llList2Json(JSON_OBJECT, 
                [
                    "idea",
                    "An idea within a thought"
                ]
            )


            "common_json_get_value_string_json","thought",
            "common_json_get_value_list_specifiers","idea",
            "common_json_set_value_string_json","thought",
            "common_json_set_value_list_specifiers", "idea",
            "common_json_set_value_string_value", "new_idea",
            "common_owner_say","thought",

            "new_idea","empty",
            "thought", llList2Json(JSON_OBJECT, [
                "idea","An idea within a thought"])

        ]);

        
        llOwnerSay(
            llJsonSetValue(
                common,
                ["common_json_get_value"],
                llJsonGetValue(
                    llJsonGetValue(
                        common, 
                        [
                            llJsonGetValue(
                                common, 
                                [
                                    "common_json_get_value_string_json"
                                ]
                            )
                        ]
                    ), 
                    [
                        llJsonGetValue(
                            common, 
                            [
                                "common_json_get_value_list_specifiers"
                            ]
                        )
                    ]
                )
            )
        );
        
    }
    
    timer() {
         
    }
}
