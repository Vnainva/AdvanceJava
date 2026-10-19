package RMI;
import java.rmi.server.UnicastRemoteObject;
import java.rmi.RemoteException;
public class calculatorImpl 
    extends UnicastRemoteObject
    implements calculator{
        calculatorImpl() throws RemoteException{
            super();
        }
        public int add(int a,int b){
            return a+b;
        }
        public int subtract(int a,int b){
            return a-b;
        }
    }

