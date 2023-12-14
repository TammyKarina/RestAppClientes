package org.banco.conexion;
import org.banco.entidades.Movimiento;
import org.banco.entidades.Saldo;
import java.sql.*;
import java.util.*;

public class ConexionBDD {
    public static List<Movimiento> ConsultarMovimientos(String idCliente) {
        List<Movimiento> movimientoList = new ArrayList<Movimiento>();
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection conn = obtenerConexion();
            String sql = "{call ConsultarMovimiento(?)}";
            CallableStatement statement = conn.prepareCall(sql);
            statement.setString(1, idCliente);
            statement.execute();

            // Process results
            ResultSet resultSet = statement.getResultSet();
            while (resultSet.next()) {
                Movimiento movimiento = new Movimiento();
                movimiento.setCuenta(resultSet.getString(1));
                movimiento.setFecha(resultSet.getString(2));
                movimiento.setDescripcion(resultSet.getString(3));
                movimiento.setMonto(resultSet.getString(4));
                movimiento.setTipo(resultSet.getString(5));
                movimientoList.add(movimiento);
            }
            // Close connection to database
            conn.close();
            return movimientoList;

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return movimientoList;
    }

    public static Saldo ConsultarSaldos(String idCliente) {
        Saldo saldoCliente = new Saldo();
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection conn = obtenerConexion();
            String sql = "{call ConsultarSaldoActual(?)}";
            CallableStatement statement = conn.prepareCall(sql);
            statement.setString(1, idCliente);
            statement.execute();

            // Process results
            ResultSet resultSet = statement.getResultSet();
            while (resultSet.next()) {
                saldoCliente.setNombre(resultSet.getString(1));
                saldoCliente.setApellido(resultSet.getString(2));
                saldoCliente.setCuenta(resultSet.getString(3));
                saldoCliente.setMonto(resultSet.getString(4));
            }

            // Close connection to database
            conn.close();
            return saldoCliente;

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return saldoCliente;
    }

    private static Connection obtenerConexion() throws SQLException {
        String url = "jdbc:sqlserver://localhost:1433;databaseName=CoreFinancieroInternacional";
        String user = "aylin";
        String password = "colorada1234";
        return DriverManager.getConnection(url,user,password);
    }
}
