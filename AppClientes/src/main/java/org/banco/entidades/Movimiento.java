package org.banco.entidades;

public class Movimiento {
    private String cuenta;
    private String fecha;
    private String descripcion;
    private String monto;
    private String tipo;

    public java.lang.String getCuenta() {
        return cuenta;
    }

    public void setCuenta(java.lang.String cuenta) {
        this.cuenta = cuenta;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(java.lang.String fecha) {
        this.fecha = fecha;
    }

    public java.lang.String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(java.lang.String descripcion) {
        this.descripcion = descripcion;
    }

    public java.lang.String getMonto() {
        return monto;
    }

    public void setMonto(java.lang.String monto) {
        this.monto = monto;
    }

    public java.lang.String getTipo() {
        return tipo;
    }

    public void setTipo(java.lang.String tipo) {
        this.tipo = tipo;
    }
}
