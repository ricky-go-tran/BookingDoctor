import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["homepage"];
  navbar() {
    let menu = this.homepageTarget;
    if (menu.style.display == "none") {
      menu.style.display = "block";
    } else {
      menu.style.display = "none";
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
