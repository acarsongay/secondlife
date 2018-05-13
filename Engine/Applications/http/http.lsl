string json;

key http_request_id;
 
default
{
    state_entry()
    {
    	string url;
    	list parameters;
    	string body;

    	url = (string) "https://raw.githubusercontent.com/acarsongay/secondlife/master/Engine/Notecards/engine_rule.json";
    	parameters = (list) [];
    	body = (string) "";
    	http_request_id = (key) NULL_KEY;

    	json = llJsonSetValue((string) json, (list) "url", (string) url);
    	json = llJsonSetValue((string) json, (list) "parameters", (string) parameters);
    	json = llJsonSetValue((string) json, (list) "body", (string) "");
    	json = llJsonSetValue((string) json, (list) "http_request_id", llHTTPRequest(url, parameters, body));

    	url = (string) llJsonGetValue((string) json, (list) "url");
    	parameters = (list) llJsonGetValue((string) json, (list) "parameters");
    	body = (string) llJsonGetValue((string) json, (list) "body");
    	http_request_id = (key) llJsonGetValue((string) json, (list) "http_request_id");
    }
 
    http_response(key request_id, integer status, list metadata, string body)
    {
    	json = llJsonSetValue((string) json, (list) "request_id", (string) request_id);
    	json = llJsonSetValue((string) json, (list) "status", (string) status);
    	json = llJsonSetValue((string) json, (list) "metadata", (string) metadata);
    	json = llJsonSetValue((string) json, (list) "body", (string) body);

    	if (request_id == NULL_KEY || http_request_id == NULL_KEY) return;

        if (request_id != http_request_id) return;
 
 		llOwnerSay((string) llJsonGetValue((string) body, (list) "test"));
    }
}