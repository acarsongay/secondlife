string common;

default
{
    dataserver(key query_id, string data)
    {
        if (query_id == notecardQueryId)
        {
            if (data == EOF)//  we have reached the EOF (end of file)
            {
                llSay(0, "No more lines in notecard, read " + (string) notecardLine + " lines.");
            }
            else
            {
            //  increment line index first, both for line number reporting, and for reading the next line
                ++notecardLine;
                llSay(0, "Line " + (string) notecardLine + ": " + data);
                notecardQueryId = llGetNotecardLine(notecardNameOrKey, notecardLine);
            }
        }
    }
}