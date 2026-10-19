import java.sql.*;

public class JdbcDemo {
    public static void main(String args[]) throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/college1",
                "root",
                "Admin_21");
        System.out.println("Connection Successful");
        PreparedStatement ps = con.prepareStatement(
                "insert into student values(?,?,?)");
        ps.setInt(1, 103);
        ps.setString(2, "Rahul");
        ps.setString(3, "CSE");
        ps.executeUpdate();
        System.out.println("Record Inserted");
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(
                "select * from student");
        while (rs.next()) {
            System.out.println(
                    rs.getInt(1) + " " +
                            rs.getString(2) + " " +
                            rs.getString(3));
        }
        con.close();
    }
}
