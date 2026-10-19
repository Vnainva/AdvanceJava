package RMI;
import java.rmi.Naming;
public class server {
    public static void main(String[] args){
        try{
            calculatorImpl obj =new calculatorImpl();
            Naming.rebind("rmi.//localhost/calculator",obj);
            System.out.println("RMI server started...");

        }
        catch(Exception e){
            System.out.println(e);
        }
    }
}
