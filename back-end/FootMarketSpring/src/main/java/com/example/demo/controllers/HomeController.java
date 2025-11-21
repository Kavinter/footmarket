package com.example.demo.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class HomeController {

    @GetMapping("/admin/home")
    public String adminHome() {
        return "admin/AdminHome"; 
    }

    @GetMapping("/manager/home")
    public String managerHome() {
        return "manager/ManagerHome"; 
    }
    

}
