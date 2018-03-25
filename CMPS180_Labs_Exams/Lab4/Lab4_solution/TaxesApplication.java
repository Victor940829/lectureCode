import java.sql.*;
import java.util.*;

/**
 * The class implements methods of the Taxes database interface.
 *
 * All methods of the class receive a Connection object through which all
 * communication to the database should be performed. Note: the
 * Connection object should not be closed by any method.
 *
 * Also, no method should throw any exceptions. In particular, in case
 * an error occurs in the database, then the method should print an
 * error message and call System.exit(-1);
 */

public class TaxesApplication {

    private Connection connection;

    /*
     * Constructor
     */
    public TaxesApplication(Connection connection) {
        this.connection = connection;
    }

    public Connection getConnection()
    {
        return connection;
    }

    /**
     * Takes as argument an integer called numberOfDelinquents.
     * Returns the taxpayerID (not the IRSagentID) for each tuple in IRSagents
     * that has at least numberOfDelinquents tuples in Delinquents assigned
     * to that IRSagentID.
     */

    public List<Integer> getIRSagentsWithManyDelinquents(int numberOfDelinquents)
    {
        List<Integer> result = new ArrayList<Integer>();
        // your code here
        String query = "SELECT taxPayerID FROM IRSAgents WHERE IRSAgentID IN " +
                "(SELECT IRSAgentID FROM Delinquents GROUP BY IRSAgentID HAVING COUNT(*) >= ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, numberOfDelinquents);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                result.add(rs.getInt(1));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // end of your code
        return result;
    }


    /**
     * Takes an address and an increment as arguments, and increases the totalTaxOwed
     * of everyone (both individuals and businesses) that has that address by the
     * amount specified in the increment argument.  Of course, there may be many
     * individuals and businesses that have that address.  If no individuals or
     * businesses are at that address, increaseTaxOwed should do nothing.
     * increaseTaxOwed should return the  number of individuals and businesses whose
     * totalTaxOwed was increased by the increment.
     */

    public int increaseTaxOwed(String address, float increment) {
        // your code here; return 0 appears for now to allow this skeleton to compile.
        int result = 0;
        String query1 = "UPDATE Individuals SET totalTaxOwed = totalTaxOwed + ? WHERE address = ?";
        String query2 = "UPDATE Businesses SET totalTaxOwed = totalTaxOwed + ? WHERE address = ?";
        try {
            //Updating Individuals table
            PreparedStatement ps = connection.prepareStatement(query1);
            ps.setFloat(1, increment);
            ps.setString(2, address);
            result = result + ps.executeUpdate();

            //Updating Businesses table
            ps = connection.prepareStatement(query2);
            ps.setFloat(1, increment);
            ps.setString(2, address);
            result = result + ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
        // end of your code
    }


    /**
     * The setAgentForSomeDelinquents method has two parameters, theAgent and
     * theCount, and invokes a stored function assignDelinquents that you will need to
     * implement and store in the database according to the description in the Lab4
     * assignment.
     *
     * The method setAgentForSomeDelinquents should only invoke the stored function
     * assignDelinquents, which does all of the assignment work; do not implement
     * setAgentForSomeDelinquents using a bunch of SQL statements through JDBC.
     *
     * setAgentForSomeDelinquents should return the same integer result as the
     * assignDelinquents stored function.
     */

    public int setAgentForSomeDelinquents(String theAgent, int theCount)
    {
        // There's nothing special about the name storedFunctionResult
        int storedFunctionResult = 0;

        // your code here
        String query = "SELECT assignDelinquents(?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, theAgent);
            ps.setInt(2, theCount);
            ResultSet rs = ps.executeQuery();
            rs.next();
            storedFunctionResult = rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // end of your code
        return storedFunctionResult;

    }

};
