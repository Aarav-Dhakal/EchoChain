package com.ecochain.organization.controller;

import com.ecochain.listing.model.Listing;
import com.ecochain.listing.model.dao.ListingDao;
import com.ecochain.organization.model.Organization;
import com.ecochain.organization.model.dao.OrganizationDao;
import com.ecochain.user.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/organization/*")
public class OrganizationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equals("organization")) {
            resp.sendRedirect("/login");
            return;
        }

        String path = req.getPathInfo();

        try {
            Organization org = OrganizationDao.fetchOrganizationByUserId(user.getId());

            if (org == null && !"/complete-profile".equals(path)) {
                resp.sendRedirect("/organization/complete-profile");
                return;
            }

            if ("/dashboard".equals(path)) {
                int totalRequests = OrganizationDao.getTotalRequests(org.getId());
                int completedPickups = OrganizationDao.getCompletedPickups(org.getId());
                req.setAttribute("org", org);
                req.setAttribute("totalRequests", totalRequests);
                req.setAttribute("completedPickups", completedPickups);
                req.getRequestDispatcher("/pages/organization/dashboard.jsp").forward(req, resp);

            } else if ("/browse".equals(path)) {
                List<Listing> listings = ListingDao.fetchAllAvailableListings();
                req.setAttribute("listings", listings);
                req.getRequestDispatcher("/pages/organization/browse-listings.jsp").forward(req, resp);

            } else if ("/complete-profile".equals(path)) {
                req.getRequestDispatcher("/pages/organization/complete-profile.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/pages/organization/dashboard.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equals("organization")) {
            resp.sendRedirect("/login");
            return;
        }

        String action = req.getParameter("action");

        try {
            if ("completeProfile".equals(action)) {
                String orgName = req.getParameter("orgName");
                String address = req.getParameter("address");
                String phone = req.getParameter("phone");
                String areaOfService = req.getParameter("areaOfService");
                String regCertificate = req.getParameter("regCertificate");

                Organization org = new Organization();
                org.setUserId(user.getId());
                org.setOrgName(orgName);
                org.setAddress(address);
                org.setPhone(phone);
                org.setAreaOfService(areaOfService);
                org.setRegCertificate(regCertificate);

                boolean result = OrganizationDao.insertOrganization(org);
                if (result) {
                    resp.sendRedirect("/organization/dashboard");
                } else {
                    req.setAttribute("error", "Failed to save profile.");
                    req.getRequestDispatcher("/pages/organization/complete-profile.jsp").forward(req, resp);
                }
            }

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/pages/organization/complete-profile.jsp").forward(req, resp);
        }
    }
}
