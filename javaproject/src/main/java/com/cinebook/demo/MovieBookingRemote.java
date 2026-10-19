package com.cinebook.demo;

import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.List;

/**
 * RMI Remote Interface for Movie Booking
 */
public interface MovieBookingRemote extends Remote {
    List<String> getAvailableMovies() throws RemoteException;
    double calculateCost(String movieTitle, int ticketCount) throws RemoteException;
    String bookTicket(String customerName, String movieTitle, int ticketCount) throws RemoteException;
}
