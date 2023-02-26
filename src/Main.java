import java.sql.*;

public class Main {
    static final String DB_URL = "jdbc:mariadb://localhost:3306/test";
    static final String USER = "root";
    static final String PASS = "";


    public static void main(String[] args) {

        final IpInputManager ipManager = new IpInputManager();




        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)) {
            System.out.println("===============");
            System.out.println("connected to db");
            System.out.println("===============");
            System.out.println();


            System.out.println("Enter IP address");
            // get user input
            do {
                ipManager.getInputFromUser();
            } while (!ipManager.isInputValid());

            String query1 = "SELECT country, city, stateprov, ip_end_num FROM DbIp_Lookup_Educa\n" +
                            "WHERE ip_start_num <= " + ipManager.getIp() +" ORDER BY ip_start_num DESC LIMIT 1;";

            System.out.println();

            long timeStart = System.currentTimeMillis();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query1);

            System.out.println("query time : " + (System.currentTimeMillis() - timeStart) + "ms");
            System.out.println();



            // print results
            System.out.println("--== results ==--");
            while (rs.next()){

                // check if result is valid
                if (ipManager.getIp() <= rs.getLong("ip_end_num")){
                    System.out.println("Country: " + rs.getString("country"));
                    System.out.println("City: " + rs.getString("city"));
                    System.out.println("Stateprov: " + rs.getString("stateprov"));
                }else {
                    System.out.println("No valid results :(");
                }


            }


        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}