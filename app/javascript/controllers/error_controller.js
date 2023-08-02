import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["close"];
  hiddenPanel () {
    this.closeTarget.style.display = "none"
  }
}
