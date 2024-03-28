import absyn.*;
import java.util.HashMap;
import java.util.ArrayList;

public class SemanticAnalyzer implements AbsynVisitor{
    HashMap<String, ArrayList<NodeType>> table = new HashMap<String, ArrayList<NodeType>>();

    final static int SPACES = 4;
    String currFunc = "";

    private void indent(int level)  {
      for( int i = 0; i < level * SPACES; i++ ) System.out.print( " " );
    }
    

    private void printTable(int level){
        for(ArrayList<NodeType> nodes : table.values())
        {
            if(nodes.isEmpty() == false) // not empty
            {
                for(int i = 0; i < nodes.size(); i++)
                {
                    NodeType node = nodes.get(i);
                    if(node.level == level)
                    {
                        indent(level);
                        System.out.println(node.name + " " + node.def.toString());
                    }
                }
            }
        }
    }

    private void insert(NodeType node){
        if(table.containsKey(node.name)){
            table.get(node.name).add(0, node);
        }
        else{ 
            ArrayList<NodeType> arrList = new ArrayList<NodeType>();
            arrList.add(0, node);
            table.put(node.name, arrList);
        }
    }

    private ArrayList<NodeType> lookup(NodeType node){
        if(table.containsKey(node.name)){
            return table.get(node.name);
        }
        return null;
    }

    private void delete(int level){
        boolean delCheck;
        while(true)
        {
            delCheck = false;
            for(ArrayList<NodeType> nodes : table.values())
            {
                if(nodes.isEmpty() == false)
                {
                    for(int i = 0; i < nodes.size(); i++)
                    {
                        NodeType node = nodes.get(i);
                        if(node.level == level)
                        {
                            nodes.remove(i);
                            if(nodes.size() == 0)
                            {
                                table.remove(node.name);
                                delCheck = true;
                                break;
                            }
                        }
                    }
                }
                if(delCheck == true) // if something is deleted
                {
                    break;
                }
            }
            if(delCheck == false) // if nothing is deleted
            {
                break;
            }
        }
    }

    // private void delete(int level) {
    //     for (ArrayList<NodeType> nodes : table.values()) {
    //         if (!nodes.isEmpty()) {
    //             Iterator<NodeType> iterator = nodes.iterator();
    //             while (iterator.hasNext()) {
    //                 NodeType node = iterator.next();
    //                 if (node.level == level) {
    //                     System.out.println(node.name);
    //                     iterator.remove();
    //                 }
    //             }
    //         }
    //     }
    // }
    

    public void visit(NameTy exp, int level, boolean isAddr) {
        if(exp.type == 0){
            System.out.println("BOOL");
        }
        else if(exp.type == 1){
            System.out.println("INT");
        }
        else{
            System.out.println("VOID");
        }
    }

    public void visit(SimpleVar exp, int level, boolean isAddr) {
        ArrayList<NodeType> list = table.get(exp.name);
        boolean isDeclared = false;
    
        if (list != null) {
            for (NodeType node : list) {
                if (node.level <= level) {
                    isDeclared = true;
                    break; //match found
                }
            }
        }
    
        //not found
        if (isDeclared == false) {
            System.err.println("ERROR: the variable " + exp.name + " is undeclared at row " + (exp.row + 1) + ", column " + (exp.col + 1));
        }
    }
    
    public void visit(IndexVar exp, int level, boolean isAddr) {
        if(exp != null)
        {
            ArrayList<NodeType> list = table.get(exp.name);
            boolean isDeclared = false;
        
            if (list != null) {
                for (NodeType node : list) {
                    if (node.level <= level) {
                        isDeclared = true;
                        break; //match found
                    }
                }
            }
        
            //not found
            if (isDeclared == false) {
                System.err.println("ERROR: the variable " + exp.name + " is undeclared at row " + (exp.row + 1) + ", column " + (exp.col + 1));
            }

            exp.index.accept(this, level, false);
            //check if the index returns an integer for indexing the variable
            if(exp.index instanceof VarExp)
            {
                VarExp var = (VarExp)exp.index;
                visit(var, level, false);
                if(var.dtype instanceof SimpleDec)
                {
                    SimpleDec dec = (SimpleDec)var.dtype;
                    if(dec.typ.type != NameTy.INT)
                    {
                        System.err.println("ERROR: the index " + dec.name + " is not an integer at row " + (exp.row + 1) + ", column " + (exp.col + 1));
                    }
                }
            }
            else if(exp.index instanceof CallExp)
            {
                CallExp call = (CallExp)exp.index;
                visit(call, level, false);
                FuncDec func = (FuncDec)call.dtype;
                if(func.result.type != NameTy.INT)
                {
                    System.err.println("ERROR: the index " + call.func + " is not an integer at row " + (exp.row + 1) + ", column " + (exp.col + 1));
                }
            }
            else if(!(exp.index instanceof IntExp))
            {
                System.err.println("ERROR: the index is not an integer at row " + (exp.row + 1) + ", column " + (exp.col + 1));
            }
        }
    }

    public void visit(Vartype exp, int level, boolean isAddr) {
        //extends absyn so it has no dtype to assign, blank?
    }

    public void visit(NilExp exp, int level, boolean isAddr) {
        //leave blank?
    }

    public void visit(IntExp exp, int level, boolean isAddr) {
        //leave blank?
    }

    public void visit(BoolExp exp, int level, boolean isAddr) {
        //leave blank?
    }

    public void visit(VarExp exp, int level, boolean isAddr) {
        if(exp != null)
        {
            //go to var in VarExp
            exp.varName.accept(this, level, false);
            if(exp.varName instanceof SimpleVar) // if var is a simplevar
            {
                SimpleVar var = (SimpleVar)exp.varName;
                ArrayList<NodeType> list = table.get(var.name);
                if(list != null)
                {
                    for(NodeType node : list)
                    {
                        if(node.level == level) //if the current node is of the same scope
                        {
                            exp.dtype = node.def;
                        }
                    }

                    if(exp.dtype == null && list.size() > 0) // above for loop did not find node on same level
                    {
                        NodeType node = (NodeType)list.get(0); //most recent addition to declaration list
                        exp.dtype = node.def;
                    }
                }                                                                                                                                                                                                                                                                              
            }

            if(exp.varName instanceof IndexVar) // if var is a IndexVar
            {
                IndexVar var = (IndexVar)exp.varName;
                ArrayList<NodeType> list = table.get(var.name);
                if(list != null)
                {
                    for(NodeType node : list)
                    {
                        if(node.level == level) //if the current node is of the same scope
                        {
                            exp.dtype = node.def;
                        }
                    }

                    if(exp.dtype == null && list.size() > 0) // above for loop did not find node on same level
                    {
                        NodeType node = (NodeType)list.get(0); //most recent addition to declaration list
                        exp.dtype = node.def;
                    }
                }                                                                                                                                                                                                                                                                                
            }
            //exp.dec = (VarDec) var.dec; //TODO anywhere a simple is used we need a reference to where it is declared
        }
    }

    public void visit(CallExp exp, int level, boolean isAddr) {
        boolean isDeclared = false;

        if (exp != null) {
            for (ArrayList<NodeType> list : table.values()) {
                if (list.isEmpty() == false) {
                    for (NodeType node : list) {
                        if (exp.func.equals(node.name)) {
                            isDeclared = true;
                            exp.dtype = node.def;
                            break; //match found
                        }
                    }
                }
                if (isDeclared) {
                    break;
                }
            }

            if (isDeclared && exp.args != null) {
                exp.args.accept(this, level, false);
            }
            else if (!isDeclared) {
                System.err.println("ERROR: undefined function " + exp.func + " called at row " + (exp.row + 1) + ", column " + (exp.col + 1));
            }

            if(isDeclared && exp.args != null) {
                FuncDec funcDef = (FuncDec)exp.dtype;
                VarDecLists varHead = null;
                if(funcDef != null){
                    varHead = (VarDecLists)funcDef.params;
                }
                ExpList expHead = (ExpList)exp.args;

                int numCall = 0;
                int numDef = 0;

                while(varHead != null && expHead != null) 
                {
                    int callArg = 3;
                    int funcArg = -3;

                    if(!(expHead.head instanceof NilExp))
                    {
                        numCall++;
                    }
                    if((varHead.head != null))
                    {
                        numDef++;
                    }

                    
                    if(expHead.head instanceof IntExp)
                    {
                        callArg = NameTy.INT;
                    }
                    else if(expHead.head instanceof BoolExp)
                    {
                        callArg = NameTy.BOOL;
                    }
                    else if (expHead.head instanceof OpExp) {
                        OpExp op = (OpExp)expHead.head;  
                        //expressions that can equate to an integer are simple, function call, or an array
                        if(op.dtype instanceof SimpleDec)
                        {
                            SimpleDec simp = (SimpleDec)op.dtype;
                            callArg = simp.typ.type; 
                        }
                        else if(op.dtype instanceof FuncDec)
                        {
                            FuncDec func = (FuncDec)op.dtype;
                            callArg = func.result.type;
                        }
                        else if(op.dtype instanceof ArrayDec)
                        {
                            ArrayDec array = (ArrayDec)op.dtype;
                            callArg = array.type.type;
                        }  
                    }
                    else if (expHead.head instanceof VarExp)
                    {
                        VarExp var = (VarExp)expHead.head;
                        if(var.dtype instanceof SimpleDec)
                        {
                            SimpleDec simp = (SimpleDec)var.dtype;
                            callArg = simp.typ.type; 
                        }
                        else if(var.dtype instanceof ArrayDec)
                        {
                            ArrayDec array = (ArrayDec)var.dtype;
                            callArg = array.type.type;
                        }
                    }
                    else if (expHead.head instanceof CallExp)
                    {
                        CallExp call = (CallExp)expHead.head;
                        FuncDec func = (FuncDec)call.dtype;

                        if(func != null)
                        {
                            callArg = func.result.type;
                        }
                        else
                        {
                            callArg = NameTy.INT; // assume the function returns an int
                        }
                    }
                
                    if(varHead.head instanceof SimpleDec)
                    {
                        SimpleDec simp = (SimpleDec)varHead.head;
                        funcArg = simp.typ.type; 
                    }
                    else if(varHead.head instanceof ArrayDec)
                    {
                        ArrayDec array = (ArrayDec)varHead.head;
                        funcArg = array.type.type;
                    }
                    

                    if(callArg != funcArg)
                    {
                        System.err.println("ERROR: function call argument does not match function definition parameter at row " + (exp.row + 1) + ", column " + (exp.col + 1) + ".");
                    }

                    varHead = varHead.tail;
                    expHead = expHead.tail;
                }

                if(expHead != null)
                {
                    numCall++;
                }
                if(varHead != null)
                {
                    numDef++;
                }

                if(numCall != numDef)
                {
                    System.err.println("ERROR: function call does not contain correct number of arguments at row " + (exp.row + 1) + ", column " + (exp.col + 1) + ".");
                }
            }
        }
    }
    
    public void visit(OpExp exp, int level, boolean isAddr) {
        if(exp != null)
        {
            int leftExpRes = 3;
            int rightExpRes = -3;

            exp.left.accept(this, level, false);
            exp.right.accept(this, level, false);

            //left and right can be IntExp, BoolExp, CallExp, OpExp, VarExp
            //mismatched types on each side of the expression
            if (((exp.left instanceof IntExp) && (exp.right instanceof BoolExp)) || 
                ((exp.left instanceof BoolExp) && (exp.right instanceof IntExp))) {
                System.err.println("ERROR: Mismatched types for operation expression at row " + (exp.row + 1) + ", column " + (exp.col + 1) + ". Expression must only contain one type of int or bool.");
            }

            //left side
            if(exp.left instanceof IntExp)
            {
                leftExpRes = NameTy.INT;
            }
            else if(exp.left instanceof BoolExp)
            {
                leftExpRes = NameTy.BOOL;
            }
            //if there is a function call on either side
            else if (exp.left instanceof CallExp) {
                FuncDec func = (FuncDec)exp.left.dtype;
                if(func != null)
                {
                    leftExpRes = func.result.type;
                }
                else
                {
                    leftExpRes = NameTy.INT; // assume the function returns an int
                }
                
            }
            else if (exp.left instanceof OpExp) {
                OpExp op = (OpExp)exp.left;  
                //expressions that can equate to an integer are simple, function call, or an array
                if(op.dtype instanceof SimpleDec)
                {
                    SimpleDec simp = (SimpleDec)op.dtype;
                    leftExpRes = simp.typ.type; 
                }
                else if(op.dtype instanceof FuncDec)
                {
                    FuncDec func = (FuncDec)op.dtype;
                    leftExpRes = func.result.type;
                }
                else if(op.dtype instanceof ArrayDec)
                {
                    ArrayDec array = (ArrayDec)op.dtype;
                    leftExpRes = array.type.type;
                }  
            }
            else if (exp.left instanceof VarExp)
            {
                VarExp var = (VarExp)exp.left;
                if(var.dtype instanceof SimpleDec)
                {
                    SimpleDec simp = (SimpleDec)var.dtype;
                    leftExpRes = simp.typ.type; 
                }
                else if(var.dtype instanceof ArrayDec)
                {
                    ArrayDec array = (ArrayDec)var.dtype;
                    leftExpRes = array.type.type;
                }
            }
            else if (exp.left instanceof NilExp) // special case only occurs when there is a unary minus
            {
                leftExpRes = NameTy.INT;
            }



            //right side
            if(exp.right instanceof IntExp)
            {
                rightExpRes = NameTy.INT;
            }
            else if(exp.right instanceof BoolExp)
            {
                rightExpRes = NameTy.BOOL;
            }
            //if there is a function call on either side
            else if (exp.right instanceof CallExp) {
                FuncDec func = (FuncDec)exp.right.dtype;
                if(func != null)
                {
                    rightExpRes = func.result.type;
                }
                else
                {
                    rightExpRes = NameTy.INT; // assume the function returns an int
                }
            }
            //if there is another operation expression on either side 
            else if (exp.right instanceof OpExp) {
                OpExp op = (OpExp)exp.right;
                //expressions that can equate to an integer are simple, function call, or an array
                if(op.dtype instanceof SimpleDec)
                {
                    SimpleDec simp = (SimpleDec)op.dtype;
                    rightExpRes = simp.typ.type; 
                }
                else if(op.dtype instanceof FuncDec)
                {
                    FuncDec func = (FuncDec)op.dtype;
                    rightExpRes = func.result.type;
                }
                else if(op.dtype instanceof ArrayDec)
                {
                    ArrayDec array = (ArrayDec)op.dtype;
                    rightExpRes = array.type.type;
                }
            }
            else if (exp.right instanceof VarExp)
            {
                VarExp var = (VarExp)exp.right;
                if(var.dtype instanceof SimpleDec)
                {
                    SimpleDec simp = (SimpleDec)var.dtype;
                    rightExpRes = simp.typ.type; 
                }
                else if(var.dtype instanceof ArrayDec)
                {
                    ArrayDec array = (ArrayDec)var.dtype;
                    rightExpRes = array.type.type;
                }
            }

            if(leftExpRes != rightExpRes)
            {
                System.err.println("ERROR: operation expressions left and right side have a mismatched type at row " + (exp.row + 1) + ", column " + (exp.col + 1));
            }
            else if(exp.left.dtype != null) //if exp.left.dtype is NilExp, it will be null
            {
                exp.dtype = exp.left.dtype;
            }
            else if(exp.right.dtype != null)
            {
                exp.dtype = exp.right.dtype;
            }
            else if(leftExpRes == NameTy.INT && rightExpRes == NameTy.INT) // both side dtypes are null
            {
                SimpleDec i = new SimpleDec(exp.row, exp.col, new NameTy(exp.row, exp.col, NameTy.INT), "integerSum");
                exp.dtype = i;
            }
            else if(leftExpRes == NameTy.BOOL && rightExpRes == NameTy.BOOL)
            {
                SimpleDec b = new SimpleDec(exp.row, exp.col, new NameTy(exp.row, exp.col, NameTy.BOOL), "boolAns");
                exp.dtype = b;
            }
        }
    }

    public void visit(AssignExp exp, int level, boolean isAddr) {
        if(exp != null)
        {
            //will be used at end of function to compare the type values between the lhs and rhs
            int leftExpRes = 3;
            int rightExpRes = -3;

            // lhs of assignment can be a simple or array
            exp.lhs.accept(this, level, false);
            exp.rhs.accept(this, level, false);

            if(exp.lhs.dtype instanceof SimpleDec)
            {
                SimpleDec simp = (SimpleDec)exp.lhs.dtype;
                leftExpRes = simp.typ.type;
            } 
            else if(exp.lhs.dtype instanceof ArrayDec)
            {
                ArrayDec array = (ArrayDec)exp.lhs.dtype;
                leftExpRes = array.type.type;
            }

            // rhs of assignment can be a simple, array, function call, opExp, bool, or int
            if(exp.rhs.dtype instanceof SimpleDec) // declarations use a dtype since rhs is not an dec
            {
                SimpleDec simp = (SimpleDec)exp.rhs.dtype;
                rightExpRes = simp.typ.type;
            } 
            else if(exp.rhs.dtype instanceof ArrayDec) // declarations use a dtype since rhs is not an dec
            {
                ArrayDec array = (ArrayDec)exp.rhs.dtype;
                rightExpRes = array.type.type;
            }
            else if(exp.rhs instanceof CallExp) 
            {
                CallExp call = (CallExp)exp.rhs;
                FuncDec func = (FuncDec)call.dtype;

                if(func != null)
                {
                    rightExpRes = func.result.type;
                }
                else
                {
                    rightExpRes = NameTy.INT; // assume the function returns an int
                }
            }
            else if(exp.rhs instanceof OpExp) // will need to check each operator
            {
                OpExp op = (OpExp)exp.rhs;
                //number operators, rest are boolean
                if(op.op == OpExp.UMINUS && op.left instanceof NilExp)
                {
                    rightExpRes = NameTy.INT;
                }
                else if(op.op == OpExp.PLUS || op.op == OpExp.MINUS || op.op == OpExp.TIMES || op.op == OpExp.DIVIDE || op.op == OpExp.UMINUS || op.op == OpExp.EQ)
                {   

                    //expressions that can equate to an integer are simple, function call, or an array
                    if(op.dtype instanceof SimpleDec)
                    {
                        SimpleDec simp = (SimpleDec)op.dtype;
                        rightExpRes = simp.typ.type; 
                    }
                    else if(op.dtype instanceof FuncDec)
                    {
                        FuncDec func = (FuncDec)op.dtype;
                        rightExpRes = func.result.type;
                    }
                    else if(op.dtype instanceof ArrayDec)
                    {
                        ArrayDec array = (ArrayDec)op.dtype;
                        rightExpRes = array.type.type;
                    }
                }
                else
                {
                    rightExpRes = NameTy.BOOL;
                }
            }
            else if(exp.rhs instanceof BoolExp)
            {
                rightExpRes = NameTy.BOOL;
            }
            else
            {
                rightExpRes = NameTy.INT;
            }

            if(leftExpRes != rightExpRes)
            {
                System.err.println("ERROR: the left and right side of the assignment expressions have a mismatched type at row " + (exp.row + 1) + ", column " + (exp.col + 1));
            }
            else
            {
                exp.dtype = exp.rhs.dtype;
            }

        }
        
    }

    public void visit(IfExp exp, int level, boolean isAddr) {
        if (exp != null && exp.test != null) {
            indent(level);
            System.out.println("Entering the If block scope:");

            //IF
            exp.test.accept(this, level, false);
            //TODO: possible check for void here? not sure yet
            level++;
            exp.thenpart.accept(this, level, false);


            printTable(level);
            delete(level);

            level--;
            indent(level);
            System.out.println("Exiting the If block scope");
            //ELSE
            if (!(exp.elsepart instanceof NilExp)) {
                indent(level);
                System.out.println("Entering the Else block scope");
                
                level++;
                exp.elsepart.accept(this, level, false);
                printTable(level);
                delete(level);
                
                level--;
                indent(level);
                System.out.println("Exiting the Else block scope");
                
            }
        }
    }

    public void visit(WhileExp exp, int level, boolean isAddr) {
        if(exp != null && exp.test != null) {
            
            indent(level);
            System.out.println("Entering the While block scope:");

            exp.test.accept(this, level, false);
            if(exp.test instanceof CallExp)
            {
                CallExp call = (CallExp)exp.test;
                visit(call, level, false);
                FuncDec dec = (FuncDec)call.dtype;
                if(dec == null)
                {
                    System.err.println("ERROR: at row " + (exp.row + 1) + ", column " + (exp.col + 1) +" : called function returned VOID");
                }
                else
                {
                    if(dec.result.type == NameTy.VOID)
                    {
                        System.err.println("ERROR: at row " + (exp.row + 1) + ", column " + (exp.col + 1) +" : called function returned VOID");
                    }
                }
            }

            level++;
            
            if(exp.body != null)
            {
                exp.body.accept(this, level, false);
            }
            printTable(level);
            delete(level);
            
            level--;
            indent(level);
            System.out.println("Exiting the While block scope");
        }
    }

    public void visit(ReturnExp exp, int level, boolean isAddr) {
        FuncDec fun1 = null;
        if (exp.exp == null) {
            System.err.println("ERROR: function with a non-void returns void at row " + (exp.row + 1) + ", column " + (exp.col + 1));
        }
        else {
            int returnType = 99; //initialize it as a number that is not associated with a return type
            exp.exp.accept(this, level, false);

            //return type of the corresponding function
            for (ArrayList<NodeType> list: table.values()){
                for (int i = 0; i < list.size(); i++){
                    NodeType node = (NodeType)list.get(i);

                    if (level != 0 && currFunc.equals(node.name)){
                        fun1 = (FuncDec)node.def;
                    }
                }
            }
            
            //return type of the return statement
            if(exp.exp instanceof NilExp){
                returnType = NameTy.VOID;
            }
            else if (exp.exp instanceof BoolExp) {
                returnType = NameTy.BOOL;
            }
            else if (exp.exp instanceof IntExp) {
                returnType = NameTy.INT;
            }
            else if (exp.exp instanceof CallExp) {
                visit((CallExp)exp.exp, level, false);
                if ((FuncDec)exp.exp.dtype != null) {
                    FuncDec fun2 = (FuncDec)exp.exp.dtype;
                    returnType = fun2.result.type;
                }
            }
            else if(exp.exp instanceof VarExp){
                VarExp tempVar = (VarExp)exp.exp;

                if (tempVar.dtype instanceof SimpleDec){
                    SimpleDec tempDec = (SimpleDec)tempVar.dtype;
                    returnType = tempDec.typ.type;
                    
                }else if(tempVar.dtype instanceof ArrayDec){
                    ArrayDec tempDec = (ArrayDec)tempVar.dtype;
                    returnType = tempDec.type.type;
                }
            }
            else if (exp.exp instanceof OpExp){
                visit((OpExp)exp.exp, level, false);
                if(exp.exp.dtype instanceof SimpleDec)
                {
                    SimpleDec simp = (SimpleDec)exp.exp.dtype;
                    returnType = simp.typ.type; 
                }
                else if(exp.exp.dtype instanceof FuncDec)
                {
                    FuncDec func = (FuncDec)exp.exp.dtype;
                    returnType = func.result.type;
                }
                else if(exp.exp.dtype instanceof ArrayDec)
                {
                    ArrayDec array = (ArrayDec)exp.exp.dtype;
                    returnType = array.type.type;
                }
            }
            
            //check if the return value matches the return type
            if (returnType != fun1.result.type) {
                System.err.println("ERROR: invalid return type for the function at row: " + (exp.row + 1) + ", column: " + (exp.col + 1));
            }
        }
    }

    public void visit(CompoundExp exp, int level, boolean isAddr) {
        if(exp != null){
            visit(exp.decs, level, false); //visit VarDecLists
            visit(exp.exp, level, false); //visit ExpList
        }
    }

    public void visit(FuncDec exp, int level, boolean isAddr) {
        indent(level);
        System.out.println("Entering the scope of the " + exp.func + " function:");

        NodeType dec = new NodeType(exp.func, exp, level);

        //function name
        if(lookup(dec) != null){
            System.err.println("ERROR: duplicate function declaration for " + exp.func + " at row " + (exp.row + 1) + ", column " + (exp.col + 1));
        }
        else{
            currFunc = dec.name;
            insert(dec);
        }
        
        level++;

        //function parameters
        if (exp.params != null){
            exp.params.accept(this, level, false);
        }

        //function body
        if (exp.body != null){
            exp.body.accept(this, level, false);
        }

        printTable(level);
        delete(level);

        level--;
        indent(level);
        System.out.println("Exiting the scope of the " + exp.func + " function");
    }

    public void visit(SimpleDec exp, int level, boolean isAddr) {
        if (exp != null){
            NodeType dec = new NodeType(exp.name, exp, level);
            
            if(exp.typ.type == NameTy.VOID){
                System.err.println("ERROR: void variable declaration for " + exp.name + " at row " + (exp.row + 1) + ", column " + (exp.col + 1));
                exp.typ.type = NameTy.INT;
                dec = new NodeType(exp.name, exp, level);
                if(lookup(dec) == null)
                {
                    insert(dec);
                }
            }
            else{
                if(lookup(dec) != null){
                    System.err.println("ERROR: duplicate variable declaration for " + exp.name + " at row " + (exp.row + 1) + ", column " + (exp.col + 1));
                }
                else{
                    insert(dec);
                }
            }
        }       
    }

    public void visit(ArrayDec exp, int level, boolean isAddr) {
        if (exp != null){
            NodeType dec = new NodeType(exp.name, exp, level);

            if(lookup(dec) != null){
                System.err.println("ERROR: duplicate variable declaration for " + exp.name + " at row " + (exp.row + 1) + ", column " + (exp.col + 1));
            }
            else{
                insert(dec); //adds it to the table
            }
        }
    }

    public void visit(ExpList exp, int level, boolean isAddr) {
        while (exp != null && exp.head != null) {
            exp.head.accept(this, level, false);
            exp = exp.tail;
        }
    }

    public void visit(DecLists exp, int level, boolean isAddr) {
        System.out.println("Entering global scope:");
        level++;

        NameTy inputType = new NameTy(0, 0, NameTy.INT);
        FuncDec inputDec = new FuncDec(0, 0, inputType, "input", null, null);

        NameTy outType = new NameTy(0, 0, NameTy.VOID);
        SimpleDec outInt = new SimpleDec(0, 0, inputType, "outInt");
        VarDecLists outParams = new VarDecLists(outInt, null);
        FuncDec outputDec = new FuncDec(0, 0, outType, "input", outParams, null);
        NodeType inputFunc = new NodeType("input", inputDec, level);
        NodeType outputFunc = new NodeType("output", outputDec, level);
        insert(inputFunc);
        insert(outputFunc);

        while(exp != null && exp.head != null){
            exp.head.accept(this, level, false);
            exp = exp.tail;
        }

        
        printTable(level);
        
        NodeType dec = new NodeType("main", null, level);
        if(lookup(dec) == null){
            System.err.println("ERROR: main function not found");
        }
        level--;
        System.out.println("Exiting global scope");
    }

    public void visit(VarDecLists exp, int level, boolean isAddr) {
        while (exp != null && exp.head != null) {
            exp.head.accept(this, level);
            exp = exp.tail;
        }
    }

}