import java.sql.*;
import java.util.List;

/**
 * A class that connects to PostgreSQL and disconnects.
 * You will need to change your credentials below, to match the usename and password of your account
 * in the PostgreSQL server.
 * The name of your database in the server is the same as your username.
 * You are asked to include code that tests the methods of the TaxesApplication class
 * in a similar manner to the sample RunStoresApplication.java program.
 */


public class RunTaxesApplication
{
    public static void main(String[] args) {

        Connection connection = null;
        try {
            //Register the driver
            Class.forName("org.postgresql.Driver");
            // Make the connection.
            // You will need to fill in your real username
            // and password for your Postgres account in the arguments of the
            // getConnection method below.
            connection = DriverManager.getConnection(
                    "jdbc:postgresql://cmps180-db.lt.ucsc.edu/akadixit",
                    "akadixit",
                    "decryption42unique18classification84client");

            if (connection != null)
                System.out.println("Connected to the database!");

            /* Include your code below to test the methods of the TaxesApplication class
             * The sample code in RunStoresApplication.java should be useful.
             * That code tests other methods for a different database schema.
             * Your code below: */
            TaxesApplication taxesApplication = new TaxesApplication(connection);

            //Test 1
            List<Integer> result1 = taxesApplication.getIRSagentsWithManyDelinquents(2);
            for(int i : result1){
                System.out.println(i);
            }
            /* Output of getIRSagentsWithManyDelinquents
             * when the parameter numberOfDelinquents is 2.
             * 110
             * 133
             * 136
             */

            //Test 2
            int result2 = taxesApplication.increaseTaxOwed("843 Ante Ave", 125);
            System.out.println(result2);
            /* Output of increaseTaxOwed when the increment is 125.00
             * 3
             */

            //Test 3
            int result3 = taxesApplication.setAgentForSomeDelinquents("P3E4RR", 1);
            System.out.println(result3);
            /* Output of setAgentForSomeDelinquents when theAgent is 'P3E4RR' and theCount is 1
             * 1
             */

            //Test 4
            int result4 = taxesApplication.setAgentForSomeDelinquents("31AD01", 4);
            System.out.println(result4);
            /* Output of setAgentForSomeDelinquents when theAgent is '31AD01' and theCount is 4
             * 3
             */
        }
        catch (SQLException | ClassNotFoundException e) {
            System.out.println("Error while connecting to database: " + e);
            e.printStackTrace();
        }
        finally {
            if (connection != null) {
                // Closing Connection
                try {
                    connection.close();
                } catch (SQLException e) {
                    System.out.println("Failed to close connection: " + e);
                    e.printStackTrace();
                }
            }
        }
    }
}