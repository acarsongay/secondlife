#include "integer_value.lsl"

//common abs functions
string common_abs_integer_value( string common ) {
	return llJsonSetValue(common, ["abs_integer_value"], (string) llJsonGetValue(common, (list) "integer_value"));
}
string common_abs_return( string common ) {
	return llJsonSetValue(common, ["abs_return"], (string) llAbs(llJsonGetValue(common, (list) "abs_integer_value")));
}
string common_abs( string common ) {
	return common_abs_return(common_abs_integer_value(common));
}
string abs( integer value ) {
	return common_abs(integer_value(value));
}

//Might Remove
string common_set_abs_integer_value( string common ) {
	return llJsonSetValue(common, ["abs","integer_value"], llJsonGetValue(common, ["set"]))
}

//Should clear in common_clear but may explicit clear with these functions
string common_clear_abs_integer_value( string common ) {
	return llJsonSetValue(common, ["abs","integer_value"], JSON_DELETE);
}
string common_clear_abs_integer_value( string common ) {
	return llJsonSetValue(common, ["abs","return"], JSON_DELETE);
}
string common_clear_abs( string common ) {
	return llJsonSetValue(common, ["abs"], JSON_DELETE);
}