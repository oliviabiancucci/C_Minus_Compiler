/*
  CM file is a rename of the Main.java file created by Fei Song with the following description:

    Created by: Fei Song
    File Name: Main.java
    To Build: 
    After the Scanner.java, tiny.flex, and tiny.cup have been processed, do:
      javac Main.java
    
    To Run: 
      java -classpath /usr/share/java/cup.jar:. Main gcd.tiny

    where gcd.tiny is an test input file for the tiny language.
*/
   
import java.io.*;
import absyn.*;
   
class CM {
  public static boolean SHOW_TREE = false;
  public static boolean SHOW_TABLE = false;
  public static boolean SHOW_CODE = false;
  static public void main(String argv[]) {  
    int i;
    File absFile = null;
    File symFile = null;
    File tmFile = null;

    for(i = 0; i < argv.length; i++)
    {
      if (argv[i].equals("-a"))
      {
        SHOW_TREE = true;
      }
      else if (argv[i].equals("-s"))
      {
        SHOW_TABLE = true;
      }
      else if(argv[i].equals("-c"));
      {
        SHOW_CODE = true;
      }
    }
    //TODO: finish implementing the options below - show_tree and show_table generation to file
    
    /* Start the parser */
    try {
      parser p = new parser(new Lexer(new FileReader(argv[argv.length - 1])));
      Absyn result = (Absyn)(p.parse().value);      
      if (SHOW_TREE && result != null) { // normal abstract syntax tree run
        int fileExt = argv[argv.length - 1].lastIndexOf(".");
        String fileName = argv[argv.length - 1].substring(0, fileExt);
        fileName = fileName + ".abs";
        absFile = new File(fileName);
        PrintStream absFileStream = new PrintStream(absFile);
        System.setOut(absFileStream);
        System.out.println("The abstract syntax tree is:");
        AbsynVisitor visitor = new ShowTreeVisitor();
        result.accept(visitor, 0, false); 
      }
      if(parser.valid == true)
      {
        if(SHOW_TABLE && result != null)
        {
          int fileExt = argv[argv.length - 1].lastIndexOf(".");
          String fileName = argv[argv.length - 1].substring(0, fileExt);
          fileName = fileName + ".sym";
          symFile = new File(fileName);
          PrintStream symFileStream = new PrintStream(symFile);
          System.setOut(symFileStream);
          SemanticAnalyzer semVisitor = new SemanticAnalyzer();
          result.accept(semVisitor, 0, false);
        }
      }
      if(SemanticAnalyzer.valid == true)
      {
        if(SHOW_CODE && result != null)
        {
          int fileExt = argv[argv.length - 1].lastIndexOf(".");
          String fileName = argv[argv.length - 1].substring(0, fileExt);
          fileName = fileName + ".tm";
          tmFile = new File(fileName);
          PrintStream tmFileStream = new PrintStream(tmFile);
          System.setOut(tmFileStream);
          CodeGenerator codeGenVisit = new CodeGenerator();
          codeGenVisit.prelude(fileName);
          result.accept(codeGenVisit, 0, false);
          codeGenVisit.finale();
        }
      }
      else
      {
        System.out.println("ERROR: Semantic analysis aborted due to syntax errors");
      }
    } catch (Exception e) {
      /* do cleanup here -- possibly rethrow e */
      e.printStackTrace();
    }
  }
}
