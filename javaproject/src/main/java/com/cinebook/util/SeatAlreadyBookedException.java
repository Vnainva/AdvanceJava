package com.cinebook.util;

import java.util.List;

public class SeatAlreadyBookedException extends Exception {
    private final List<String> conflictingSeats;

    public SeatAlreadyBookedException(String message, List<String> conflictingSeats) {
        super(message);
        this.conflictingSeats = conflictingSeats;
    }

    public List<String> getConflictingSeats() {
        return conflictingSeats;
    }
}
