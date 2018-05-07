/* Description: 
 *
 * USERNAME     DATE 		Comment
 * Nardwe		11/28/17	Creating initial function	
 */

string json_get_value( string json , list specifiers ) {
	return llJsonGetValue(json, specifiers);
}
string json_get_value_string_json( string json ) {
	return llJsonGetValue(json, ["string_json"]);
}
list json_get_value_list_specifiers( string json ) {
	return llJson2List(llJsonGetValue(json, ["list_specifiers"]));
}

{
	"common": {
		"json_get_value": {
			"string_json":"thought",
			"list_specifiers":["idea"],
			"return":""
		}
		
	}
}
string common_json_get_value_string_json( string common ) {
	return llJsonGetValue(common, ["json_get_value","string_json"]);
}
list common_json_get_value_list_specifiers( string common ) {

}
string common_json_get_value( string common ) {
	return llJsonSetValue(
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
	);	
}
string common_json_get_value( string common ) {
	return llJsonGetValue(
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
	);
}