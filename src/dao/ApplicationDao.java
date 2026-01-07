import java.sql.Connection;
import java.sql.PreparedStatement;
import util.DBConnection;

public class ApplicationDao {

    public boolean insertRegistration(String name, String phoneNum,
                                      String ICnum, Integer userID, int eventID) {

        boolean result = false;

        String sql = "INSERT INTO registration " +
                     "(name, phoneNum, ICnum, userID, eventID) " +
                     "VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, phoneNum);
            ps.setString(3, ICnum);

            if (userID != null) {
                ps.setInt(4, userID);
            } else {
                ps.setNull(4, java.sql.Types.INTEGER);
            }

            ps.setInt(5, eventID);

            result = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}
