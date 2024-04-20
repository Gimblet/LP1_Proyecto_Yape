package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.ClaseUtilitaria;
import data.Logins;
import data.Yapes;
import gestion.Metodos;

@WebServlet("/Servlet")
public class Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Servlet() {
        super();
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type = request.getParameter("type");
		switch(type) {
		case "Login"              : loginUsuario(request, response); break;
		case "Nuevo Yapeo"        : request.getRequestDispatcher("Yapear.jsp").forward(request, response); break;
		case "Verificar"          : verificarNumero(request, response); break;
		case "Yapear"             : yapear(request, response); break;
		case "Consultar Saldo"    : consultarSaldo(request, response); break;
		case "Historial de Yapes" : historialYapes(request, response); break;
		case "Buscar Yape"        : buscarYape(request, response); break;
		case "Cerrar Sesion"      : cerrarCurrentLogin(request, response); break;
		default: 
			cerrarCurrentLogin(request, response);
			request.setAttribute("Mensaje", "Ocurrió un Problema con el Type");
			request.getRequestDispatcher("Login.jsp").forward(request, response);
		}
	}
	
	protected void loginUsuario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Metodos metodo = new Metodos();
		int numero = Integer.parseInt(request.getParameter("txtNumero")); 
		String clave = request.getParameter("txtClave");
		String tipoUser = request.getParameter("cboTipoUsuario");
		Logins isUser = metodo.Login(numero, clave, tipoUser);
		if(isUser != null) {
			request.getRequestDispatcher("clientDashboard.jsp").forward(request, response);
		} else {
			System.out.println("Usuario/Contraseña o rol incorrecto");
		}
	}
	
	protected void verificarNumero(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Metodos metodo = new Metodos();
		int numero = Integer.parseInt(request.getParameter("txtNumero"));
		double monto = Double.parseDouble(request.getParameter("txtMonto"));
		ClaseUtilitaria respuesta = metodo.validarYape(numero, monto);
		request.setAttribute("ValidacionYape", respuesta);
		request.getRequestDispatcher("Yapear.jsp").forward(request, response);
	}
	
	protected void yapear(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Metodos metodo = new Metodos();
		int numero = Integer.parseInt(request.getParameter("txtNumero"));
		double monto = Double.parseDouble(request.getParameter("txtMonto"));
		metodo.yapear(numero, monto);
		request.getRequestDispatcher("clientDashboard.jsp").forward(request, response);
	}

	
	protected void consultarSaldo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Metodos metodo = new Metodos();
		Logins saldo = metodo.consultarSaldo();
		if(saldo != null) request.setAttribute("saldo", saldo);
		request.getRequestDispatcher("clientDashboard.jsp").forward(request, response);
	}
	
	protected void historialYapes(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Metodos metodo = new Metodos();
		List<Yapes> yapeList = metodo.ListarYapes();
		request.setAttribute("ListaYapes", yapeList);
		request.getRequestDispatcher("clientDashboard.jsp").forward(request, response);
	}
	
	protected void buscarYape(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("YapeInfo.jsp").forward(request, response);
	}

	
	protected void cerrarCurrentLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Metodos metodo = new Metodos();
		metodo.cerrarSesion();
		request.getRequestDispatcher("Login.jsp").forward(request, response);
	}

}
