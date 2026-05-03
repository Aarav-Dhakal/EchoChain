package com.ecochain.donor.controller;

import com.ecochain.donor.model.Donor;
import com.ecochain.donor.model.dao.DonorDao;
import com.ecochain.user.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/donor/*")
public class DonorServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equals("donor")) {
            resp.sendRedirect("/login");
            return;
        }

        String path = req.getPathInfo();

        try {
            Donor donor = DonorDao.fetchDonorByUserId(user.getId());

            if (donor == null && !"/complete-profile".equals(path)) {
                resp.sendRedirect("/donor/complete-profile");
                return;
            }

            if ("/dashboard".equals(path)) {
                int totalListings = DonorDao.getTotalListings(donor.getId());
                int totalPickups = DonorDao.getTotalPickups(donor.getId());
                req.setAttribute("donor", donor);
                req.setAttribute("totalListings", totalListings);
                req.setAttribute("totalPickups", totalPickups);
                req.getRequestDispatcher("/pages/donor/dashboard.jsp").forward(req, resp);

            } else if ("/complete-profile".equals(path)) {
                req.getRequestDispatcher("/pages/donor/complete-profile.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/pages/donor/dashboard.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equals("donor")) {
            resp.sendRedirect("/login");
            return;
        }

        String action = req.getParameter("action");

        try {
            if ("completeProfile".equals(action)) {
                String businessName = req.getParameter("businessName");
                String address = req.getParameter("address");
                String licenseNumber = req.getParameter("licenseNumber");
                String phone = req.getParameter("phone");

                Donor donor = new Donor();
                donor.setUserId(user.getId());
                donor.setBusinessName(businessName);
                donor.setAddress(address);
                donor.setLicenseNumber(licenseNumber);
                donor.setPhone(phone);

                boolean result = DonorDao.insertDonor(donor);
                if (result) {
                    resp.sendRedirect("/donor/dashboard");
                } else {
                    req.setAttribute("error", "Failed to save profile.");
                    req.getRequestDispatcher("/pages/donor/complete-profile.jsp").forward(req, resp);
                }
            }

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/pages/donor/complete-profile.jsp").forward(req, resp);
        }
    }
}
