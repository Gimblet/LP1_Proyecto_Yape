<%@page import="gestion.Metodos"%>
<%@ page import="java.util.List"%>
<%@ page import="data.Yapes"%>
<%@ page import="data.Logins"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
List<Logins> userList = (List<Logins>) request.getAttribute("ListaUsuarios");
Metodos metodo = new Metodos();
%>
<!DOCTYPE html>
<html>

<head>
<meta charset="ISO-8859-1">
<title>HeadAdmin Dashboard</title>
<link href="Resources/bootstrap.min.css" rel="stylesheet">
<style>
body{
	background-color: purple;
}

main{
	background-color: white;
	margin: auto;
	margin-top: 80px;
	margin-bottom: 65px;
}

#btn-group{
	padding: 45px 60px 0px 60px;
}

#table-group{
	padding: 0px 80px 30px 80px;
}

.buscarContainer {
	display: flex;
	gap: 12px;
}

form {
	display: flex;
	margin: 25px 120px auto 120px;
	gap: 20px;
}

#buscar {
	margin-left: auto;
}

input:hover {
	cursor: pointer;
}
</style>
</head>

<body>
	<div class="container">
		<main class="border rounded">
			<section id="btn-group">
				<div>
					<h1>Hola, <%= metodo.obtenerNombre() %></h1>
					<form action="Servlet" method="post">
						<input class="btn btn-primary" type="submit" value="Nuevo Usuario" name="type"> 
						<input class="btn btn-primary" type="submit" value="Mostrar Usuarios" name="type"> 
						<input class="btn btn-secondary" id="buscar" type="submit" value="Cerrar Sesion" name="type">
					</form>
					<br>
				</div>
			</section>
			<section id="table-group">
				<table class="table table-hover table-striped border rounded">
					<thead class="table-primary">
						<tr>
							<th>IdUsuario</th>
							<th>Tipo de Usuario</th>
							<th>Nombres Y Apellidos</th>
							<th>Saldo</th>
							<th>Numero</th>
							<th>Clave</th>
							<th>Acciones</th>
						</tr>
					</thead>
					<tbody>
						<%
						if (userList != null) {
							for (Logins item : userList) {
						%>
						<tr>
							<td><%=item.getIdUsuario()%></td>
							<td><%=item.getTipoUsuario()%></td>
							<td><%=item.getNombreApellidos()%></td>
							<td><%=item.getSaldo()%></td>
							<td><%=item.getNumero()%></td>
							<td><%=item.getClave()%></td>
							<td>
								<a title="Editar" href="Servlet?type=Buscar Usuario a Editar&id=<%=item.getIdUsuario()%>">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-file-earmark-medical-fill" viewBox="0 0 16 16">
  										<path d="M9.293 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4.707A1 1 0 0 0 13.707 4L10 .293A1 1 0 0 0 9.293 0M9.5 3.5v-2l3 3h-2a1 1 0 0 1-1-1m-3 2v.634l.549-.317a.5.5 0 1 1 .5.866L7 7l.549.317a.5.5 0 1 1-.5.866L6.5 7.866V8.5a.5.5 0 0 1-1 0v-.634l-.549.317a.5.5 0 1 1-.5-.866L5 7l-.549-.317a.5.5 0 0 1 .5-.866l.549.317V5.5a.5.5 0 1 1 1 0m-2 4.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1 0-1m0 2h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1 0-1" />
  									</svg></a>
  									
								<a title="Eliminar" href="Servlet?type=Eliminar Usuario&id=<%=item.getIdUsuario()%>">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="red" class="bi bi-x-square-fill" viewBox="0 0 16 16">
  										<path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm3.354 4.646L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 1 1 .708-.708" />
									</svg></a>
							</td>
						</tr>
						<%
						}
						}
						%>
					</tbody>
				</table>
			</section>
		</main>
	</div>
</body>

</html>