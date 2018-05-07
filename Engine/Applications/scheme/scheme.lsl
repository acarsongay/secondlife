string prog = "";
 
list operators = ["+", "-", "*", "/", "=", "!=", ">", ">=", "<", "<="];
 
list defines;
 
list array;
 
adddefine(integer pointer, string what) {
    //llOwnerSay("DEFINING " + what + " TO BE " + (string)pointer);
    if (llListFindList(defines, [what]) != -1) {
        defines = llListReplaceList(defines, [pointer], 
                llListFindList(defines, [what])+1, llListFindList(defines, [what])+1);
    } else {
        defines += [what, pointer];
    }
}
 
add(string data, integer next) {
    array += [data, next];
}
 
addpointer(integer pointer, integer next) {
    array += [pointer, next];
}
 
editdata(string data, integer addr) {
    array = llListReplaceList(array, [data], addr*2, addr*2);
}
 
editpointer(integer point, integer addr) {
    array = llListReplaceList(array, [point], addr*2, addr*2);
}
 
string get(integer pointer) {
    return llList2String(array, 2*pointer);
}
 
string getpointer(integer pointer) {
    return llList2String(array, 2*pointer+1);
}
 
setpointer(integer pointer, integer addr) {
    array = llListReplaceList(array, [pointer], addr*2+1, addr*2+1);
}
 
integer size() {
    return llGetListLength(array)/2;
}
 
integer isOperator(string data) {
    return llSubStringIndex(data, "(");
}
 
integer prog2list(string prog) {
    //llOwnerSay(prog);
 
    if (isOperator(prog)) {
        add(prog, 0);
        return size()-1;
    }
 
    list l = llParseString2List(prog, [" ", "\n"], ["(", ")"]);
 
    integer parend = 1;
    list argStart;
    list argEnd;
    list arg;
 
    integer i = 1;
    while (i < llGetListLength(l)) {
        if (llList2String(l, i) == "(") {
            if (parend == 1)
                argStart += i;
            parend++;
        } else if (llList2String(l, i) == ")") {
            parend--;
            if (parend == 1)
                argEnd += i;
        } else {
            if (parend == 1) {
                argStart += i;
                argEnd += i;
            }
        }
        i++;
    }
    if (parend != 0) {
        //llOwnerSay("Error: Mismatched parend.");
    }
 
    integer argLocation = size();
 
    i = 0;
    while (i < llGetListLength(argStart)) {
        addpointer(0, size()+1);
        i++;
    }
    addpointer(0, 0);
 
    i = 0;
    while (i < llGetListLength(argStart)) {
        editpointer(prog2list(llDumpList2String(
                llList2List(l, llList2Integer(argStart, i), llList2Integer(argEnd, i)), " ")), argLocation + i);
        //llOwnerSay("Pointer p" + llList2String(array, 2*(argLocation+i)) + " which is " +
            //llDumpList2String(llList2List(l, llList2Integer(argStart, i), llList2Integer(argEnd, i)), " "));
        i++;
    }
    //setpointer(0, argLocation + i - 1);
    //llOwnerSay("RETURNING with " + (string)argLocation);
    return argLocation;
}
 
string car(string s) {
    list l = llParseString2List(s, [" "], ["(", ")"]);
    if (llList2String(l, 1) == "quote")
        l = llList2List(l, 3, -3);
    else
        l = llList2List(l, 1, -2);
    //llOwnerSay(llList2CSV(l));
 
    if (llList2String(l, 0) == "(") {
        integer i = 0;
        while (i < llGetListLength(l)) {
            if (llList2String(l, i) == ")") {
                return llDumpList2String(llList2List(l, 0, i), " ");
            }
            i++;
        }
        return "()";
    } else {
        return llList2String(l, 0);
    }
}
 
string cdr(string s) {
    list l = llParseString2List(s, [" "], ["(", ")"]);
    if (llList2String(l, 1) == "quote")
        l = llList2List(l, 3, -3);
    else
        l = llList2List(l, 1, -2);
 
    //llOwnerSay("Now it is " + llList2CSV(l));
    if (llList2String(l, 0) == "(") {
        integer i = 0;
        integer lv;
        while (i < llGetListLength(l)) {
            if (llList2String(l, i) == "(")
                lv++;
            if (llList2String(l, i) == ")") {
                lv--;
                if (lv == 0) {
                    //llOwnerSay("Here: " + (string)(llGetListLength(l)-i) + " "+  (string)(i+1) + " " +(string)llList2List(l, i+1, -1));
                    if (llGetListLength(l)-i == 1)
                        return "()";
                    //llOwnerSay("Returning " + llDumpList2String(llList2List(l, i+1, -1), " "));
                    return "( " + llDumpList2String(llList2List(l, i+1, -1), " ") + " )";
                }
            }
            i++;
        }
        return "()";
    } else {
        if (llGetListLength(l) == 1)
            return "()";
        return "( " + llDumpList2String(llList2List(l, 1, -1), " ") + " )";
    }
}
 
string tostring(list l) {
    if (1 == 1)
        return "";
    string ret;
    integer i = 0;
    while (i < llGetListLength(l)) {
        if (llGetListEntryType(l, i) == TYPE_STRING)
            ret += (string)(i/2) + " (" + llList2String(l, i) + ", " + llList2String(l, i+1) + "); ";
        else
            ret += (string)(i/2) + " (p" + llList2String(l, i) + ", " + llList2String(l, i+1) + "); ";
        i += 2;
    }
    return ret;
}
 
printOut() {
    //llOwnerSay((string)llGetListLength(array));
    integer k = 0;
    while (k <= llGetListLength(array)) {
        string ret;
        integer i = k;
        while (i < 50+k && i < llGetListLength(array)) {
            if (llGetListEntryType(array, i) == TYPE_STRING)
                ret += (string)(i/2) + " (" + llList2String(array, i) + ", " + llList2String(array, i+1) + "); ";
            else
                ret += (string)(i/2) + " (p" + llList2String(array, i) + ", " + llList2String(array, i+1) + "); ";
            i += 2;
        }
        //llOwnerSay(ret);
        k += 50;
    }
}
 
string format(integer i) {
    //llOwnerSay("Format " + (string)i);
    string ret = "";
    if (llGetListEntryType(array, 2*i) != TYPE_INTEGER) {
        return get(i);
    } else {
        ret += "( ";
        while (i) {
            integer p = (integer)getpointer(i);
            ret += format(llList2Integer(array, 2*i)) + " ";
            i = p;
        }
        ret += ")";
        //llOwnerSay(ret);
        //llOwnerSay("Finding " + (string)llSubStringIndex(ret, " ( )"));
        while (llSubStringIndex(ret, " ( )") != -1)
            ret = llDeleteSubString(ret, llSubStringIndex(ret, " ( )"), llSubStringIndex(ret, " ( )")+3);
        return ret;
    }
}
 
 
list evaluate(integer i) {
    //llOwnerSay("Evaluate " + (string)i);
    if (llGetListEntryType(array, 2*i) == TYPE_INTEGER && get(i) == "0" && getpointer(i) == "0")
        return [0];
    if (0 == (integer)getpointer(i) && llGetListEntryType(array, 2*i) == TYPE_STRING) {
        string gt = get(i);
        if (llListFindList(defines, [gt]) != -1) {
            //llOwnerSay(llList2CSV(defines));
            integer loc = (integer)llList2String(defines, llListFindList(defines, [gt])+1);
            //llOwnerSay(gt + " is " + (string)loc);
            if (get((integer)get(loc)) == "quote")
                return [loc];
            else
                return evaluate(loc);
        }
        return [gt];
    }
 
    if (get((integer)get(i)) == "define") {
        adddefine((integer)get(i+2), get((integer)get(i+1)));
        //llOwnerSay(llList2CSV(defines));
        return [get((integer)get(i+1))];
    }
    if (get((integer)get(i)) == "lambda") {
        return [i];
    }
    if (get((integer)get(i)) == "if") {
        if ((integer)llList2String(evaluate((integer)get(i+1)), 0)) {
            return evaluate((integer)get(i+2));
        } else {
            return evaluate((integer)get(i+3));
        }
    }
    if (get((integer)get(i)) == "quote") {
        return [i];
    }
 
    integer cont = 1;
    list things;
    while (cont) {
        integer pointerTo = (integer)get(i);
        integer pointer = (integer)getpointer(i);
        if (pointerTo != 0) {
            things += evaluate(pointerTo);
            i = pointer;
        } else {
            cont = 0;
        }
    }
    //llOwnerSay(llList2CSV(things));
 
    string op = llList2String(things, 0);
    //llOwnerSay("Op is " + op);
    if (llListFindList(operators ,[op]) != -1) {
        //llOwnerSay("Doing " + op);
        if (llGetListEntryType(things, 1) == TYPE_INTEGER) {
            //llOwnerSay("Thing1 of type Integer");
            things = llListReplaceList(things, [get(llList2Integer(things, 1))], 1, 1);
        }
        if (llGetListEntryType(things, 2) == TYPE_INTEGER) {
            //llOwnerSay("Thing2 of type Integer");
            things = llListReplaceList(things, [get(llList2Integer(things, 2))], 2, 2);
        }
        return [(string)integerOp(op, 
                                    (integer)valueOf(llList2String(things, 1)),
                                    (integer)valueOf(llList2String(things, 2)))];
    } else if (op == "atom") {
        if (llGetListEntryType(things, 1) != TYPE_INTEGER)
            return ["1"];
        //llOwnerSay("GEGH is " + get(llList2Integer(things, 1)));
        if (llGetListEntryType(array, (integer)get(llList2Integer(things, 1))) == TYPE_INTEGER) {
            //llOwnerSay("Part is " + get((integer)get(llList2Integer(things, 1))));
            if (get((integer)get(llList2Integer(things, 1))) == "quote") {
                //llOwnerSay("It is " + get((integer)getpointer(llList2Integer(things, 1))));
                if (llGetListEntryType(array, 2*(integer)get((integer)getpointer(llList2Integer(things, 1)))) == TYPE_INTEGER)
                    return ["0"];
                else
                    return ["1"];
 
            }
        }
        return ["0"];
    } else if (op == "car") {
        string s = format((integer)llList2String(things, 1));
        //llOwnerSay("S is " + s);
        string c = car(s);
        //llOwnerSay("CAR IS " + c);
        if ((string)((integer)c) == c)
            return [c];
        return [prog2list("(quote " + c +")")];
    } else if (op == "cdr") {
        string s = format((integer)llList2String(things, 1));
        //llOwnerSay("S is " + s);
        //llOwnerSay("CDR IS " + cdr(s));
        return [prog2list("(quote " + cdr(s) + ")")];
    } else if (op == "list") {
        string lst;
        if (get((integer)get(llList2Integer(things, 1))) == "quote") {
            lst = format((integer)get((integer)getpointer(llList2Integer(things, 1)))) + " ";
        } else {
            lst += llList2String(things, 1) + " ";
        }
        if (get((integer)get(llList2Integer(things, 2))) == "quote") {
            lst += format((integer)get((integer)getpointer(llList2Integer(things, 2))));
        } else {
            lst += llList2String(things, 2);
        }
        //llOwnerSay("HERE: '" + lst + "'");
        //llOwnerSay((string)size());
        integer r = prog2list("(quote (" + lst + "))");
        //llOwnerSay("Final answer is " + (string)r);
        return [r];
    } else if (op == "append") {
        string lst;
        if (get((integer)get(llList2Integer(things, 1))) == "quote") {
            lst = format((integer)get((integer)getpointer(llList2Integer(things, 1))));
            lst = llGetSubString(lst, 1, -2) + " ";
        }
        if (get((integer)get(llList2Integer(things, 2))) == "quote") {
            string part = format((integer)get((integer)getpointer(llList2Integer(things, 2))));
            lst = lst + llGetSubString(part, 1, -2);
        } else {
            lst += llList2String(things, 2);
        }
        return [prog2list("(quote (" + lst + "))")];
    } else if (op == "equal") {
        if (get((integer)get(llList2Integer(things, 1))) == "quote") {
            things = llListReplaceList(things, [get((integer)get((integer)getpointer(llList2Integer(things, 1))))], 1, 1);
        } else if (llGetListEntryType(things, 1) == TYPE_INTEGER) {
            things = llListReplaceList(things, [get(llList2Integer(things, 1))], 1, 1);
        }
        if (get((integer)get(llList2Integer(things, 2))) == "quote") {
            things = llListReplaceList(things, [get((integer)get((integer)getpointer(llList2Integer(things, 2))))], 2, 2);
        } else if (llGetListEntryType(things, 2) == TYPE_INTEGER) {
            things = llListReplaceList(things, [get(llList2Integer(things, 2))], 2, 2);
        }
        //llOwnerSay(llList2CSV(things));
        if (llList2String(things, 1) == llList2String(things, 2)) {
            return ["1"];
        } else {
            return ["0"];
        }
    } else {
        //llOwnerSay("Here!");
        //llOwnerSay(tostring(array));
        string opold = op;
        if (llListFindList(defines, [op]) != -1) {
            //llOwnerSay("The integer is " + llList2String(defines, llListFindList(defines, [op])+1));
            //llOwnerSay("Getting that is " + get((integer)llList2String(defines, llListFindList(defines, [op])+1)));
            if (isdef(get((integer)llList2String(defines, llListFindList(defines, [op])+1))))
                op = llList2String(defines, llListFindList(defines, 
                        [get((integer)llList2String(defines, llListFindList(defines, [op])+1))])+1);
            if (isdef(op))
                op = llList2String(defines, llListFindList(defines, [op])+1);
        }
        integer start = (integer)op;
        //llOwnerSay(opold + " has been defined to be " + (string)start);
        if (get((integer)get(start)) == "lambda") {
            list tmp = defines;
            if (llGetListLength(things) > 1)
                defineVars((integer)get(start+1), llList2List(things, 1, -1));
            //llOwnerSay(tostring(array));
            //llOwnerSay("Defined things: " + llList2CSV(defines));
            //llOwnerSay("So now evaling " + get(start+2));
            list ret = evaluate((integer)get(start+2));
            defines = tmp;
            return ret;
        }
    }
 
    return [];
}
 
integer isdef(string op) {
    return llListFindList(defines + operators, [op]) != -1;
}
 
 
defineVars(integer ptr, list things) {
    if ((integer)get(ptr) != 0) {
        //llOwnerSay("Ptr: " + (string)ptr);
        string var = get((integer)get(ptr));
        //llOwnerSay("Var is " + var);
        adddefine(size(), var);
        //llOwnerSay("'"+llList2String(things, 0)+"'");
        add(llList2String(things, 0), 0);
        if ((integer)getpointer(ptr) != 0) {
            defineVars((integer)getpointer(ptr), llList2List(things, 1, -1));
        }
    }
}
 
string valueOf(string x) {
    //llOwnerSay("What is val of " + x + "?");
    if ((string)((integer)x) == x) {
        //llOwnerSay("= " + x);
        return x;
    } else {
        //llOwnerSay(" = " + llList2String(evaluate(llList2Integer(defines, llListFindList(defines, [x])+1)), 0));
        return llList2String(evaluate(llList2Integer(defines, llListFindList(defines, [x])+1)), 0);
    }
}
 
integer integerOp(string op, integer a, integer b) {
    if (op == "+") return a + b;
    if (op == "-") return a - b;
    if (op == "*") return a * b;
    if (op == "/") return a / b;
    if (op == "=") return a == b;
    if (op == "!=") return a != b;
    if (op == ">") return a > b;
    if (op == "<") return a < b;
    if (op == ">=") return a >= b;
    if (op == "<=") return a <= b;
    return 0;
}
 
default {
    state_entry() {
        llListen(0, "", llGetOwner(), "");
    }
    listen(integer i, string n, key id, string m) {
        //llOwnerSay("A");
        integer loc = size();
        prog2list(m);
        //llOwnerSay(tostring(array));
        //llOwnerSay("Eval: " + (string)loc);
        list l = evaluate(loc);
        if (llGetListEntryType(l, 0) == TYPE_INTEGER)
            llOwnerSay("Answer is " + format((integer)get((integer)getpointer(llList2Integer(l, 0)))));
        else
            llOwnerSay("Answer is " + llList2String(l, 0));
 
        //printOut();
 
        //llOwnerSay("Defines: " + llList2CSV(defines));
    }
}