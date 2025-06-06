package interfaces;

import java.util.List;

import data.ClaseUtilitaria;
import data.Logins;
import data.Yapes;

public interface IntYape {
	Logins Login(int numero, String clave, String tipoUsr);
	List<Yapes> ListarYapes();
	List<Yapes> ListarTodosLosYapes();
	List<Logins> ListarUsuarios();
	int obtenerUsuario();
	String obtenerTipoUsuario();
	void cerrarSesion();
	ClaseUtilitaria validarYape(int numero, double monto);
	boolean validarYapeEditar(int numeroRec, int numeroRem, double monto, double OGmonto);
	void editarYape(int id, int numeroRec, int numeroRem, double monto, double OGmonto);
	void eliminarYape(int id, int numeroRec, int numeroRem, double OGmonto);
	public void eliminarUsuario(int id);
	Logins obtenerInformacionUsuario(int id);
	void editarUsuario(int id, String nombreApe, double saldo, String clave);
	void yapear(int numero, double monto);
	ClaseUtilitaria obtenerInformacionYape(int id);
	public String formatearFecha(String OGFecha);
	public String formatearHora(String OGHora);
}
