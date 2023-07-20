import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["path"];
  navigate() {
    console.log("Hello")
    window.location.href = this.pathTarget.dataset.content;
  }
}
