import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["navbar"];
  navbar() {
    let menu = document.getElementById("navbar-menu-wrapper");
    let isDesktop = menu.classList.contains("menu-wrapper");
    if (isDesktop) {
      menu.classList.remove("menu-wrapper");
      menu.classList.add("menu-wrapper-mobile");
    } else {
      menu.classList.remove("menu-wrapper-mobile");
      menu.classList.add("menu-wrapper");
    }
  }
  navbar_clinic() {
    let menu = document.getElementById("clinic-navbar-wrapper");
    if (menu.style.display == "none") {
      menu.style.display = "flex";
    } else {
      menu.style.display = "none";
    }
  }

  patient_clinic() {
    let menu = document.getElementById("patient-navbar-wrapper");
    if (menu.style.display == "none") {
      menu.style.display = "flex";
    } else {
      menu.style.display = "none";
    }
  }
  admin() {
    let menu = document.getElementById("admin-navbar-wrapper");
    if (menu.style.display == "none") {
      menu.style.display = "flex";
    } else {
      menu.style.display = "none";
    }
  }
}
