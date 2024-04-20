package interfaces;

import java.util.List;

import data.ClaseUtilitaria;
import data.Logins;
import data.Yapes;

public interface IntYape {
	Logins Login(int numero, String clave, String tipoUsr);
	List<Yapes> ListarYapes();
	int obtenerUsuario();
	void cerrarSesion();
	ClaseUtilitaria validarYape(int numero, double monto);
	void yapear(int numero, double monto);
	public String formatearFecha(String OGFecha);
	public String formatearHora(String OGHora);
}
