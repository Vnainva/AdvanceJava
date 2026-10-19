/**
 * CineBook Interactive Seat Selection JavaScript
 */
document.addEventListener("DOMContentLoaded", () => {
    const seatGrid = document.querySelector(".seat-grid");
    if (!seatGrid) return;

    const unitPrice = parseFloat(seatGrid.dataset.unitPrice || "0");
    const selectedSeatsInput = document.getElementById("selectedSeatsInput");
    const selectedSeatsDisplay = document.getElementById("selectedSeatsDisplay");
    const countDisplay = document.getElementById("selectedCountDisplay");
    const totalDisplay = document.getElementById("totalPriceDisplay");
    const checkoutBtn = document.getElementById("btnProceedCheckout");

    const selectedSeats = new Set();

    seatGrid.addEventListener("click", (e) => {
        const seat = e.target.closest(".seat");
        if (!seat || seat.classList.contains("booked")) {
            return;
        }

        const seatNumber = seat.dataset.seat;
        if (selectedSeats.has(seatNumber)) {
            selectedSeats.delete(seatNumber);
            seat.classList.remove("selected");
        } else {
            // Maximum 8 seats per booking
            if (selectedSeats.size >= 8) {
                alert("You can select up to a maximum of 8 seats per booking.");
                return;
            }
            selectedSeats.add(seatNumber);
            seat.classList.add("selected");
        }

        updateUI();
    });

    function updateUI() {
        const seatsArray = Array.from(selectedSeats).sort();
        const count = seatsArray.length;
        const total = (count * unitPrice).toFixed(2);

        if (selectedSeatsInput) {
            selectedSeatsInput.value = seatsArray.join(",");
        }

        if (selectedSeatsDisplay) {
            selectedSeatsDisplay.textContent = count > 0 ? seatsArray.join(", ") : "None";
        }

        if (countDisplay) {
            countDisplay.textContent = count;
        }

        if (totalDisplay) {
            totalDisplay.textContent = "₹ " + total;
        }

        if (checkoutBtn) {
            checkoutBtn.disabled = (count === 0);
        }
    }
});
