package org.banco.internacional;
import com.google.gson.Gson;
import org.banco.entidades.Movimiento;
import org.banco.entidades.Saldo;

import java.util.*;
import java.lang.*;

import static org.banco.conexion.ConexionBDD.ConsultarMovimientos;
import static org.banco.conexion.ConexionBDD.ConsultarSaldos;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {
        System.out.println("-----------------------------------------------------------------------");
        System.out.println(consultarMovimientos("001384529"));
        System.out.println("-----------------------------------------------------------------------");
        System.out.println(consultarSaldo("001384529"));
        System.out.println("-----------------------------------------------------------------------");
        System.out.println(consultarMovimientos("008283819"));
        System.out.println("-----------------------------------------------------------------------");
        System.out.println(consultarSaldo("008283819"));
    }

    public static String consultarMovimientos(String idCliente){
        List<Movimiento> movimientoList;
        movimientoList = ConsultarMovimientos(idCliente);
        String jsonList = new Gson().toJson(movimientoList);
        return jsonList;
    }
    public static String consultarSaldo(String idCliente){
        Saldo saldoDetalle;
        saldoDetalle = ConsultarSaldos(idCliente);
        String jsonDetalle = new Gson().toJson(saldoDetalle);
        return jsonDetalle;
    }
}