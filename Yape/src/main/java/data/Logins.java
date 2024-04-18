package data;

public class Logins {
	private int IdUsuario, Numero;
	private double Saldo;
	private String TipoUsuario, NombreApellidos, Clave;
	
	public int getIdUsuario() {
		return IdUsuario;
	}
	public void setIdUsuario(int idUsuario) {
		IdUsuario = idUsuario;
	}
	public int getNumero() {
		return Numero;
	}
	public void setNumero(int numero) {
		Numero = numero;
	}
	public double getSaldo() {
		return Saldo;
	}
	public void setSaldo(double saldo) {
		Saldo = saldo;
	}
	public String getTipoUsuario() {
		return TipoUsuario;
	}
	public void setTipoUsuario(String tipoUsuario) {
		TipoUsuario = tipoUsuario;
	}
	public String getNombreApellidos() {
		return NombreApellidos;
	}
	public void setNombreApellidos(String nombreApellidos) {
		NombreApellidos = nombreApellidos;
	}
	public String getClave() {
		return Clave;
	}
	public void setClave(String clave) {
		Clave = clave;
	}
}
