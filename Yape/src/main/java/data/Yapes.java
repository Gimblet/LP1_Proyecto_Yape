package data;

public class Yapes {
	private int IdYape, NumeroRealizante, NumeroRecibiente;
	private double Monto;
	private String Fecha, Hora, Estado;
	
	public int getIdYape() {
		return IdYape;
	}
	public void setIdYape(int idYape) {
		IdYape = idYape;
	}
	public int getNumeroRealizante() {
		return NumeroRealizante;
	}
	public void setNumeroRealizante(int numeroRealizante) {
		NumeroRealizante = numeroRealizante;
	}
	public int getNumeroRecibiente() {
		return NumeroRecibiente;
	}
	public void setNumeroRecibiente(int numeroRecibiente) {
		NumeroRecibiente = numeroRecibiente;
	}
	public double getMonto() {
		return Monto;
	}
	public void setMonto(double monto) {
		Monto = monto;
	}
	public String getFecha() {
		return Fecha;
	}
	public void setFecha(String fecha) {
		Fecha = fecha;
	}
	public String getHora() {
		return Hora;
	}
	public void setHora(String hora) {
		Hora = hora;
	}
	public String getEstado() {
		return Estado;
	}
	public void setEstado(String estado) {
		Estado = estado;
	}
}
