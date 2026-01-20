package dao;

import java.sql.*;
import util.DBConnection;
import bean.User;

public class LoginDao {

    public User validateUser(User loginBean) {
        String username = loginBean.getUsername();
        String password = loginBean.getPassword();

        User user = null;

        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(
                     "SELECT * FROM users WHERE username=? AND password=?")) {

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                 user = new User();
                user.setId(rs.getInt("userid"));
                user.setUsername(rs.getString("username"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }
}
