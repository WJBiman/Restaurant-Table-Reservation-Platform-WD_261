import com.restaurant.service.ReservationService;

public class Test {
    public static void main(String[] args) {
        ReservationService service = new ReservationService();
        boolean deleted = service.deleteReservation("R005");
        System.out.println("Deleted R005? " + deleted);
        System.out.println("Remaining count: " + service.getAllReservations().size());
    }
}
