package com.studentmarks.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null || !Boolean.TRUE.equals(session.getAttribute("adminLoggedIn"))) {

			response.sendRedirect(request.getContextPath() + "/admin-login");

			return;
		}

		request.getRequestDispatcher("/admin-dashboard.jsp").forward(request, response);
	}
}