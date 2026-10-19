package RMI;
import java.rmi.Naming;
public class client {
    public static void main(String[] args){
        try{
            calculator obj=
                (calculator) Naming.lookup(
                    "rmi://localhost/calculator");
            System.out.println("Addition = "
                +obj.add(10,20));
            System.out.println("Subtraction = "
                +obj.subtract(20,10));  
        }
        catch(Exception e){
            System.out.println(e);
        }
    }
    
}
