string common_function_get_notecard_line( string common ) {
	return llJsonSetValue(
		common, 
		["notecard_query_id"], 
		llGetNotecardLine(
			common_function_json_get_value( 
				llJsonSetValue(
					common, 
					["get_value"], 
					"get_notecard_line_string_name" 
				)
			),
			(integer) common_function_json_get_value( 
				llJsonSetValue(
					common, 
					["get_value"], 
					"get_notecard_line_integer_line" 
				) 
			)
		)
	);
}